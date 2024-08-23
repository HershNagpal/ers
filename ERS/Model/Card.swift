//
//  Card.swift
//  ERS
//
//  Created by Hersh Nagpal on 1/19/23.
//

import Foundation

struct Card: Codable, Identifiable {
    let id: UUID
    let value: Value
    let suit: Suit
    
    init(value: Value, suit: Suit) {
        self.value = value
        self.suit = suit
        self.id = UUID()
    }
    
    func toString() -> String {
        return "\(self.value) of \(self.suit)"
    }
    
    func abbreviation() -> String {
        switch (self.value) {
        case .none:
            return "back"
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

enum Suit: String, CaseIterable, Codable {
    case diamonds = "D"
    case spades = "S"
    case hearts = "H"
    case clubs = "C"
    case none = "N"
}

enum Value: Int, CaseIterable, Codable {
    case none = 0, ace = 1, two, three, four, five, six, seven, eight, nine, ten, jack, queen, king
}
