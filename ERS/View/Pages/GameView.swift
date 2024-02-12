//
//  GameView.swift
//  ERS
//
//  Created by Hersh Nagpal on 3/20/23.
//

import SwiftUI
import GameKit

struct GameView: View {
    @Binding var path: [String]
    @StateObject var game = Game()
    @State var isPaused: Bool = false
    @EnvironmentObject private var achievementManager: AchievementManager
    
    private func checkAchievements() {
        achievementManager.incrementAchievementProgress(.gamesPlayed)
        if achievementManager.getAchievementProgress(.gamesPlayed) > 100 {
            achievementManager.completeAchievement(.hundredGames)
        } else if achievementManager.getAchievementProgress(.gamesPlayed) > 1000 {
            achievementManager.completeAchievement(.thousandGames)
        }
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                PlayerInteractionView(isPaused: $isPaused, game: game, isDisabled: false, player: .two)
                    .rotationEffect(Angle(degrees: 180))
                    .ignoresSafeArea()
                StackInfoView(stack: $game.stack, burnPile: $game.burnPile, deck: $game.deck2, lastDeckCount: game.deck1.numCards())
                    .rotationEffect(Angle(degrees: 180))
                    .padding([.top, .trailing], 10)
                CardStackView(stack: $game.stack)
                    .frame(maxWidth: .infinity, minHeight: 300, alignment: .center)
                StackInfoView(stack: $game.stack, burnPile: $game.burnPile, deck: $game.deck1, lastDeckCount: game.deck1.numCards())
                    .padding([.bottom, .leading], 10)
                PlayerInteractionView(isPaused: $isPaused, game: game, isDisabled: false, player: .one)
                    .ignoresSafeArea()
            }
                .background(Colors.ersGrey)
            if game.winner != .none {
                GameEndView(path: $path, winner: $game.winner)
                    .onAppear {
                        checkAchievements()
                    }
            }
            if isPaused {
                PauseView(isPaused: $isPaused, path: $path, resetGame: {
                    game.restart()
                    isPaused = false
                })
            }
        }
    }
}
