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
            NavigationButton(text: "resume", onPress: {isPaused = false})
            NavigationButton(text: "restart", onPress: {resetGame()})
            NavigationButton(text: "back to menu", onPress: {path.removeAll()})
            Spacer()
        }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .background(.ultraThinMaterial)
    }
}

