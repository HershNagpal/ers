//
//  GameView.swift
//  ERS
//
//  Created by Hersh Nagpal on 3/20/23.
//

import SwiftUI
import GameKit
import ConfettiSwiftUI

struct GameView: View {
    @EnvironmentObject var asm: AppStorageManager
    @Binding var path: [String]
    @ObservedObject var game: Game
    @State var isPaused: Bool = false
    @State var confettiCounter1: Int = 0
    @State var confettiCounter2: Int = 0
    @State var burn: Bool = false
    @State var showBurnAlert: Bool = false
    let localPlayer: PlayerNumber
    let isSingleplayer: Bool
    let sendAction: ((GameAction.Action, PlayerNumber) -> Void)?
    
    private func checkAchievements() {
        AchievementManager.setAchievementProgress(.hundredGames, percentComplete: min(AchievementManager.getAchievementProgress(.hundredGames)+1,100))
        AchievementManager.setAchievementProgress(.thousandGames, percentComplete: min(AchievementManager.getAchievementProgress(.thousandGames)+0.1,100))
        
        guard isSingleplayer else { return }
        guard game.winner == .one else { return }
        
        AchievementManager.setAchievementProgress(.hundredBotWins,
              percentComplete: min(AchievementManager.getAchievementProgress(.hundredBotWins)+1,100))
        if asm.addToTenOn && asm.couplesOn && asm.divorceOn && asm.doublesOn
            && asm.queenOfDeathOn  && asm.sandwichOn && asm.sequenceOn && asm.topAndBottomOn {
            AchievementManager.completeAchievement(.allRulesWin)
        }
        if !asm.addToTenOn && !asm.couplesOn && !asm.divorceOn && !asm.doublesOn
            && !asm.queenOfDeathOn  && !asm.sandwichOn && !asm.sequenceOn && !asm.topAndBottomOn {
            AchievementManager.completeAchievement(.lucky)
        }
        if asm.burnAmount >= 10 {
            AchievementManager.completeAchievement(.maxBurnWin)
        }
        
        switch(asm.difficulty) {
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
    
    private func playerTwoTurn()  {
        guard isSingleplayer && !asm.online else { return }
        let slapSkipDict = [20, 20, 10, 10]
        let randomTime = Double(4/(asm.difficulty+1))
        let chanceToSkipSlap = slapSkipDict[asm.difficulty]
        
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
    
    var body: some View {
        ZStack {
            if asm.hapticFeedback {
                Color.clear
                    .sensoryFeedback(.increase, trigger: game.stack.count)
                    .sensoryFeedback(.success, trigger: confettiCounter1)
                    .sensoryFeedback(.success, trigger: confettiCounter2)
                    .sensoryFeedback(.impact(flexibility: .solid), trigger: burn)
            }
            VStack(spacing: 0) {
                PlayerInteractionView(isPaused: $isPaused, burn: $burn, game: game, isDisabled: isSingleplayer || asm.online, player: localPlayer == .one ? .two : .one, confettiCounter: localPlayer == .two ? $confettiCounter1: $confettiCounter2, sendAction: sendAction, image: nil)
                    .rotationEffect(Angle(degrees: 180))
                    .ignoresSafeArea()
                    .environmentObject(asm)
                    .onChange(of: localPlayer == .two ? game.deck1.deck.count : game.deck2.deck.count) {
                        if asm.online && $0 < $1 {
                            if localPlayer == .one {
                                confettiCounter2 += 1
                            } else {
                                confettiCounter1 += 1
                            }
                        }
                    }
                    .confettiCannon(counter: localPlayer == .two ? $confettiCounter1: $confettiCounter2, num: 40, confettis: [.shape(.slimRectangle)], colors: [.red, .yellow, .green, .blue, .purple], confettiSize: 20, rainHeight: 200, fadesOut: true, opacity: 1, openingAngle: Angle(degrees: 0), closingAngle: Angle(degrees: 360), radius: 150)
                StackInfoView(stack: $game.stack, burnPile: $game.burnPile, deck: $game.deck2, lastDeckCount: game.deck1.numCards())
                    .rotationEffect(Angle(degrees: 180))
                    .padding([.top, .trailing], 10)
                CardStackView(stack: $game.stack)
                    .frame(maxWidth: .infinity, minHeight: 300, alignment: .center)
                    .environmentObject(asm)
                StackInfoView(stack: $game.stack, burnPile: $game.burnPile, deck: $game.deck1, lastDeckCount: game.deck1.numCards())
                    .padding([.bottom, .leading], 10)
                PlayerInteractionView(isPaused: $isPaused, burn: $burn, game: game, isDisabled: false, player: localPlayer, confettiCounter: localPlayer == .one ? $confettiCounter1: $confettiCounter2, sendAction: sendAction, image: nil)
                    .ignoresSafeArea()
                    .environmentObject(asm)
                    .confettiCannon(counter: localPlayer == .one ? $confettiCounter1: $confettiCounter2, num: 40, confettis: [.shape(.slimRectangle)], colors: [.red, .yellow, .green, .blue, .purple], confettiSize: 20, rainHeight: 200, fadesOut: true, opacity: 1, openingAngle: Angle(degrees: 0), closingAngle: Angle(degrees: 360), radius: 150)
            }
            .onChange(of: game.burnPile) {
                burn.toggle()
                showBurnAlert.toggle()
            }
            .background(.ersGreyBackground)
            
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
                }, ruleState: game.ruleState, localPlayer: localPlayer)
            }
        }
        .onAppear {
            guard isSingleplayer else { return }
            playerTwoTurn()
        }
    }
    
}
