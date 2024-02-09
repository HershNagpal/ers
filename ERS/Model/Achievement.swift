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
    var id: String
    let title: String
    let image: String
    let isCompleted: Bool?
    let achievedDescription: String
    let unachievedDescription: String
    
    static let achievementsList = [
        Achievement(id: "beatEasyBot",
                    title: "Beat Easy Bot",
                    image: "robot",
                    isCompleted: false,
                    achievedDescription: "Won a singleplayer game on easy difficulty.",
                    unachievedDescription: "Win a singleplayer game on easy difficulty."),
        Achievement(id: "beatMediumBot",
                    title: "Beat Medium Bot",
                    image: "robot",
                    isCompleted: false,
                    achievedDescription: "Won a singleplayer game on medium difficulty.",
                    unachievedDescription: "Win a singleplayer game on medium difficulty"),
        Achievement(id: "beatHardBot",
                    title: "Beat Hard Bot",
                    image: "robot",
                    isCompleted: false,
                    achievedDescription: "Won a singleplayer game on hard difficulty.",
                    unachievedDescription: "Win a singleplayer game on hard difficulty."),
        Achievement(id: "beatOuchBot",
                    title: "Felt the Pain",
                    image: "robot",
                    isCompleted: false,
                    achievedDescription: "Won a singleplayer game on ouch difficulty.",
                    unachievedDescription: "Win a singleplayer game on ouch difficulty."),
        Achievement(id: "hundredGames",
                    title: "Seasoned Player",
                    image: "robot",
                    isCompleted: false,
                    achievedDescription: "Completed 100 games.",
                    unachievedDescription: "Complete 100 games on singleplayer or multiplayer."),
        Achievement(id: "hundredBotWins",
                    title: "Bot Destroyer",
                    image: "robot",
                    isCompleted: false,
                    achievedDescription: "Won 100 games on singleplayer.",
                    unachievedDescription: "Win 100 games of singleplayer."),
        Achievement(id: "thousandGames",
                    title: "Rat King",
                    image: "robot",
                    isCompleted: false,
                    achievedDescription: "Completed 1000 games.",
                    unachievedDescription: "Complete 1000 games on singleplayer or multiplayer."),
        Achievement(id: "quickSlap",
                    title: "Ratlike Reflexes",
                    image: "robot",
                    isCompleted: false,
                    achievedDescription: "Slapped a pile within 1/100 of a second.",
                    unachievedDescription: "Slap a valid pile within 1/100 of a second."),
        Achievement(id: "maxBurnWin",
                    title: "Third Degree",
                    image: "robot",
                    isCompleted: false,
                    achievedDescription: "Won a game with the burn amount set to 10.",
                    unachievedDescription: "Win a game with the burn amount set to 10."),
        Achievement(id: "allRulesWin",
                    title: "Rules and Consequences",
                    image: "robot",
                    isCompleted: false,
                    achievedDescription: "Won a game with every rule activated.",
                    unachievedDescription: "Win a game with every rule and extra rule activated."),
        
    ]

    enum AchievementId: String, Codable {
        case beatEasyBot,
        beatMediumBot,
        beatHardBot,
        beatOuchBot,
        hundredGames,
        hundredBotWins,
        thousandGames,
        quickSlap,
        maxBurnWin,
        allRulesWin
    }
    
    static func completeAchievement(_ achievementId: String) {
        UserDefaults.standard.set(true, forKey: achievementId)
    }
    
    static func uncompleteAchievement(_ achievementId: String) {
        UserDefaults.standard.set(false, forKey: achievementId)
    }
    
    static func hasCompletedAchievement(_ achievementId: String) -> Bool {
        return UserDefaults.standard.bool(forKey: achievementId)
    }
}
