//
//  PauseView.swift
//  ERS
//
//  Created by Hersh Nagpal on 3/23/23.
//

import SwiftUI

struct PauseView: View {
    @EnvironmentObject var asm: AppStorageManager
    @Binding var isPaused: Bool
    @Binding var path: [String]
    @State var showForfeit: Bool = false
    let resetGame: () -> Void
    let ruleState: RuleState
    let localPlayer: PlayerNumber
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            if asm.online {
                LargeText("menu")
            } else {
                LargeText("paused")
            }
            Spacer()
            
            if asm.online {
                RuleDisplayView(localPlayer: localPlayer, rulesPlayer: nil, dismiss: nil, ruleState: ruleState)
                Spacer()
            }
            
            HStack(spacing: 32) {
                Spacer()
                NavigationIcon(iconName: "play.fill", onPress: {isPaused = false})
                if !asm.online {
                    NavigationIcon(iconName: "arrow.counterclockwise", onPress: {resetGame()})
                }
                NavigationIcon(iconName: "house", onPress: {
                    if !asm.online {
                        path.removeAll()
                    } else {
                        showForfeit.toggle()
                    }
                })
                Spacer()
            }
            Spacer()
        }
        .alert("Forfeit the match?", isPresented: $showForfeit) {
            Button("Yes", role: .destructive) { path.removeAll() }
            Button("No", role: .cancel) { showForfeit = false }
        }
        .padding(24)
        .background(.ultraThinMaterial)
    }
}

