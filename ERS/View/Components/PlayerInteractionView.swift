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
    @State var easyModeOn: Bool = UserDefaults.standard.bool(forKey: "easyModeOn")
    
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

