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
    let stack: [Card]
    let burnPile: [Card]
    let currentPlayer: PlayerNumber
    let stackClaimSlap: PlayerNumber
    let numTurns: Int
    let winner: PlayerNumber
    let countdown: Int
    
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
