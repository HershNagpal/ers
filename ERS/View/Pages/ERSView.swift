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
                StackInfoView(stack: $game.stack, burnPile: $game.burnPile, deck: $game.deck2)
                    .rotationEffect(Angle(degrees: 180))
                    .padding(.top, 10)
                ZStack {
                    CardStackView(stack: $game.stack)
                        .frame(maxWidth: .infinity, minHeight: 300, alignment: .center)
                }
                StackInfoView(stack: $game.stack, burnPile: $game.burnPile, deck: $game.deck1)
                    .padding(.bottom, 10)
                PlayerInteractionView(isPaused: $isPaused, game: game, player: .one)
                    .ignoresSafeArea()
            }
                .background(Colors.yellow)
            if (game.winner != .none) {
                GameEndView(path: $path, winner: $game.winner)
            }
            if (isPaused) {
                PauseView(isPaused: $isPaused, path: $path)
            }
        }
    }
}
