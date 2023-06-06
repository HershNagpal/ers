//
//  PurchaseManager.swift
//  ERS
//
//  Created by Hersh Nagpal on 6/5/23.
//

import Foundation
import StoreKit

@MainActor
class PurchaseManager: ObservableObject {
    let productIds = ["ersUnlockRules"]
    
    @Published private(set) var products: [Product] = []
    @Published private(set) var purchasedProductIDs = Set<String>()
    
    private var productsLoaded = false
    private var updates: Task<Void, Never>? = nil

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
        UserDefaults.standard.set( self.purchasedProductIDs.isEmpty, forKey: "rulesLocked")
    }
    
    init() {
        updates = observeTransactionUpdates()
        UserDefaults.standard.register(defaults: [
            "easyDeal": true,
            "easyClaim": true,
            "doublesOn": true,
            "sandwichOn": true,
            "couplesOn": true,
            "divorceOn": false,
            "queenOfDeathOn": false,
            "topAndBottomOn": false,
            "addToTenOn": false,
            "sequenceOn": false,
            "difficulty": 1,
            "burnAmount": 1,
            "rulesLocked": true,
        ])
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
