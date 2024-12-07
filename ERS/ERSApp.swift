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
    @StateObject private var asm: AppStorageManager
    @StateObject private var navigationManager: NavigationManager
    @State var path = [String]()

    init() {
        let purchaseManager = PurchaseManager()
        self._purchaseManager = StateObject(wrappedValue: purchaseManager)
        
        let navigationManager = NavigationManager()
        self._navigationManager = StateObject(wrappedValue: navigationManager)
        
        let asm = AppStorageManager()
        self._asm = StateObject(wrappedValue: asm)
    }
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(purchaseManager)
                .environmentObject(asm)
                .environmentObject(navigationManager)
                .task {
                    await purchaseManager.updatePurchasedProducts()
                }
                .preferredColorScheme(.dark)
        }
    }
}
