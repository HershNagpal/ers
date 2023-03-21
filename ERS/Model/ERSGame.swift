//
//  ERSGame.swift
//  ERS
//
//  Created by Hersh Nagpal on 3/20/23.
//

import Foundation

class ERSGame: ObservableObject {
    var deck1: Deck
    var deck2: Deck
    var countdown: Int
    var currentPlayer: PlayerNumber
    @Published var stack: [Card]
    @Published var burnPile: [Card]
    @Published var winner: PlayerNumber
    
    init() {
        self.deck1 = Deck(player: .one)
        self.deck2 = Deck(player: .two)
        stack = []
        burnPile = []
        winner = .none
        countdown = 0
        currentPlayer = .one
        deck1.shuffle()
        deck2.shuffle()
    }
    
    func drawCard(_ player: PlayerNumber) {
        guard !checkVictory() else { return }
        player == .one
            ? stack.insert(deck1.draw()!, at: 0)
            : stack.insert(deck2.draw()!, at: 0)
    }
    
    func slap(_ player: PlayerNumber) {
        if isDoubles() || isCouples() || isDivorce() || isSandwich() || isQueenOfDeath() {
            stack.append(contentsOf: burnPile)
            player == .one
                ? deck1.addCards(stack)
                : deck2.addCards(stack)
            stack.removeAll()
            burnPile.removeAll()
            return
        }
        burnCards(player)
    }
    
    func burnCards(_ player: PlayerNumber, amount: Int = 1) {
        guard !checkVictory() else { return }
        player == .one
            ? burnPile.append(deck1.draw() ?? Card(value: .none, suit: .none))
            : burnPile.append(deck2.draw() ?? Card(value: .none, suit: .none))
    }
    
    func isDoubles() -> Bool {
        guard stack.count > 1 else { return false }
        return stack[0].value == stack[1].value
    }
    
    func isCouples() -> Bool {
        guard stack.count > 1 else { return false }
        if stack[0].value == .queen && stack[1].value == .king {
            return true
        } else if stack[1].value == .queen && stack[0].value == .king {
            return true
        }
        return false
    }
    
    func isSandwich() -> Bool {
        guard stack.count > 2 else { return false }
        return stack[0].value == stack[2].value
    }
    
    func isDivorce() -> Bool {
        guard stack.count > 2 else { return false }
        if stack[0].value == .queen && stack[2].value == .king {
            return true
        } else if stack[2].value == .queen && stack[0].value == .king {
            return true
        }
        return false
    }
    
    func isQueenOfDeath() -> Bool {
        guard stack.count > 0 else { return false }
        return stack[0].value == .queen && stack[0].suit == .hearts
    }
    
    func checkVictory() -> Bool {
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

enum PlayerNumber: String {
    case one, two, none
}
