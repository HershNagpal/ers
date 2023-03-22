//
//  PlayerInteractionView.swift
//  ERS
//
//  Created by Hersh Nagpal on 3/21/23.
//

import SwiftUI

struct PlayerInteractionView: View {
    @StateObject var game: ERSGame
    var player: PlayerNumber
    
    var body: some View {
        HStack(spacing: 0) {
            Button(action: {game.deal(player)}) {
                VStack {
                    Image("deck")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 100, maxHeight: 100)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(
                    game.currentPlayer == player && game.stackClaimSlap == .none
                    ? Color(.systemBlue)
                    : Color(.systemGray)
                )
            }
            Button(action: {game.slap(player)}) {
                VStack {
                    Image("hand")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 100, maxHeight: 100)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(
                    game.stackClaimSlap == player
                    ? Color(.systemGreen)
                    : Color(.systemRed)
                )
            }
            
        }
    }
}

struct PlayerInteractionView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerInteractionView(game: ERSGame(), player: .one)
    }
}
