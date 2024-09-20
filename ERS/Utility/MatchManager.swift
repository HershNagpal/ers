//
//  MatchManager.swift
//  ERS
//
//  Created by Hersh Nagpal on 9/19/24.
//

import Foundation
import SwiftUI
import GameKit

@MainActor
class MatchManager: NSObject, ObservableObject {
    @Published var game: Game?
    @Published var myMatch: GKMatch? = nil
    @Published var localPlayerNumber: PlayerNumber = .none
    @Published var rulesPlayer: PlayerNumber = .none
    @ObservedObject var navManager: NavigationManager
    @ObservedObject var asm: AppStorageManager
    
    var rootViewController: UIViewController? {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        return windowScene?.windows.first?.rootViewController
    }
    
    init(asm: AppStorageManager, navManager: NavigationManager) {
        self.game = nil
        self.myMatch = nil
        self.localPlayerNumber = .none
        self.rulesPlayer = .none
        self.asm = asm
        self.navManager = navManager
    }
    
}
