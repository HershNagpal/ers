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
    var stackClaimSlap: PlayerNumber
    @Published var stack: [Card]
    @Published var burnPile: [Card]
    @Published var winner: PlayerNumber
    
    let doublesOn: Bool = UserDefaults.standard.bool(forKey: "doublesOn")
    let sandwichOn: Bool = UserDefaults.standard.bool(forKey: "sandwichOn")
    let couplesOn: Bool = UserDefaults.standard.bool(forKey: "couplesOn")
    let divorceOn: Bool = UserDefaults.standard.bool(forKey: "divorceOn")
    let queenOfDeathOn: Bool = UserDefaults.standard.bool(forKey: "queenOfDeathOn")
    let burnAmount: Int = UserDefaults.standard.integer(forKey: "burnAmount")
    
    init() {
        self.deck1 = Deck(player: .one)
        self.deck2 = Deck(player: .two)
        stack = []
        burnPile = []
        winner = .none
        countdown = -1
        currentPlayer = .one
        stackClaimSlap = .none
        deck1.shuffle()
        deck2.shuffle()
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
            swapCurrentPlayer()
            if let index = [.jack, .queen, .king, .ace].firstIndex(of: card.value) {
                countdown = index
            }
        } else if countdown == 0 {
            stack.insert(card, at: 0)
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
    
    func slap(_ player: PlayerNumber) {
        if isDoubles() || isCouples() || isDivorce() || isSandwich() ||
            isQueenOfDeath() || player == stackClaimSlap {
            stack.append(contentsOf: burnPile)
            player == .one
                ? deck1.addCards(stack)
                : deck2.addCards(stack)
            stack.removeAll()
            burnPile.removeAll()
            stackClaimSlap = .none
            currentPlayer = player
            countdown = -1
            return
        }
        burnCards(player, amount: burnAmount)
    }
    
    private func burnCards(_ player: PlayerNumber, amount: Int = 1) {
        guard !checkVictory() else { return }
        if player == .one {
            guard deck1.numCards() > amount else {
                deck1.discard(deck1.numCards())
                let _ = checkVictory()
                return
            }
            for _ in 1...amount {
                burnPile.append(deck1.draw()!)
            }
        } else if player == .two {
            guard deck2.numCards() > amount else {
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
        guard doublesOn else { return false }
        guard stack.count > 1 else { return false }
        return stack[0].value == stack[1].value
    }
    
    private func isCouples() -> Bool {
        guard couplesOn else { return false }
        guard stack.count > 1 else { return false }
        if stack[0].value == .queen && stack[1].value == .king {
            return true
        } else if stack[1].value == .queen && stack[0].value == .king {
            return true
        }
        return false
    }
    
    private func isSandwich() -> Bool {
        guard sandwichOn else { return false }
        guard stack.count > 2 else { return false }
        return stack[0].value == stack[2].value
    }
    
    private func isDivorce() -> Bool {
        guard divorceOn else { return false }
        guard stack.count > 2 else { return false }
        if stack[0].value == .queen && stack[2].value == .king {
            return true
        } else if stack[2].value == .queen && stack[0].value == .king {
            return true
        }
        return false
    }
    
    private func isQueenOfDeath() -> Bool {
        guard queenOfDeathOn else { return false }
        guard stack.count > 0 else { return false }
        return stack[0].value == .queen && stack[0].suit == .hearts
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

enum PlayerNumber: String {
    case one, two, none
}
