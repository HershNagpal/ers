//
//  ERSView.swift
//  ERS
//
//  Created by Hersh Nagpal on 3/20/23.
//

import SwiftUI

struct ERSView: View {
    @StateObject var game = WarGame()
    @State var card1: Card
    @State var card2: Card
    @State var card3: Card
    var player1Name: String
    var player2Name: String
    var back: () -> Void
    
    init(player1Name: String, player2Name: String, back: @escaping () -> Void) {
        self.player1Name = player1Name
        self.player2Name = player2Name
        self.card1 = Card(value: .king, suit: .hearts)
        self.card2 = Card(value: .queen, suit: .hearts)
        self.card3 = Card(value: .jack, suit: .hearts)
        self.back = back
    }
    
    func addToViewStack(card: Card) {
        self.card3 = card2
        self.card2 = card1
        self.card1 = card
    }
    
    var body: some View {
        VStack {
            Spacer()
            ZStack() {
                CardView(card3)
                    .offset(x: -60, y: -40)
                    .shadow(radius: 2, x: 2, y: 2)
                    .padding(.bottom)
                    .frame(width: 200)
                CardView(card2)
                    .offset(x: 0, y: 0)
                    .shadow(radius: 2, x: 2, y: 2)
                    .padding(.bottom)
                    .frame(width: 200)
                CardView(card1)
                    .offset(x: 60, y: 40)
                    .shadow(radius: 2, x: 2, y: 2)
                    .padding(.bottom)
                    .frame(width: 200)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .background(Color.blue)
            DealButton(text: "deal", onPress: {addToViewStack(card: Card(value: .ace, suit: .spades))} )
        }
    }
}

struct ERSView_Previews: PreviewProvider {
    static var previews: some View {
        ERSView(player1Name: "yee", player2Name: "yee2", back: {})
    }
}
