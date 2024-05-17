//
//  Achievement.swift
//  ERS
//
//  Created by Hersh Nagpal on 2/8/24.
//

import Foundation
import GameKit
import SwiftUI

struct Achievement: Codable, Identifiable, Hashable {
    let id: AchievementId
    let title: String
    let image: String
    let percentComplete: Double
    var isCompleted: Bool {
        get { percentComplete >= 100 }
    }
    let achievedDescription: String
    let unachievedDescription: String
}

enum AchievementId: String, Codable, CaseIterable {
    case firstGame,
    beatEasyBot,
    beatMediumBot,
    beatHardBot,
    beatOuchBot,
    hundredGames,
    hundredBotWins,
    thousandGames,
    maxBurnWin,
    allRulesWin,
    lucky
}
