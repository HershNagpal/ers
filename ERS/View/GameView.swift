//
//  GameView.swift
//  ERS
//
//  Created by Hersh Nagpal on 1/20/23.
//

import SwiftUI

struct GameView: View {
    
    @StateObject var game = WarGame()
    @State var card1: Card
    @State var card2: Card
    
    init() {
        self.card1 = Card(value: .queen, suit: .hearts)
        self.card2 = Card(value: .queen, suit: .hearts)
    }
    
    var body: some View {
        VStack() {
            Spacer()
            HStack() {
                Spacer()
                CardView(game.drawHistory.isEmpty ? nil : game.drawHistory[0])
                Spacer()
                CardView(game.drawHistory.isEmpty ? nil : game.drawHistory[1])
                Spacer()
            }
            Spacer()
            Button("Deal") {
                game.takeTurn()
            }
                .padding(10)
                .background(.yellow)
                .cornerRadius(5)
            Spacer()
            HStack() {
                Spacer()
                ScoreView(playerName: "Player1", score: game.deck1.numCards())
                Spacer()
                ScoreView(playerName: "Stack", score: game.stack.count)
                Spacer()
                ScoreView(playerName: "Player2", score: game.deck2.numCards())
                Spacer()
            }
            Spacer()
        }
        .padding(10)
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
