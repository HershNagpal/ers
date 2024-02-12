//
//  PracticeView.swift
//  ERS
//
//  Created by Hersh Nagpal on 3/24/23.
//

import SwiftUI

struct PracticeView: View {
    @Binding var path: [String]
    @StateObject var game = Game(isSingleplayer: true, difficulty: 1)
    @State var isPaused: Bool = false
    @AppStorage("difficulty") var difficulty: Int = 1
    @EnvironmentObject private var achievementManager: AchievementManager
    
    private func checkAchievements() {
        achievementManager.incrementAchievementProgress(.gamesPlayed)
        if achievementManager.getAchievementProgress(.gamesPlayed) > 100 {
            achievementManager.completeAchievement(.hundredGames)
        } else if achievementManager.getAchievementProgress(.gamesPlayed) > 1000 {
            achievementManager.completeAchievement(.thousandGames)
        }
        guard game.winner == .one else { return }
        if game.addToTenOn && game.couplesOn && game.divorceOn && game.doublesOn 
            && game.queenOfDeathOn  && game.sandwichOn && game.sequenceOn && game.topAndBottomOn {
            achievementManager.completeAchievement(.allRulesWin)
        }
        if !game.addToTenOn && !game.couplesOn && !game.divorceOn && !game.doublesOn
            && !game.queenOfDeathOn  && !game.sandwichOn && !game.sequenceOn && !game.topAndBottomOn {
            achievementManager.completeAchievement(.lucky)
        }
        if game.burnAmount == 10 {
            achievementManager.completeAchievement(.maxBurnWin)
        }
        
        achievementManager.incrementAchievementProgress(.botGamesWon)
        if achievementManager.getAchievementProgress(.botGamesWon) > 100 {
            achievementManager.completeAchievement(.hundredBotWins)
        }
        
        switch(difficulty) {
        case 0:
            achievementManager.completeAchievement(.beatEasyBot)
            break
        case 1:
            achievementManager.completeAchievement(.beatMediumBot)
            break
        case 2:
            achievementManager.completeAchievement(.beatHardBot)
            break
        case 3:
            achievementManager.completeAchievement(.beatOuchBot)
            break
        default:
            break
        }
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                PlayerInteractionView(isPaused: $isPaused, game: game, isDisabled: true, player: .two)
                    .rotationEffect(Angle(degrees: 180))
                    .ignoresSafeArea()
                StackInfoView(stack: $game.stack, burnPile: $game.burnPile, deck: $game.deck2, lastDeckCount: game.deck1.numCards())
                    .rotationEffect(Angle(degrees: 180))
                    .padding([.bottom, .trailing], 10)
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
                game.slap(.two)
            }
            
            if game.isValidSlap(.two) && Int.random(in: 1..<100) > chanceToSkipSlap {
                game.slap(.two)
            }
            
            if game.currentPlayer == .two && game.stackClaimSlap == .none {
                game.deal(.two)
                DispatchQueue.main.asyncAfter(deadline: .now() + randomTime/2) {
                    if game.isValidSlap(.two) && Int.random(in: 1..<100) > chanceToSkipSlap {
                        game.slap(.two)
                    }
                }
            }
            playerTwoTurn()
        }
    }
}
