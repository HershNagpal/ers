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
    
    static func syncAchievements() {
        guard GKLocalPlayer.local.isAuthenticated else { return }
        var achievementIds = AchievementId.allCases
        GKAchievement.loadAchievements(completionHandler: {(achievements: [GKAchievement]?, error: Error?) in
            guard let achievements = achievements else { return }
            for achievement in achievements {
                guard let id = AchievementId(rawValue: achievement.identifier) else {
                    print("Error parsing raw value \(achievement.identifier)")
                    return
                }
                print("GC: \(achievement.identifier)-\(achievement.percentComplete)%    Local: \(id)-\(getAchievementProgress(id))%")
                let maxProgress = max(achievement.percentComplete, getAchievementProgress(id))
                achievement.percentComplete = maxProgress
                setAchievementProgress(id, percentComplete: maxProgress)
                if let index = achievementIds.firstIndex(of: id) {
                    achievementIds.remove(at: index)
                }
            }
            
            var newAchievements: [GKAchievement] = []
            for id in achievementIds {
                let achievement = GKAchievement(identifier: id.rawValue)
                achievement.percentComplete = getAchievementProgress(id)
                newAchievements.append(achievement)
            }
            GKAchievement.report(newAchievements)
            GKAchievement.report(achievements)
        })
    }
    
    static func completeAchievement(_ achievementId: AchievementId) {
        UserDefaults.standard.set(100, forKey: achievementId.rawValue)
    }
    
    static func setAchievementProgress(_ achievementId: AchievementId, percentComplete: Double) {
        UserDefaults.standard.set(percentComplete, forKey: achievementId.rawValue)
    }
    
    static func getAchievementProgress(_ achievementId: AchievementId) -> Double {
        return UserDefaults.standard.double(forKey: achievementId.rawValue)
    }
    
    static func hasCompletedAchievement(_ achievementId: AchievementId) -> Bool {
        return UserDefaults.standard.integer(forKey: achievementId.rawValue) >= 100
    }
    
    static let achievementsList = [
        Achievement(id: .firstGame,
                    title: "First Slaps",
                    image: "hand.wave",
                    percentComplete: 0,
                    achievedDescription: "Played your first game of ERS!",
                    unachievedDescription: "Play out a game of ERS on singleplayer or multiplayer."),
        Achievement(id: .beatEasyBot,
                    title: "Beat Easy Bot",
                    image: "brain.filled.head.profile",
                    percentComplete: 0,
                    achievedDescription: "Won a singleplayer game on easy difficulty.",
                    unachievedDescription: "Win a singleplayer game on easy difficulty."),
        Achievement(id: .beatMediumBot,
                    title: "Beat Medium Bot",
                    image: "brain.filled.head.profile",
                    percentComplete: 0,
                    achievedDescription: "Won a singleplayer game on medium difficulty.",
                    unachievedDescription: "Win a singleplayer game on medium difficulty."),
        Achievement(id: .beatHardBot,
                    title: "Beat Hard Bot",
                    image: "brain.filled.head.profile",
                    percentComplete: 0,
                    achievedDescription: "Won a singleplayer game on hard difficulty.",
                    unachievedDescription: "Win a singleplayer game on hard difficulty."),
        Achievement(id: .beatOuchBot,
                    title: "Felt the Pain",
                    image: "brain.head.profile.fill",
                    percentComplete: 0,
                    achievedDescription: "Won a singleplayer game on ouch difficulty.",
                    unachievedDescription: "Win a singleplayer game on ouch difficulty."),
        Achievement(id: .hundredGames,
                    title: "Seasoned Player",
                    image: "flag.fill",
                    percentComplete: 0,
                    achievedDescription: "Completed 100 games.",
                    unachievedDescription: "Complete 100 games on singleplayer or multiplayer."),
        Achievement(id: .hundredBotWins,
                    title: "Bot Destroyer",
                    image: "poweroutlet.type.f.fill",
                    percentComplete: 0,
                    achievedDescription: "Won 100 games on singleplayer.",
                    unachievedDescription: "Win 100 games of singleplayer."),
        Achievement(id: .thousandGames,
                    title: "Rat King",
                    image: "crown.fill",
                    percentComplete: 0,
                    achievedDescription: "Completed 1000 games.",
                    unachievedDescription: "Complete 1000 games on singleplayer or multiplayer."),
        Achievement(id: .maxBurnWin,
                    title: "Third Degree",
                    image: "flame",
                    percentComplete: 0,
                    achievedDescription: "Won a singleplayer game with the burn amount set to 10.",
                    unachievedDescription: "Win a singleplayer game with the burn amount set to 10."),
        Achievement(id: .allRulesWin,
                    title: "Rules and Consequences",
                    image: "newspaper.fill",
                    percentComplete: 0,
                    achievedDescription: "Won a singleplayer game with every rule activated.",
                    unachievedDescription: "Win a singleplayer game with every rule and extra rule activated."),
        Achievement(id: .lucky,
                    title: "Heart of the Cards",
                    image: "heart.square",
                    percentComplete: 0,
                    achievedDescription: "Won a singleplayer game with no slap rules activated.",
                    unachievedDescription: "Win a singleplayer game with no slap rules activated."),
    ]
}
