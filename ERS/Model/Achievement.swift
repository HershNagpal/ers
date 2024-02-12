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
    var id: AchievementId
    let title: String
    let image: String
    let isCompleted: Bool?
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

enum AchievementProgress: String, Codable {
    case botGamesWon, gamesPlayed
}
