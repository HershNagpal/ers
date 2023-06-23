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
                                ? Colors.green
                                : Colors.grey
                            : Colors.green
                        )
                }
                Button(action: { if !isDisabled {game.slap(player)}}) {
                    VStack {
                        Image("hand")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 100, maxHeight: 100)
                    }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(
                            game.stackClaimSlap == player && easyClaim
                                ? Colors.green
                                : Colors.red
                        )
                }
                
            }
            Button(action: {isPaused = true}) {
                Image(systemName: "pause")
                    .font(.system(size: 40))
                    .frame(width: 75, height: 75)
                    .background(Colors.yellow)
                    .foregroundColor(.black)
                    .cornerRadius(75)
            }
        }
    }
}

