//
//  GameView.swift
//  ERS
//
//  Created by Hersh Nagpal on 1/20/23.
//

import SwiftUI

struct WarView: View {
    
    @StateObject var warGame = WarGame()
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
            warGame.winner == .one
            ? TitleText(text: player1Name + " Wins")
            : warGame.winner == .two
                ? TitleText(text: player2Name + " Wins")
            : TitleText(text: "War Game")
            Spacer()
            HStack() {
                VStack() {
                    CardView(warGame.drawHistory.isEmpty ? nil : warGame.drawHistory[0])
                        .shadow(radius: 2, x: 2, y: 2)
                        .padding(.bottom)
                    ScoreView(playerName: player1Name, score: warGame.deck1.numCards())
                }
                VStack() {
                    CardView(warGame.drawHistory.isEmpty ? nil : warGame.drawHistory[1])
                        .shadow(radius: 2, x: 2, y: 2)
                        .padding(.bottom)
                    ScoreView(playerName: player2Name, score: warGame.deck2.numCards())
                }
            }
            Spacer()
            warGame.winner == .none ? DealButton(onPress: warGame.takeTurn)
            : DealButton(text: "Game Over", onPress: {})
            Spacer()
            ScoreView(playerName: "Stack", score: warGame.stack.count)
            Spacer()
            BackButton(onPress: back)
        }
        .padding(10)
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        WarView(player1Name: "Yee yee", player2Name: "Dogwater", back: {})
    }
}
