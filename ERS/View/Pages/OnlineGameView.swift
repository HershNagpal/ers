//
//  OnlineGameView.swift
//  ERS
//
//  Created by Hersh Nagpal on 8/23/24.
//

import SwiftUI
import GameKit

struct OnlineGameView: View {
    @Binding var path: [String]
    @EnvironmentObject var onlineMatch: OnlineMatchManager
    @EnvironmentObject var asm: AppStorageManager
    @State var ruleState: RuleState?
    @State var playingGame: Bool = false
    @State var showSheet: Bool = false
    
    var body: some View {
        ZStack {
            if onlineMatch.playingGame && onlineMatch.localPlayerNumber != .none, let _ = onlineMatch.game {
                GameView(path: $path, game: onlineMatch.game!, localPlayer: onlineMatch.localPlayerNumber, isSingleplayer: false, sendAction: {onlineMatch.sendAction(action: $0, player: $1)})
                    .onAppear {
                        onlineMatch.acceptedInvite = false
                        showSheet = true
                    }
                    .onDisappear {
                        onlineMatch.resetController()
                    }
                    .sheet(isPresented: $showSheet) {
                        VStack(spacing: 8) {
                            RuleDisplayView(localPlayer: onlineMatch.localPlayerNumber, rulesPlayer: onlineMatch.rulesPlayer, dismiss: {showSheet = false}, ruleState: onlineMatch.game!.ruleState)
                        }
                    }
            } else {
                HStack {
                    Spacer()
                    VStack() {
                        Spacer()
//                        Text("\(onlineMatch.playingGame)")
                    }
                }
                .background(LinearGradient(gradient: Gradient(colors: [.ersDarkBackground, .ersGreyBackground]), startPoint: .bottom, endPoint: .top))
            }
        }
        .onChange(of: onlineMatch.goHome) {
            print("Going Home")
            path.removeAll()
        }
        .onAppear {
            print("Appearing")
            ruleState = asm.saveRuleState()
            onlineMatch.choosePlayer()
        }
        .onDisappear {
            print("Disappearing")
            if let ruleState = ruleState {
                asm.apply(state: ruleState)
            }
        }
    }
}

#Preview {
    OnlineGameView(path: .constant([]))
}
