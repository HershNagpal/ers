//
//  ERSView.swift
//  ERS
//
//  Created by Hersh Nagpal on 3/20/23.
//

import SwiftUI

struct ERSView: View {
    @Binding var path: [String]
    @StateObject var game = ERSGame()
    @State var isPaused: Bool = false
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                PlayerInteractionView(isPaused: $isPaused, game: game, player: .two)
                    .rotationEffect(Angle(degrees: 180))
                    .ignoresSafeArea()
                StackInfoView(game: game, player: .two)
                    .rotationEffect(Angle(degrees: 180))
                    .padding(.top, 10)
                ZStack {
                    CardStackView(game: game)
                        .frame(maxWidth: .infinity, minHeight: 300, alignment: .center)
                        .background(.white)
//                    DebugView(game: game)
                }
                StackInfoView(game: game, player: .one)
                    .padding(.bottom, 10)
                PlayerInteractionView(isPaused: $isPaused, game: game, player: .one)
                    .ignoresSafeArea()
            }
            if (game.winner != .none) {
                VStack {
                    LargeText("Player \(game.winner.rawValue) wins!")
                    NavigationButton(text: "Back to menu", onPress: {path.removeAll()})
                }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    .background(.ultraThinMaterial)
            }
            if (isPaused) {
                VStack {
                    LargeText("Paused")
                    NavigationButton(text: "Resume", onPress: {isPaused = false})
                    NavigationButton(text: "Back to menu", onPress: {path.removeAll()})
                }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    .background(.ultraThinMaterial)
            }
        }
    }
}
