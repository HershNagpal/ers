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
    
    static let achievementsList = [
        Achievement(id: .beatEasyBot,
                    title: "Beat Easy Bot",
                    image: "brain.filled.head.profile",
                    isCompleted: false,
                    achievedDescription: "Won a singleplayer game on easy difficulty.",
                    unachievedDescription: "Win a singleplayer game on easy difficulty."),
        Achievement(id: .beatMediumBot,
                    title: "Beat Medium Bot",
                    image: "brain.filled.head.profile",
                    isCompleted: false,
                    achievedDescription: "Won a singleplayer game on medium difficulty.",
                    unachievedDescription: "Win a singleplayer game on medium difficulty."),
        Achievement(id: .beatHardBot,
                    title: "Beat Hard Bot",
                    image: "brain.filled.head.profile",
                    isCompleted: false,
                    achievedDescription: "Won a singleplayer game on hard difficulty.",
                    unachievedDescription: "Win a singleplayer game on hard difficulty."),
        Achievement(id: .beatOuchBot,
                    title: "Felt the Pain",
                    image: "brain.head.profile.fill",
                    isCompleted: false,
                    achievedDescription: "Won a singleplayer game on ouch difficulty.",
                    unachievedDescription: "Win a singleplayer game on ouch difficulty."),
        Achievement(id: .hundredGames,
                    title: "Seasoned Player",
                    image: "flag.fill",
                    isCompleted: false,
                    achievedDescription: "Completed 100 games.",
                    unachievedDescription: "Complete 100 games on singleplayer or multiplayer."),
        Achievement(id: .hundredBotWins,
                    title: "Bot Destroyer",
                    image: "poweroutlet.type.f.fill",
                    isCompleted: false,
                    achievedDescription: "Won 100 games on singleplayer.",
                    unachievedDescription: "Win 100 games of singleplayer."),
        Achievement(id: .thousandGames,
                    title: "Rat King",
                    image: "crown.fill",
                    isCompleted: false,
                    achievedDescription: "Completed 1000 games.",
                    unachievedDescription: "Complete 1000 games on singleplayer or multiplayer."),
        Achievement(id: .maxBurnWin,
                    title: "Third Degree",
                    image: "flame",
                    isCompleted: false,
                    achievedDescription: "Won a singleplayer game with the burn amount set to 10.",
                    unachievedDescription: "Win a singleplayer game with the burn amount set to 10."),
        Achievement(id: .allRulesWin,
                    title: "Rules and Consequences",
                    image: "newspaper.fill",
                    isCompleted: false,
                    achievedDescription: "Won a singleplayer game with every rule activated.",
                    unachievedDescription: "Win a singleplayer game with every rule and extra rule activated."),
        Achievement(id: .lucky,
                    title: "Heart of the Cards",
                    image: "heart.square",
                    isCompleted: false,
                    achievedDescription: "Won a singleplayer game with no slap rules activated.",
                    unachievedDescription: "Win a singleplayer game with no slap rules activated."),
    ]

    enum AchievementId: String, Codable {
        case beatEasyBot,
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
    
    static func completeAchievement(_ achievementId: AchievementId) {
        UserDefaults.standard.set(true, forKey: achievementId.rawValue)
    }
    
    static func uncompleteAchievement(_ achievementId: AchievementId) {
        UserDefaults.standard.set(false, forKey: achievementId.rawValue)
    }
    
    static func incrementAchievementProgress(_ achievementId: AchievementProgress) {
        let previous = getAchievementProgress(achievementId)
        UserDefaults.standard.set(previous+1, forKey: achievementId.rawValue)
    }
    
    static func getAchievementProgress(_ achievementId: AchievementProgress) -> Int {
        return UserDefaults.standard.integer(forKey: achievementId.rawValue)
    }
    
    static func hasCompletedAchievement(_ achievementId: String) -> Bool {
        return UserDefaults.standard.bool(forKey: achievementId)
    }
}
