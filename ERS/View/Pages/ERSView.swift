//
//  ERSView.swift
//  ERS
//
//  Created by Hersh Nagpal on 3/20/23.
//

import SwiftUI

struct ERSView: View {
    @StateObject var game = ERSGame()
    var player1Name: String
    var player2Name: String
    var back: () -> Void
    
    init(player1Name: String, player2Name: String, back: @escaping () -> Void) {
        self.player1Name = player1Name
        self.player2Name = player2Name
        self.back = back
    }
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    VStack() {
                        DealButton(text: "deal", onPress: {game.drawCard(.two)} )
                        DealButton(text: "slap", onPress: {game.slap(.two)})
                    }
                    Text("\(game.deck2.numCards())")
                }
                .rotationEffect(Angle(degrees: 180))
                
                ERSStackView(game: game)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                
                HStack {
                    VStack() {
                        DealButton(text: "deal", onPress: {game.drawCard(.one)} )
                        DealButton(text: "slap", onPress: {game.slap(.one)})
                        DealButton(text: "print", onPress: {print(game.stack[0].toString())})
                    }
                    Text("\(game.deck1.numCards())")
                }
            }
            if (game.winner != .none) {
                VStack {
                    Text("Player \(game.winner.rawValue) wins")
                    NavigationButton(text: "Back to menu", onPress: back)
                }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    .background(.ultraThinMaterial)
            }
        }
    }
}

struct ERSView_Previews: PreviewProvider {
    static var previews: some View {
        ERSView(player1Name: "yee", player2Name: "yee2", back: {})
    }
}
