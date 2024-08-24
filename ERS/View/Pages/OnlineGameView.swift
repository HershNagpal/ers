//
//  OnlineGameView.swift
//  ERS
//
//  Created by Hersh Nagpal on 8/23/24.
//

import SwiftUI

struct OnlineGameView: View {
    @Binding var path: [String]
    @EnvironmentObject var onlineMatch: OnlineMatchManager
    @EnvironmentObject var asm: AppStorageManager
    @State var ruleState: RuleState?
    @State var playingGame: Bool = false
    
    var body: some View {
        ZStack {
            if onlineMatch.playingGame && onlineMatch.localPlayerNumber != .none, let game = onlineMatch.game {
                GameView(path: $path, game: onlineMatch.game!, localPlayer: onlineMatch.localPlayerNumber, isSingleplayer: false, sendAction: {onlineMatch.sendAction(action: $0, player: $1)})
                    .onAppear {
                        onlineMatch.acceptedInvite = false
                    }
                    .onDisappear {
                        onlineMatch.resetController()
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
                asm.restoreRuleState(from: ruleState)
            }
        }
    }
}

#Preview {
    OnlineGameView(path: .constant([]))
}
