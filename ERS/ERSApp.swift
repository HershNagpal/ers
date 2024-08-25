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
    @StateObject private var onlineMatchManager: OnlineMatchManager
    @State var path = [String]()

    init() {
        let purchaseManager = PurchaseManager()
        self._purchaseManager = StateObject(wrappedValue: purchaseManager)
        
        let asm = AppStorageManager()
        self._asm = StateObject(wrappedValue: asm)
        
        let onlineMatchManager = OnlineMatchManager(asm: asm)
        self._onlineMatchManager = StateObject(wrappedValue: onlineMatchManager)
    }
    
    var body: some Scene {
        WindowGroup {
            HomeView(path: $path)
                .environmentObject(purchaseManager)
                .environmentObject(asm)
                .environmentObject(onlineMatchManager)
                .task {
                    await purchaseManager.updatePurchasedProducts()
                }
                .preferredColorScheme(.dark)
        }
    }
}
