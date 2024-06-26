//
//  PracticeView.swift
//  ERS
//
//  Created by Hersh Nagpal on 3/24/23.
//

import SwiftUI
import ConfettiSwiftUI

struct PracticeView: View {
    @Binding var path: [String]
    @StateObject var game = Game(isSingleplayer: true, difficulty: 1)
    @State var isPaused: Bool = false
    @AppStorage("difficulty") var difficulty: Int = 1
    @State var confettiCounter1: Int = 0
    @State var confettiCounter2: Int = 0

    private func checkAchievements() {
        AchievementManager.setAchievementProgress(.hundredGames,
              percentComplete: min(AchievementManager.getAchievementProgress(.hundredGames)+1,100))
        AchievementManager.setAchievementProgress(.thousandGames,
              percentComplete: min(AchievementManager.getAchievementProgress(.thousandGames)+0.1,100))
        guard game.winner == .one else { return }
        AchievementManager.setAchievementProgress(.hundredBotWins,
              percentComplete: min(AchievementManager.getAchievementProgress(.hundredBotWins)+1,100))
        if game.addToTenOn && game.couplesOn && game.divorceOn && game.doublesOn
            && game.queenOfDeathOn  && game.sandwichOn && game.sequenceOn && game.topAndBottomOn {
            AchievementManager.completeAchievement(.allRulesWin)
        }
        if !game.addToTenOn && !game.couplesOn && !game.divorceOn && !game.doublesOn
            && !game.queenOfDeathOn  && !game.sandwichOn && !game.sequenceOn && !game.topAndBottomOn {
            AchievementManager.completeAchievement(.lucky)
        }
        if game.burnAmount >= 10 {
            AchievementManager.completeAchievement(.maxBurnWin)
        }
        
        switch(difficulty) {
        case 0:
            AchievementManager.completeAchievement(.beatEasyBot)
            break
        case 1:
            AchievementManager.completeAchievement(.beatMediumBot)
            break
        case 2:
            AchievementManager.completeAchievement(.beatHardBot)
            break
        case 3:
            AchievementManager.completeAchievement(.beatOuchBot)
            break
        default:
            break
        }
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                PlayerInteractionView(isPaused: $isPaused, game: game, isDisabled: true, player: .two, confettiCounter: $confettiCounter2)
                    .rotationEffect(Angle(degrees: 180))
                    .ignoresSafeArea()
                    .confettiCannon(counter: $confettiCounter2, num: 40, confettis: [.shape(.slimRectangle)], colors: [.red, .yellow, .green, .blue, .purple], confettiSize: 20, rainHeight: 200, fadesOut: true, opacity: 1, openingAngle: Angle(degrees: 0), closingAngle: Angle(degrees: 360), radius: 150)
                StackInfoView(stack: $game.stack, burnPile: $game.burnPile, deck: $game.deck2, lastDeckCount: game.deck1.numCards())
                    .rotationEffect(Angle(degrees: 180))
                    .padding([.bottom, .trailing], 10)
                CardStackView(stack: $game.stack)
                    .frame(maxWidth: .infinity, minHeight: 300, alignment: .center)
                StackInfoView(stack: $game.stack, burnPile: $game.burnPile, deck: $game.deck1, lastDeckCount: game.deck1.numCards())
                    .padding([.bottom, .leading], 10)
                PlayerInteractionView(isPaused: $isPaused, game: game, isDisabled: false, player: .one, confettiCounter: $confettiCounter1)
                    .ignoresSafeArea()
                    .confettiCannon(counter: $confettiCounter1, num: 40, confettis: [.shape(.slimRectangle)], colors: [.red, .yellow, .green, .blue, .purple], confettiSize: 20, rainHeight: 200, fadesOut: true, opacity: 1, openingAngle: Angle(degrees: 0), closingAngle: Angle(degrees: 360), radius: 150)
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
        .onAppear {
            playerTwoTurn()
        }
    }
    
    private func playerTwoTurn()  {
        let slapSkipDict = [20, 20, 10, 10]
        let randomTime = Double(4/(difficulty+1))
        let chanceToSkipSlap = slapSkipDict[difficulty]
        
        DispatchQueue.main.asyncAfter(deadline: .now() + randomTime-randomTime/4) {
            if game.stackClaimSlap == .two {
                let _ = game.slap(.two)
                confettiCounter2 += 1
            }
            
            if game.isValidSlap(.two) && Int.random(in: 1..<100) > chanceToSkipSlap {
                let _ = game.slap(.two)
                confettiCounter2 += 1
            }
            
            if game.currentPlayer == .two && game.stackClaimSlap == .none {
                game.deal(.two)
                DispatchQueue.main.asyncAfter(deadline: .now() + randomTime/2) {
                    if game.isValidSlap(.two) && Int.random(in: 1..<100) > chanceToSkipSlap {
                        let _ = game.slap(.two)
                        confettiCounter2 += 1
                    }
                }
            }
            playerTwoTurn()
        }
    }
}
