//
//  StackInfoView.swift
//  ERS
//
//  Created by Hersh Nagpal on 3/22/23.
//

import SwiftUI

struct StackInfoView: View {
    @StateObject var game: ERSGame
    var player: PlayerNumber
    
    var body: some View {
        HStack(spacing: 0) {
            VStack(spacing: 0) {
                Image("stack")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 50, maxHeight: 50)
                MediumText("\(game.stack.count)")
                    
            }
            VStack(spacing: 0) {
                Image("burn")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 50, maxHeight: 50)
                MediumText("\(game.burnPile.count)")
            }
            VStack(spacing: 0) {
                Image("deck")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 50, maxHeight: 50)
                MediumText(player == .one ? "\(game.deck1.numCards())" : "\(game.deck2.numCards())")
            }
            Spacer()
        }
    }
}

struct StackInfoView_Previews: PreviewProvider {
    static var previews: some View {
        StackInfoView(game: ERSGame(), player: .one)
    }
}
