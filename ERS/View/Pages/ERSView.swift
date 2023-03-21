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
        VStack {
            HStack {
                Text("\(game.deck2.numCards())")
                VStack() {
                    DealButton(text: "slap", onPress: {game.slap()})
                    DealButton(text: "deal", onPress: {} )
                }
            }
            
            ERSStackView(stack: game.stack)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            
            HStack {
                VStack() {
                    DealButton(text: "deal", onPress: {} )
                    DealButton(text: "slap", onPress: {game.slap()})
                }
                Text("\(game.deck1.numCards())")
            }
        }
    }
}

struct ERSView_Previews: PreviewProvider {
    static var previews: some View {
        ERSView(player1Name: "yee", player2Name: "yee2", back: {})
    }
}
