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
    @StateObject private var achievementManager: AchievementManager

    init() {
        let purchaseManager = PurchaseManager()
        let achievementManager = AchievementManager()
        self._purchaseManager = StateObject(wrappedValue: purchaseManager)
        self._achievementManager = StateObject(wrappedValue: achievementManager)
    }
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(purchaseManager)
                .environmentObject(achievementManager)
                .task {
                    await purchaseManager.updatePurchasedProducts()
                }
                .preferredColorScheme(.light)
        }
    }
}
