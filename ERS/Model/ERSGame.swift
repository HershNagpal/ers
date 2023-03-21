//
//  ERSGame.swift
//  ERS
//
//  Created by Hersh Nagpal on 3/20/23.
//

import Foundation

class ERSGame: ObservableObject {
    @Published var deck1: Deck
    @Published var deck2: Deck
    @Published var stack: [Card]
    @Published var drawHistory: [Card]
    @Published var winner: PlayerNumber
    @Published var currentPlayer: PlayerNumber
    
    init() {
        self.deck1 = Deck(player: .one)
        self.deck2 = Deck(player: .two)
        stack = []
        drawHistory = []
        winner = .none
        currentPlayer = .one
        deck1.shuffle()
        deck2.shuffle()
    }
    
    func drawCard() {
        currentPlayer == .one
            ? stack.insert(deck1.draw()!, at: 0)
            : stack.insert(deck1.draw()!, at: 0)
    }
    
    func takeTurn() -> Void {
        guard winner == .none
        else { return }
        checkVictory()
    }
    
    func checkVictory() {
        if deck1.numCards() < 1 || deck2.numCards() > 51 {
            winner = .two
        } else if deck2.numCards() < 1 || deck1.numCards() > 51 {
            winner = .one
        }
    }
}

enum PlayerNumber: String {
    case one, two, none
}
