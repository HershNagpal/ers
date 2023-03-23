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
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            LargeText("Paused")
            Spacer()
            NavigationButton(text: "Resume", onPress: {isPaused = false})
            NavigationButton(text: "Back to menu", onPress: {path.removeAll()})
            Spacer()
        }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .background(.ultraThinMaterial)
    }
}

