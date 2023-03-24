//
//  PlayerNumber.swift
//  ERS
//
//  Created by Hersh Nagpal on 3/24/23.
//

import SwiftUI

enum PlayerNumber: String {
    case one, two, none
    
    private func localizedString() -> String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
    
    static func getLocalizedStringKey(_ player: PlayerNumber) -> String {
        return player.localizedString()
    }
}
