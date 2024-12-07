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
    @State var showForfeit: Bool = false
    let resetGame: () -> Void
    let ruleState: RuleState
    let localPlayer: PlayerNumber
    let navigateHome: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            LargeText("paused")
            Spacer()
            
            HStack(spacing: 32) {
                Spacer()
                NavigationIcon(iconName: "play.fill", onPress: {isPaused = false})
                NavigationIcon(iconName: "arrow.counterclockwise", onPress: { resetGame()} )
                NavigationIcon(iconName: "house", onPress: {
                    navigateHome()
                })
                Spacer()
            }
            Spacer()
        }
        .padding(24)
        .background(.ultraThinMaterial)
    }
}

