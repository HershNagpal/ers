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
    var player1Name: String
    var player2Name: String
    var back: () -> Void
    
    init(player1Name: String, player2Name: String, back: @escaping () -> Void) {
        self.player1Name = player1Name
        self.player2Name = player2Name
        self.card1 = Card(value: .queen, suit: .hearts)
        self.card2 = Card(value: .queen, suit: .hearts)
        self.back = back
    }
    
    var body: some View {
        VStack() {
            Spacer()
            game.winner == .one
            ? TitleText(text: player1Name + " Wins")
            : game.winner == .two
                ? TitleText(text: player2Name + " Wins")
            : TitleText(text: "War Game")
            Spacer()
            HStack() {
                VStack() {
                    CardView(game.drawHistory.isEmpty ? nil : game.drawHistory[0])
                        .shadow(radius: 2, x: 2, y: 2)
                        .padding(.bottom)
                    ScoreView(playerName: player1Name, score: game.deck1.numCards())
                }
                VStack() {
                    CardView(game.drawHistory.isEmpty ? nil : game.drawHistory[1])
                        .shadow(radius: 2, x: 2, y: 2)
                        .padding(.bottom)
                    ScoreView(playerName: player2Name, score: game.deck2.numCards())
                }
            }
            Spacer()
            game.winner == .none ? DealButton(onPress: game.takeTurn)
            : DealButton(text: "Game Over", onPress: {})
            Spacer()
            ScoreView(playerName: "Stack", score: game.stack.count)
            Spacer()
            BackButton(onPress: back)
        }
        .padding(10)
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(player1Name: "Yee yee", player2Name: "Dogwater", back: {})
    }
}
