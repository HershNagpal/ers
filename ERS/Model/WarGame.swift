//
//  WarGame.swift
//  ERS
//
//  Created by Hersh Nagpal on 2/7/23.
//

import Foundation

class WarGame: ObservableObject {
    @Published var deck1: Deck
    @Published var deck2: Deck
    @Published var stack: [Card]
    @Published var drawHistory: [Card]
    @Published var winner: PlayerNumber
    
    init() {
        self.deck1 = Deck(player: .one)
        self.deck2 = Deck(player: .two)
        stack = []
        drawHistory = []
        winner = .none
        deck1.shuffle()
        deck2.shuffle()
    }
    
    func takeTurn() -> Void {
        guard winner == .none
        else { return }
        stack.insert(deck1.draw()!, at: 0)
        stack.insert(deck2.draw()!, at: 1)
        drawHistory.insert(contentsOf: stack, at: 0)
        let battle = WarGame.compareValues(stack[0], stack[1])
        if battle != .none {
            battle == .one ? deck1.addCards(stack) : deck2.addCards(stack)
            stack.removeAll()
        }
        checkVictory()
    }
    
    private func addToDrawHistory(_ card: Card) {
        stack.insert(card, at: 0)
    }
    
    func checkVictory() {
        if(deck1.numCards() < 1 || deck2.numCards() > 51) {
            winner = .two
        } else if (deck2.numCards() < 1 || deck1.numCards() > 51) {
            winner = .one
        }
    }
    
    static func compareValues(_ player1Card: Card, _ player2Card: Card) -> PlayerNumber {
        if(player1Card.value.rawValue > player2Card.value.rawValue) {
            return .one
        }
        if(player1Card.value.rawValue < player2Card.value.rawValue) {
            return .one
        }
        return .none
    }
}

enum PlayerNumber: String {
    case one, two, none
}
