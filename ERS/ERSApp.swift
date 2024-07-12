//
//  ERSApp.swift
//  ERS
//
//  Created by Hersh Nagpal on 1/19/23.
//

import SwiftUI
import GameKit

@main
struct ERSApp: App {
    @StateObject private var purchaseManager: PurchaseManager

    init() {
        let purchaseManager = PurchaseManager()
        self._purchaseManager = StateObject(wrappedValue: purchaseManager)
    }
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(purchaseManager)
                .environmentObject(HomeViewModel())
                .environmentObject(AppStorageManager())
                .task {
                    await purchaseManager.updatePurchasedProducts()
                }
                .preferredColorScheme(.light)
        }
    }
}
