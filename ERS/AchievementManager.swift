//
//  AchievementManager.swift
//  ERS
//
//  Created by Hersh Nagpal on 2/11/24.
//

import Foundation
import GameKit

@MainActor
final class AchievementManager: ObservableObject {
    
    static func completeAchievement(_ achievementId: AchievementId) {
        guard !hasCompletedAchievement(achievementId) else { return }
        UserDefaults.standard.set(true, forKey: achievementId.rawValue)
        guard GKLocalPlayer.local.isAuthenticated else { return }
        reportCompletedAchievement(achievementId)
    }
    
    static func uncompleteAchievement(_ achievementId: AchievementId) {
        UserDefaults.standard.set(false, forKey: achievementId.rawValue)
    }
    
    static func setAchievementProgress(_ achievementId: AchievementId, exactAmount: Int) {
        UserDefaults.standard.set(exactAmount, forKey: achievementId.rawValue)
    }
    
    static func incrementAchievementProgress(_ achievementId: AchievementProgress) {
        let previous = getAchievementProgress(achievementId)
        UserDefaults.standard.set(previous+1, forKey: achievementId.rawValue)            
    }
    
    static func getAchievementProgress(_ achievementId: AchievementProgress) -> Int {
        return UserDefaults.standard.integer(forKey: achievementId.rawValue)
    }
    
    static func hasCompletedAchievement(_ achievementId: AchievementId) -> Bool {
        return UserDefaults.standard.bool(forKey: achievementId.rawValue)
    }
    
    static func reportIncrementAchievement(_ achievementId: AchievementId) {
        var percentage: Double = 0
        switch achievementId {
        case .hundredGames:
            percentage = Double(getAchievementProgress(.gamesPlayed))
            break
        case .hundredBotWins:
            percentage = Double(getAchievementProgress(.botGamesWon))
            break
        case .thousandGames:
            percentage = Double(getAchievementProgress(.gamesPlayed)/10)
            break
        default:
            return
        }
        guard percentage <= 100 else { return }
        // Load the player's active achievements.
        GKAchievement.loadAchievements(completionHandler: {(achievements: [GKAchievement]?, error: Error?) in
            let id = achievementId.rawValue
            var achievement: GKAchievement? = nil
            
            // Find an existing achievement.
            achievement = achievements?.first(where: { $0.identifier == id})
            
            // Otherwise, create a new achievement.
            if achievement == nil {
                achievement = GKAchievement(identifier: id)
            }
            print("Reporting \(percentage)% completion of \(id)")
            // Insert code to report the percentage.
            if let achievement = achievement {
                achievement.percentComplete = percentage
                GKAchievement.report([achievement]) { error in
                    if error != nil {
                        print("Error Reporting Achievement Progress \(id):\(achievement.percentComplete): \(String(describing: error.debugDescription))")
                    }
                }
            }
            
            if error != nil {
                // Handle the error that occurs.
                print("Error Loading Achievement Progress \(id): \(String(describing: error))")
            }
        })
    }
    
    static func reportCompletedAchievement(_ achievementId: AchievementId) {
        // Load the player's active achievements.
        GKAchievement.loadAchievements(completionHandler: {(achievements: [GKAchievement]?, error: Error?) in
            let id = achievementId.rawValue
            var achievement: GKAchievement? = nil
            
            // Find an existing achievement.
            achievement = achievements?.first(where: { $0.identifier == id})
            
            // Otherwise, create a new achievement.
            if achievement == nil {
                achievement = GKAchievement(identifier: id)
            }
            
            // Insert code to report the percentage.
            if let achievement = achievement {
                achievement.percentComplete = 100
                GKAchievement.report([achievement]) { error in
                    if error != nil {
                        print("Error Reporting Achievement \(id): \(String(describing: error.debugDescription))")
                    }
                }
            }
            
            if error != nil {
                // Handle the error that occurs.
                print("Error Loading Achievement: \(String(describing: error))")
            }
        })
    }
    
    static let achievementsList = [
        Achievement(id: .firstGame,
                    title: "First Slaps",
                    image: "hand.wave",
                    isCompleted: false,
                    achievedDescription: "Played your first game of ERS!",
                    unachievedDescription: "Play out a game of ERS on singleplayer or multiplayer."),
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
}
