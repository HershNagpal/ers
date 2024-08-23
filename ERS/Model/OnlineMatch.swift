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
    @Published var opponentAvatar: Image? = nil
    
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
    
    /// Starts a match.
    /// - Parameter match: The object that represents the real-time match.
    /// - Tag:startMyMatchWith
    func startMyMatchWith(match: GKMatch) {
        GKAccessPoint.shared.isActive = false
        playingGame = true
        myMatch = match
        myMatch?.delegate = self
        
        // For automatch, check whether the opponent connected to the match before loading the avatar.
        if myMatch?.expectedPlayerCount == 0 {
            opponent = myMatch?.players[0]
            
            // Load the opponent's avatar.
            opponent?.loadPhoto(for: GKPlayer.PhotoSize.small) { (image, error) in
                if let image {
                    self.opponentAvatar = Image(uiImage: image)
                }
                if let error {
                    print("Error: \(error.localizedDescription).")
                }
            }
        }
    }
    
    func sendGameData() {
        do {
            let data = game.getGameData().encode()
            try myMatch?.sendData(toAllPlayers: data!, with: GKMatch.SendDataMode.reliable)
        } catch {
            print("Error: \(error.localizedDescription).")
        }
    }
    
    /// Cleans up the view's state when the local player closes the dashboard.
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        // Dismiss the view controller.
        gameCenterViewController.dismiss(animated: true)
    }
}

// MARK: GKMatchmakerViewControllerDelegate

extension OnlineMatch: GKMatchmakerViewControllerDelegate {
    /// Dismisses the matchmaker interface and starts the game when a player accepts an invitation.
    func matchmakerViewController(_ viewController: GKMatchmakerViewController,
                                  didFind match: GKMatch) {
        // Dismiss the view controller.
        viewController.dismiss(animated: true) { }
        
        // Start the game with the player.
        if !playingGame && match.expectedPlayerCount == 0 {
            startMyMatchWith(match: match)
        }
    }
    
    /// Dismisses the matchmaker interface when either player cancels matchmaking.
    func matchmakerViewControllerWasCancelled(_ viewController: GKMatchmakerViewController) {
        viewController.dismiss(animated: true)
    }
    
    /// Reports an error during the matchmaking process.
    func matchmakerViewController(_ viewController: GKMatchmakerViewController, didFailWithError error: Error) {
        print("\n\nMatchmaker view controller fails with error: \(error.localizedDescription)")
    }
}

// MARK: GKLocalPlayerListener

extension OnlineMatch: GKLocalPlayerListener {
    /// Handles when the local player sends requests to start a match with other players.
    func player(_ player: GKPlayer, didRequestMatchWithRecipients recipientPlayers: [GKPlayer]) {
        print("\n\nSending invites to other players.")
    }
    
    /// Presents the matchmaker interface when the local player accepts an invitation from another player.
    func player(_ player: GKPlayer, didAccept invite: GKInvite) {
        // Present the matchmaker view controller in the invitation state.
        if let viewController = GKMatchmakerViewController(invite: invite) {
            viewController.matchmakerDelegate = self
            rootViewController?.present(viewController, animated: true) { }
        }
    }
}

// MARK: GKMatchDelegate

extension OnlineMatch: GKMatchDelegate {
    /// Handles a connected, disconnected, or unknown player state.
    /// - Tag:didChange
    func match(_ match: GKMatch, player: GKPlayer, didChange state: GKPlayerConnectionState) {
        switch state {
        case .connected:
            print("\(player.displayName) Connected")
            
            // For automatch, set the opponent and load their avatar.
            if match.expectedPlayerCount == 0 {
                opponent = match.players[0]
                
                // Load the opponent's avatar.
                opponent?.loadPhoto(for: GKPlayer.PhotoSize.small) { (image, error) in
                    if let image {
                        self.opponentAvatar = Image(uiImage: image)
                    }
                    if let error {
                        print("Error: \(error.localizedDescription).")
                    }
                }
            }
        case .disconnected:
            print("\(player.displayName) Disconnected")
        default:
            print("\(player.displayName) Connection Unknown")
        }
    }
    
    /// Handles an error during the matchmaking process.
    func match(_ match: GKMatch, didFailWithError error: Error?) {
        print("\n\nMatch object fails with error: \(error!.localizedDescription)")
    }

    /// Reinvites a player when they disconnect from the match.
    func match(_ match: GKMatch, shouldReinviteDisconnectedPlayer player: GKPlayer) -> Bool {
        return false
    }
}
