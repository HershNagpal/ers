//
//  PlayerInteractionView.swift
//  ERS
//
//  Created by Hersh Nagpal on 3/21/23.
//

import SwiftUI

struct PlayerInteractionView: View {
    @Binding var isPaused: Bool
    @StateObject var game: Game
    let isDisabled: Bool
    var player: PlayerNumber
    @AppStorage("easyClaim") var easyClaim: Bool = true
    @AppStorage("easyDeal") var easyDeal: Bool = true
    @Binding var confettiCounter: Int
    
    var body: some View {
        ZStack {
            HStack(spacing: 0) {
                Button(action: { if !isDisabled {game.deal(player)}}) {
                    VStack {
                        Image("deck")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 100, maxHeight: 100)
                    }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(
                            easyDeal
                                ? game.currentPlayer == player && game.stackClaimSlap == .none
                                ? Colors.ersGreen
                                : Colors.ersGrey
                            : Colors.ersGreen
                        )
                }
                Button(action: { if !isDisabled {
                    if game.slap(player) { confettiCounter += 1 }
                }}) {
                    VStack {
                        Image("hand")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 100, maxHeight: 100)
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
                    .background(Colors.ersYellow)
                    .foregroundColor(.black)
                    .cornerRadius(75)
            }
        }
    }
}

