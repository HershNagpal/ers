//
//  PurchaseManager.swift
//  ERS
//
//  Created by Hersh Nagpal on 6/5/23.
//

import Foundation
import StoreKit
import SwiftUI

@MainActor
class PurchaseManager: ObservableObject {
    let productIds = ["ersUnlockRules"]
    
    @Published private(set) var products: [Product] = []
    @Published private(set) var purchasedProductIDs = Set<String>()
    
    private var productsLoaded = false
    private var updates: Task<Void, Never>? = nil
    
    @AppStorage("purchasedRules") var purchasedRules: Bool = false
    @AppStorage("rulesWithAds") var rulesWithAds: Bool = false

    func loadProducts() async throws {
        guard !self.productsLoaded else { return }
        self.products = try await Product.products(for: productIds)
        self.productsLoaded = true
    }

    func updatePurchasedProducts() async {
        for await result in Transaction.currentEntitlements {
            guard case .verified(let transaction) = result else {
                continue
            }

            if transaction.revocationDate == nil {
                self.purchasedProductIDs.insert(transaction.productID)
            } else {
                self.purchasedProductIDs.remove(transaction.productID)
            }
        }
        purchasedRules = !self.purchasedProductIDs.isEmpty
    }
    
    init() {
        updates = observeTransactionUpdates()
    }

    deinit {
        updates?.cancel()
    }
    
    private func observeTransactionUpdates() -> Task<Void, Never> {
        Task(priority: .background) { [unowned self] in
            for await _ in Transaction.updates {
                // Using verificationResult directly would be better
                // but this way works for this tutorial
                await self.updatePurchasedProducts()
            }
        }
    }

    func purchase(_ product: Product) async throws {
        let result = try await product.purchase()
        switch result {
            case let .success(.verified(transaction)):
                // Successful purhcase
                await transaction.finish()
                await self.updatePurchasedProducts()
                rulesWithAds = false
            case let .success(.unverified(_, error)):
                // Successful purchase but transaction/receipt can't be verified
                // Could be a jailbroken phone
                print(error)
                break
            case .pending:
                // Transaction waiting on SCA (Strong Customer Authentication) or
                // approval from Ask to Buy
                break
            case .userCancelled:
                // ^^^
                break
            @unknown default:
                break
            }
    }
}
