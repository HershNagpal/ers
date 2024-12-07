//
//  RuleState.swift
//  ERS
//
//  Created by Hersh Nagpal on 8/24/24.
//

import Foundation

struct RuleState: Codable {
    let doublesOn: Bool
    let sandwichOn: Bool
    let couplesOn: Bool
    let divorceOn: Bool
    let queenOfDeathOn: Bool
    let topAndBottomOn: Bool
    let addToTenOn: Bool
    let sequenceOn: Bool
    let burnAmount: Int
    
    func encode() -> Data? {
        let encoder = PropertyListEncoder()
        encoder.outputFormat = .xml
        
        do {
            let data = try encoder.encode(self)
            return data
        } catch {
            print("Error encoding RuleState: \(error.localizedDescription).")
            return nil
        }
    }
}
