//
//  Card.swift
//  ERS
//
//  Created by Hersh Nagpal on 1/19/23.
//

class Card {
    let value: Value
    let suit: Suit
    
    init(value: Value, suit: Suit) {
        self.value = value
        self.suit = suit
    }
    
    func toString() -> String {
        return "\(self.value) of \(self.suit)"
    }
    
    func abbreviation() -> String {
        switch (self.value) {
        case .ace:
            return "A" + suit.rawValue
        case .ten:
            return "0" + suit.rawValue
        case .jack:
            return "J" + suit.rawValue
        case .queen:
            return "Q" + suit.rawValue
        case .king:
            return "K" + suit.rawValue
        default:
            return String(value.rawValue) + suit.rawValue
        }
    }
}

enum Suit: String, CaseIterable {
    case diamonds = "D"
    case spades = "S"
    case hearts = "H"
    case clubs = "C"
}

enum Value: Int, CaseIterable {
    case ace = 1, two, three, four, five, six, seven, eight, nine, ten, jack, queen, king
}
