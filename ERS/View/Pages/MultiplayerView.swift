//
//  MultiplayerView.swift
//  ERS
//
//  Created by Hersh Nagpal on 3/20/23.
//

import SwiftUI
import GameKit
import ConfettiSwiftUI

struct MultiplayerView: View {
    @EnvironmentObject var asm: AppStorageManager
    @Binding var path: [String]
    @StateObject var game = Game()
    @State var isPaused: Bool = false
    @State var confettiCounter1: Int = 0
    @State var confettiCounter2: Int = 0
    
    @State var burn: Bool = false
    @State var showBurnAlert: Bool = false
    
    private func checkAchievements() {
        AchievementManager.setAchievementProgress(.hundredGames,
              percentComplete: min(AchievementManager.getAchievementProgress(.hundredGames)+1,100))
        AchievementManager.setAchievementProgress(.thousandGames,
              percentComplete: min(AchievementManager.getAchievementProgress(.thousandGames)+0.1,100))
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                PlayerInteractionView(isPaused: $isPaused, burn: $burn, game: game, isDisabled: false, player: .two, confettiCounter: $confettiCounter2)
                    .rotationEffect(Angle(degrees: 180))
                    .ignoresSafeArea()
                    .confettiCannon(counter: $confettiCounter2, num: 40, confettis: [.shape(.slimRectangle)], colors: [.red, .yellow, .green, .blue, .purple], confettiSize: 20, rainHeight: 200, fadesOut: true, opacity: 1, openingAngle: Angle(degrees: 0), closingAngle: Angle(degrees: 360), radius: 150)
                StackInfoView(stack: $game.stack, burnPile: $game.burnPile, deck: $game.deck2, lastDeckCount: game.deck1.numCards())
                    .rotationEffect(Angle(degrees: 180))
                    .padding([.top, .trailing], 10)
                    .foregroundColor(.white)
                CardStackView(stack: $game.stack)
                    .frame(maxWidth: .infinity, minHeight: 300, alignment: .center)
                StackInfoView(stack: $game.stack, burnPile: $game.burnPile, deck: $game.deck1, lastDeckCount: game.deck1.numCards())
                    .padding([.bottom, .leading], 10)
                    .foregroundColor(.white)
                PlayerInteractionView(isPaused: $isPaused, burn: $burn, game: game, isDisabled: false, player: .one, confettiCounter: $confettiCounter1)
                    .ignoresSafeArea()
                    .confettiCannon(counter: $confettiCounter1, num: 40, confettis: [.shape(.slimRectangle)], colors: [.red, .yellow, .green, .blue, .purple], confettiSize: 20, rainHeight: 200, fadesOut: true, opacity: 1, openingAngle: Angle(degrees: 0), closingAngle: Angle(degrees: 360), radius: 150)
            }
                .background(.ersGreyBackground)
                .onChange(of: game.burnPile.count) {
                    burn.toggle()
                    withAnimation {
                        showBurnAlert.toggle()
                    }
                }
                .sensoryFeedback(.increase, trigger: game.stack.count)
                .sensoryFeedback(.success, trigger: confettiCounter1)
                .sensoryFeedback(.success, trigger: confettiCounter2)
                .sensoryFeedback(.impact(flexibility: .solid), trigger: burn)
            
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
