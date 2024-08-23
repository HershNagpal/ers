//
//  PlayerInteractionView.swift
//  ERS
//
//  Created by Hersh Nagpal on 3/21/23.
//

import SwiftUI

struct PlayerInteractionView: View {
    @Binding var isPaused: Bool
    @Binding var burn: Bool
    @StateObject var game: Game
    let isDisabled: Bool
    var player: PlayerNumber
    @AppStorage("easyClaim") var easyClaim: Bool = true
    @AppStorage("easyDeal") var easyDeal: Bool = true
    @AppStorage("confettiSlap") var confettiSlap: Bool = true
    @Binding var confettiCounter: Int
    @State var deal: Bool = false
    
    var body: some View {
        ZStack {
            HStack(spacing: 0) {
                Button(action: { if !isDisabled {
                    game.deal(player)
                    deal.toggle()
                }}) {
                    VStack {
                        Image("deckIcon")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 75, maxHeight: 75)
                        ProgressView(value: Float(player == .one ? game.deck1.deck.count : game.deck2.deck.count) / 52)
                            .frame(width: 75)
                    }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(
                            easyDeal
                                ? game.currentPlayer == player && game.stackClaimSlap == .none
                                ? Colors.ersGreen
                                : .ersGreyBackground
                            : Colors.ersGreen
                        )
                }
                Button(action: { if !isDisabled {
                    if game.slap(player) && confettiSlap { confettiCounter += 1 }
                }}) {
                    VStack {
                        Image(systemName: "hand.wave.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 75, maxHeight: 75)
                            .padding(.leading, 16)
                    }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(
                            game.stackClaimSlap == player && easyClaim
                                ? Colors.ersGreen
                                : Colors.ersRed
                        )
                }
            }
            Button(action: {isPaused = true}) {
                Image(systemName: "pause")
                    .font(.system(size: 40))
                    .frame(width: 75, height: 75)
                    .background(.ersGreyBackground)
                    .foregroundColor(.white)
                    .cornerRadius(75)
            }
        }
    }
}

