//
//  OnlineMatch.swift
//  ERS
//
//  Created by Hersh Nagpal on 8/23/24.
//

import Foundation
import SwiftUI
import GameKit

@MainActor
class OnlineMatch: NSObject, ObservableObject {
    @Published var game = Game()
    
    // The game interface state.
    @Published var matchAvailable = false
    @Published var playingGame = false
    @Published var myMatch: GKMatch? = nil
    @Published var automatch = false
    @Published var opponent: GKPlayer? = nil
    
    var rootViewController: UIViewController? {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        return windowScene?.windows.first?.rootViewController
    }
    
    var myName: String {
        GKLocalPlayer.local.displayName
    }
    
    var opponentName: String {
        opponent?.displayName ?? "Invitation Pending"
    }
    
    func resetMatch() {
        // Reset the game data.
        playingGame = false
        myMatch?.disconnect()
        myMatch?.delegate = nil
        myMatch = nil
        opponent = nil
        GKAccessPoint.shared.isActive = true
        game = Game()
    }
    
    func sendGameData() {
        do {
            let data = game.getGameData().encode()
            try myMatch?.sendData(toAllPlayers: data!, with: GKMatch.SendDataMode.reliable)
        } catch {
            print("Error: \(error.localizedDescription).")
        }
    }
}
