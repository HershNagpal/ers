//
//  Game.swift
//  ERS
//
//  Created by Hersh Nagpal on 3/20/23.
//

import Foundation
import SwiftUI

@MainActor
class Game: NSObject, ObservableObject {
    var deck1: Deck
    var deck2: Deck
    var countdown: Int
    var currentPlayer: PlayerNumber
    var stackClaimSlap: PlayerNumber
    @Published var localPlayer: PlayerNumber
    @Published var stack: [Card]
    @Published var burnPile: [Card]
    @Published var winner: PlayerNumber
    @Published var numTurns: Int
    let asm = AppStorageManager() // TODO: Fix this
    
    func getGameData() -> GameData {
        GameData(
            deck1: deck1, 
            deck2: deck2,
            currentPlayer: currentPlayer
        )
    }
    
    init(gameData: GameData, localPlayer: PlayerNumber) {
        deck1 = gameData.deck1
        deck2 = gameData.deck2
        currentPlayer = gameData.currentPlayer
        self.localPlayer = localPlayer
        stack = []
        burnPile = []
        stackClaimSlap = .none
        numTurns = 0
        winner = .none
        countdown = -1
    }
    
    init(localPlayer: PlayerNumber) {
        deck1 = Deck(player: .one)
        deck2 = Deck(player: .two)
        stack = []
        burnPile = []
        winner = .none
        countdown = -1
        currentPlayer = .one
        stackClaimSlap = .none
        numTurns = 0
        deck1.shuffle()
        deck2.shuffle()
        self.localPlayer = localPlayer
    }
    
    override init() {
        deck1 = Deck(player: .one)
        deck2 = Deck(player: .two)
        stack = []
        burnPile = []
        winner = .none
        countdown = -1
        currentPlayer = .one
        stackClaimSlap = .none
        numTurns = 0
        deck1.shuffle()
        deck2.shuffle()
        localPlayer = .one
    }
    
    func deal(_ player: PlayerNumber) {
        guard !checkVictory() else { return }
        guard player == currentPlayer && stackClaimSlap == .none else {
            burnCards(player)
            return
        }
        guard let card = drawCard(player) else { return }
        
        if countdown == -1 {
            stack.insert(card, at: 0)
            numTurns += 1
            swapCurrentPlayer()
            if let index = [.jack, .queen, .king, .ace].firstIndex(of: card.value) {
                countdown = index
            }
        } else if countdown == 0 {
            stack.insert(card, at: 0)
            numTurns += 1
            if let index = [.jack, .queen, .king, .ace].firstIndex(of: card.value) {
                countdown = index
                swapCurrentPlayer()
            } else {
                stackClaimSlap = player == .one ? .two : .one
            }
        } else if countdown > 0 {
            if let index = [.jack, .queen, .king, .ace].firstIndex(of: card.value) {
                countdown = index
                swapCurrentPlayer()
            } else {
                countdown -= 1
            }
            stack.insert(card, at: 0)
            numTurns += 1
        }
    }
    
    private func drawCard(_ player: PlayerNumber) -> Card? {
        guard !checkVictory() else { return nil }
        guard let card = player == .one ? deck1.draw() : deck2.draw() else { return nil }
        return card
    }
    
    private func swapCurrentPlayer() {
        currentPlayer = currentPlayer == .one ? .two : .one
    }
    
    func slap(_ player: PlayerNumber) -> Bool {
        guard stack.count > 0 else { return false }
        if isValidSlap(player) {
            stack.append(contentsOf: burnPile)
            player == .one
                ? deck1.addCards(stack)
                : deck2.addCards(stack)
            stack.removeAll()
            burnPile.removeAll()
            stackClaimSlap = .none
            currentPlayer = player
            countdown = -1
            return true
        }
        burnCards(player, amount: asm.burnAmount)
        return false
    }
    
    func isValidSlap(_ player: PlayerNumber) -> Bool {
        return isDoubles() || isCouples() || isDivorce() || isSandwich() ||
            isQueenOfDeath() || isTopAndBottom() || isAddToTen() || isSequence()
            || player == stackClaimSlap
    }
    
    func restart() {
        self.deck1 = Deck(player: .one)
        self.deck2 = Deck(player: .two)
        stack = []
        burnPile = []
        winner = .none
        countdown = -1
        currentPlayer = .one
        stackClaimSlap = .none
        numTurns = 0
        deck1.shuffle()
        deck2.shuffle()
    }
    
    private func burnCards(_ player: PlayerNumber, amount: Int = 1) {
        guard !checkVictory() else { return }
        if player == .one {
            guard deck1.numCards() >= amount else {
                deck1.discard(deck1.numCards())
                let _ = checkVictory()
                return
            }
            for _ in 1...amount {
                burnPile.append(deck1.draw()!)
            }
        } else if player == .two {
            guard deck2.numCards() >= amount else {
                deck2.discard(deck1.numCards())
                let _ = checkVictory()
                return
            }
            for _ in 1...amount {
                burnPile.append(deck2.draw()!)
            }
        }
    }
    
    private func isDoubles() -> Bool {
        guard asm.doublesOn else { return false }
        guard stack.count > 1 else { return false }
        return stack[0].value == stack[1].value
    }
    
    private func isCouples() -> Bool {
        guard asm.couplesOn else { return false }
        guard stack.count > 1 else { return false }
        if stack[0].value == .queen && stack[1].value == .king {
            return true
        } else if stack[1].value == .queen && stack[0].value == .king {
            return true
        }
        return false
    }
    
    private func isSandwich() -> Bool {
        guard asm.sandwichOn else { return false }
        guard stack.count > 2 else { return false }
        return stack[0].value == stack[2].value
    }
    
    private func isDivorce() -> Bool {
        guard asm.divorceOn else { return false }
        guard stack.count > 2 else { return false }
        if stack[0].value == .queen && stack[2].value == .king {
            return true
        } else if stack[2].value == .queen && stack[0].value == .king {
            return true
        }
        return false
    }
    
    private func isQueenOfDeath() -> Bool {
        guard asm.queenOfDeathOn else { return false }
        guard stack.count > 0 else { return false }
        return stack[0].value == .queen && stack[0].suit == .hearts
    }
    
    private func isTopAndBottom() -> Bool {
        guard asm.topAndBottomOn else { return false }
        guard stack.count > 1 else { return false }
        if stack.first!.value == stack.last!.value {
            return true
        }
        return false
    }
    
    private func isAddToTen() -> Bool {
        guard asm.addToTenOn else { return false }
        if stack.count >= 2 {
            if stack[0].value.rawValue + stack[1].value.rawValue == 10 {
                return true
            }
        }
        if stack.count >= 3 {
            if stack[0].value.rawValue + stack[1].value.rawValue + stack[2].value.rawValue == 10 {
                return true
            }
        }
        
        return false
    }
    
    private func isSequence() -> Bool {
        guard asm.sequenceOn else { return false }
        guard stack.count >= 3 else { return false }
        if stack[0].value.rawValue+1 == stack[1].value.rawValue && stack[1].value.rawValue+1 == stack[2].value.rawValue {
            return true
        } else if stack[2].value.rawValue+1 == stack[1].value.rawValue && stack[1].value.rawValue+1 == stack[0].value.rawValue {
            return true
        }
        
        return false
    }
    
    private func checkVictory() -> Bool {
        if deck1.numCards() < 1 || deck2.numCards() > 51 {
            winner = .two
            return true
        } else if deck2.numCards() < 1 || deck1.numCards() > 51 {
            winner = .one
            return true
        }
        return false
    }
}

