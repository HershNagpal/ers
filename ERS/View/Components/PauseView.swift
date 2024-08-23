//
//  PauseView.swift
//  ERS
//
//  Created by Hersh Nagpal on 3/23/23.
//

import SwiftUI

struct PauseView: View {
    
    @Binding var isPaused: Bool
    @Binding var path: [String]
    let resetGame: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            LargeText("paused")
            Spacer()
            HStack(spacing: 32) {
                Spacer()
                NavigationIcon(iconName: "play.fill", onPress: {isPaused = false})
                NavigationIcon(iconName: "arrow.counterclockwise", onPress: {resetGame()})
                NavigationIcon(iconName: "house", onPress: {path.removeAll()})
                Spacer()
            }
            Spacer()
        }
            .padding(24)
            .background(.ultraThinMaterial)
    }
}

