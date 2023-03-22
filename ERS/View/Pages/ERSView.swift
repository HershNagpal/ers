//
//  ERSView.swift
//  ERS
//
//  Created by Hersh Nagpal on 3/20/23.
//

import SwiftUI

struct ERSView: View {
    @StateObject var game = ERSGame()
    var back: () -> Void
    
    init(back: @escaping () -> Void) {
        self.back = back
    }
    
    var body: some View {
        ZStack {
            VStack {
                PlayerInteractionView(game: game, player: .two)
                    .rotationEffect(Angle(degrees: 180))
                    .ignoresSafeArea()
                ZStack {
                    CardStackView(game: game)
                        .frame(maxWidth: .infinity, minHeight: 450, alignment: .center)
                    DebugView(game: game)
                }
                
                PlayerInteractionView(game: game, player: .one)
            }
            if (game.winner != .none) {
                VStack {
                    LargeText("Player \(game.winner.rawValue) wins!")
                    NavigationButton(text: "Back to menu", onPress: back)
                }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    .background(.ultraThinMaterial)
            }
        }
    }
}

struct ERSView_Previews: PreviewProvider {
    static var previews: some View {
        ERSView(back: {})
    }
}
