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
            Button(action: {game.drawCard(player)}) {
                VStack{
                    LargeText("Deal")
                        
                    MediumText("Cards in deck: \(player == .one ? game.deck1.numCards() : game.deck2.numCards())")
                }
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(
                        game.currentPlayer == player && game.stackClaimSlap == .none
                        ? Color.blue
                        : Color.gray
                    )
                    .contentShape(Rectangle())
            }
            Button(action: {game.slap(player)}) {
                LargeText(game.stackClaimSlap == player ? "Claim" : "Slap")
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(game.stackClaimSlap == player ? Color.green : Color.red)
                    .contentShape(Rectangle())
            }
            
        }
    }
}

struct PlayerInteractionView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerInteractionView(game: ERSGame(), player: .one)
    }
}
