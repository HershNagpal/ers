//
//  GameAction.swift
//  ERS
//
//  Created by Hersh Nagpal on 8/24/24.
//

import Foundation

struct GameAction: Codable {
    enum Action: String, Codable {
        case deal, slap, forfeit, confetti, gameRequest
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
