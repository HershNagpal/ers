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
        HStack {
            VStack() {
                DealButton(text: "deal", onPress: {game.drawCard(player)} )
                DealButton(
                    text: game.stackClaimSlap == player ? "claim" : "slap",
                    onPress: {game.slap(player)}
                )
            }
            if player == .one {
                Text("\(game.deck1.numCards())")
            } else if (player == .two) {
                Text("\(game.deck2.numCards())")
            }
        }
    }
}

struct PlayerInteractionView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerInteractionView(game: ERSGame(), player: .one)
    }
}
