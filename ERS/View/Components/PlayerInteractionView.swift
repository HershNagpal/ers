//
//  PlayerInteractionView.swift
//  ERS
//
//  Created by Hersh Nagpal on 3/21/23.
//

import SwiftUI

struct PlayerInteractionView: View {
    @Binding var isPaused: Bool
    @StateObject var game: ERSGame
    var player: PlayerNumber
    @State var easyDeal: Bool = UserDefaults.standard.bool(forKey: "easyDeal")
    @State var easyClaim: Bool = UserDefaults.standard.bool(forKey: "easyClaim")
    
    var body: some View {
        ZStack {
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
                        easyDeal
                            ? game.currentPlayer == player && game.stackClaimSlap == .none
                                ? Color(.systemBlue)
                                : Color(.systemGray)
                        : Color(.systemBlue)
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
                        game.stackClaimSlap == player && easyClaim
                            ? Color(.systemGreen)
                            : Color(.systemRed)
                    )
                }
                
            }
            Button(action: {isPaused = true}) {
                Image(systemName: "pause")
                    .font(.system(size: 30))
                    .frame(width: 75, height: 75)
                    .background(Color.orange)
                    .foregroundColor(.black)
                    .cornerRadius(75)
            }
        }
    }
}

