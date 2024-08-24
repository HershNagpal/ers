//
//  GameData.swift
//  ERS
//
//  Created by Hersh Nagpal on 8/23/24.
//

import Foundation

struct GameData: Codable {
    let deck1: Deck
    let deck2: Deck
    let currentPlayer: PlayerNumber
    
    func encode() -> Data? {
        let encoder = PropertyListEncoder()
        encoder.outputFormat = .xml
        
        do {
            let data = try encoder.encode(self)
            return data
        } catch {
            print("Error: \(error.localizedDescription).")
            return nil
        }
    }
}

struct GameAction: Codable {
    enum Action: String, Codable {
        case deal, slap, forfeit, confetti, rulesRequest
    }
    let action: Action
    let player: PlayerNumber
    
    func encode() -> Data? {
        let encoder = PropertyListEncoder()
        encoder.outputFormat = .xml
        do {
            let data = try encoder.encode(self)
            return data
        } catch {
            print("Error: \(error.localizedDescription).")
            return nil
        }
    }
}
