//
//  OnlineGameView.swift
//  ERS
//
//  Created by Hersh Nagpal on 8/23/24.
//

import SwiftUI

struct OnlineGameView: View {
    @Binding var path: [String]
    @StateObject var onlineMatch = OnlineMatch()
    
    var body: some View {
        ZStack {
            if onlineMatch.playingGame, let game = onlineMatch.game {
                GameView(path: $path, game: game, localPlayer: game.localPlayer, isSingleplayer: false,
                         sendAction: {onlineMatch.sendAction(action: $0, player: $1)})
//                Text("\(onlineMatch.localPlayerNumber.rawValue) : \(onlineMatch.game?.localPlayer.rawValue ?? "3") : \(onlineMatch.game?.currentPlayer.rawValue ?? "3")")
//                    .foregroundColor(.white)
//                    .background(.black)
            } else {
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                    }
                }
                .background(LinearGradient(gradient: Gradient(colors: [.ersDarkBackground, .ersGreyBackground]), startPoint: .bottom, endPoint: .top))
            }
        }
        .onAppear() {
            onlineMatch.choosePlayer()
        }
    }
}

#Preview {
    OnlineGameView(path: .constant([]))
}
