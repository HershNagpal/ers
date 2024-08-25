//
//  OnlineMatchManager.swift
//  ERS
//
//  Created by Hersh Nagpal on 8/23/24.
//

import Foundation
import SwiftUI
import GameKit

@MainActor
final class OnlineMatchManager: NSObject, ObservableObject {
    @Published var game: Game?
    @Published var matchAvailable = false
    @Published var playingGame = false
    @Published var myMatch: GKMatch? = nil
    @Published var opponent: GKPlayer? = nil
    @Published var opponentAvatar: Image? = nil
    @Published var localPlayerNumber: PlayerNumber = .none
    @Published var goHome: Bool = false
    @Published var acceptedInvite: Bool = false
    @Published var rulesPlayer: PlayerNumber = .none
    @ObservedObject var asm: AppStorageManager
    
    init( asm: AppStorageManager) {
        self.asm = asm
    }
    
    func resetController() {
//        print("Resetting Match Manager")
        game = nil
        localPlayerNumber = .none
        myMatch = nil
        opponent = nil
        opponentAvatar = nil
        matchAvailable = false
        playingGame = false
    }
    
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
    
    func decode(matchData: Data) -> GameData? {
        // Convert the data object to a game data object.
        return try? PropertyListDecoder().decode(GameData.self, from: matchData)
    }
    
    func decode(actionData: Data) -> GameAction? {
        // Convert the data object to a game data object.
        return try? PropertyListDecoder().decode(GameAction.self, from: actionData)
    }
    
    func decode(rulesData: Data) -> RuleState? {
        // Convert the data object to a game data object.
        return try? PropertyListDecoder().decode(RuleState.self, from: rulesData)
    }
    
    func choosePlayer() {
        // Create a match request.
        let request = GKMatchRequest()
        request.minPlayers = 2
        request.maxPlayers = 2
        
        // If you use matchmaking rules, set the GKMatchRequest.queueName property here. If the rules use
        // game-specific properties, set the local player's GKMatchRequest.properties too.
        
        // Present the interface where the player selects opponents and starts the game.
        if let viewController = GKMatchmakerViewController(matchRequest: request) {
            viewController.matchmakerDelegate = self
//            viewController.matchmakingMode = .inviteOnly
            rootViewController?.present(viewController, animated: true) { }
        }
    }
    
    /// Starts a match.
    /// - Parameter match: The object that represents the real-time match.
    /// - Tag:startMyMatchWith
    func startMyMatchWith(match: GKMatch) {
//        print("Starting Match")
        GKAccessPoint.shared.isActive = false
//        print("playingGame = \(playingGame)")
        myMatch = match
        myMatch?.delegate = self
//        ruleState = asm.saveRuleState()
        asm.online = true
        
        // For automatch, check whether the opponent connected to the match before loading the avatar.
        if myMatch?.expectedPlayerCount == 0 {
            guard let opponent = myMatch?.players[0] else { return }
            
            // Load the opponent's avatar.
            opponent.loadPhoto(for: GKPlayer.PhotoSize.small) { (image, error) in
                if let image {
                    self.opponentAvatar = Image(uiImage: image)
                }
                if let error {
                    print("Error: \(error.localizedDescription).")
                }
            }
        
            if opponent.gamePlayerID < GKLocalPlayer.local.gamePlayerID {
                localPlayerNumber = .two
            } else {
                localPlayerNumber = .one
            }
        }
        
        if localPlayerNumber == .one {
            if Bool.random() {
                print("Won coin toss, sending game.")
                rulesPlayer = localPlayerNumber
                game = Game(ruleState: asm.saveRuleState())
                sendGameData()
                playingGame = true
                print("Playing game")
            } else {
                print("Lost coin toss, requesting game.")
                sendAction(action: .gameRequest, player: localPlayerNumber)
            }
        }
        print("Match loaded as player \(localPlayerNumber.rawValue)")
    }
    
    func sendAction(action: GameAction.Action, player: PlayerNumber) {
        print("Sending Action: \(action):\(player)")
//        guard game != nil else { return }
        do {
            let data = GameAction(action: action, player: player).encode()
            try myMatch?.sendData(toAllPlayers: data!, with: GKMatch.SendDataMode.reliable)
        } catch {
            print("Error: \(error.localizedDescription).")
        }
    }
    
    func sendGameData() {
        print("Sending Game")
        guard let game = game else { return }
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
        print("Dashboard Closed")
        gameCenterViewController.dismiss(animated: true)
        resetController()
        goHome.toggle()
    }
}

extension OnlineMatchManager {
    func authenticatePlayer() {
        // Set the authentication handler that GameKit invokes.
        GKLocalPlayer.local.authenticateHandler = { viewController, error in
            if let viewController = viewController {
                // If the view controller is non-nil, present it to the player so they can
                // perform some necessary action to complete authentication.
                self.rootViewController?.present(viewController, animated: true) { }
                return
            }
            if let error {
                // If you can’t authenticate the player, disable Game Center features in your game.
                print("Error: \(error.localizedDescription).")
                return
            }
            
            // Register for real-time invitations from other players.
            GKLocalPlayer.local.register(self)
        }
    }
}

// MARK: GKMatchmakerViewControllerDelegate

extension OnlineMatchManager: GKMatchmakerViewControllerDelegate {
    /// Dismisses the matchmaker interface and starts the game when a player accepts an invitation.
    func matchmakerViewController(_ viewController: GKMatchmakerViewController,
                                  didFind match: GKMatch) {
        print("Found Match")
        // Dismiss the view controller.
        viewController.dismiss(animated: true) { }
        match.delegate = self
        
        // Start the game with the player.
        if !playingGame && match.expectedPlayerCount == 0 {
            startMyMatchWith(match: match)
        }
    }
    
    /// Dismisses the matchmaker interface when either player cancels matchmaking.
    func matchmakerViewControllerWasCancelled(_ viewController: GKMatchmakerViewController) {
        print("Controller Cancelled")
        viewController.dismiss(animated: true)
        resetController()
        goHome.toggle()
    }
    
    /// Reports an error during the matchmaking process.
    func matchmakerViewController(_ viewController: GKMatchmakerViewController, didFailWithError error: Error) {
        print("\n\nMatchmaker view controller fails with error: \(error.localizedDescription)")
    }
}

// MARK: GKLocalPlayerListener

extension OnlineMatchManager: GKLocalPlayerListener {
    /// Handles when the local player sends requests to start a match with other players.
    func player(_ player: GKPlayer, didRequestMatchWithRecipients recipientPlayers: [GKPlayer]) {
        print("\n\nSending invites to other players.")
    }
    
    /// Presents the matchmaker interface when the local player accepts an invitation from another player.
    func player(_ player: GKPlayer, didAccept invite: GKInvite) {
        print("Accepted Invite")
        // Present the matchmaker view controller in the invitation state.
        if let viewController = GKMatchmakerViewController(invite: invite) {
            viewController.matchmakerDelegate = self
            rootViewController?.present(viewController, animated: true) { }
        }
        acceptedInvite = true
    }
}

// MARK: GKMatchDelegate

extension OnlineMatchManager: GKMatchDelegate {
    /// Handles receiving a message from another player.
    /// - Tag:didReceiveData
    func match(_ match: GKMatch, didReceive data: Data, fromRemotePlayer player: GKPlayer) {
        // Decode the data representation of the game data.
        print("Data Recieved")
        if let gameData = decode(matchData: data) {
            print("Recieved Game")
            self.game = Game(gameData: gameData, localPlayer: localPlayerNumber)
            rulesPlayer = localPlayerNumber == .one ? .two : .one
            playingGame = true
            print("Playing Game")
        } else if let action = decode(actionData: data) {
            print("Recieved Action \(action.player):\(action.action)")
            switch action.action {
            case .deal:
                game?.deal(action.player)
            case .slap:
                let _ = game?.slap(action.player)
            case .forfeit:
                game?.winner = action.player
            case .confetti:
                // TODO: Add
                break
            case .gameRequest:
                game = Game(ruleState: asm.saveRuleState())
                rulesPlayer = localPlayerNumber
                sendGameData()
                playingGame = true
                print("Playing Game")
            }
        }
    }
    
    /// Handles a connected, disconnected, or unknown player state.
    /// - Tag:didChange
    func match(_ match: GKMatch, player: GKPlayer, didChange state: GKPlayerConnectionState) {
//        print("State changed: \(state)")
        switch state {
        case .connected:
//            print("\(player.displayName) Connected")
            
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
//            print("\(player.displayName) Disconnected")
            if let game = game {
                game.winner = localPlayerNumber
            }
        default:
            print("\(player.displayName) Connection Unknown")
        }
    }
    
    /// Handles an error during the matchmaking process.
    func match(_ match: GKMatch, didFailWithError error: Error?) {
        print("\n\nMatch object fails with error: \(error!.localizedDescription)")
        goHome.toggle()
    }

    /// Reinvites a player when they disconnect from the match.
    func match(_ match: GKMatch, shouldReinviteDisconnectedPlayer player: GKPlayer) -> Bool {
        return false
    }
}
