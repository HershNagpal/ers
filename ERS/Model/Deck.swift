//
//  Deck.swift
//  ERS
//
//  Created by Hersh Nagpal on 1/19/23.
//

import Combine

class Deck: ObservableObject {
    
    private var deck: [Card]
    
    init() {
        deck = []
        for suit in Suit.allCases {
            for value in Value.allCases {
                deck.append(Card(value: value, suit: suit))
            }
        }
    }
    
    init(_ cards: [Card]) {
        deck = cards
    }
    
    init(player: PlayerNumber) {
        deck = []
        switch player {
            case .one:
                for suit in [Suit.diamonds, Suit.hearts] {
                    for value in Value.allCases {
                        deck.append(Card(value: value, suit: suit))
                    }
                }
                break
            case .two:
                for suit in [Suit.clubs, Suit.spades] {
                    for value in Value.allCases {
                        deck.append(Card(value: value, suit: suit))
                    }
                }
                break
        default:
            print("Wtf no player chosen")
            for suit in [Suit.clubs, Suit.spades] {
                for value in Value.allCases {
                    deck.append(Card(value: value, suit: suit))
                }
            }
        }
    }
    
    func getCards() -> [Card] {
        return deck
    }
    
    func draw() -> Card? {
        guard !deck.isEmpty else { return nil }
        return deck.removeFirst()
    }
    
    func peek() -> Card? {
        guard !deck.isEmpty else { return nil }
        return deck[0]
    }
    
    func addCards(_ cards: [Card]) {
        deck += cards
    }
    
    func numCards() -> Int {
        return deck.count
    }
    
    func shuffle() {
        deck.shuffle()
    }
    
    func discard(_ numCards: Int) {
        deck.removeSubrange(0..<numCards)
    }
    
}
