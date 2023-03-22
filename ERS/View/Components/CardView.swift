//
//  Card.swift
//  ERS
//
//  Created by Hersh Nagpal on 1/21/23.
//

import SwiftUI

struct CardView: View {
    let card: Card
    
    init(_ card: Card) {
        self.card = card
    }
    
    var body: some View {
        if (card.value == .none || card.suit == .none) {
            Image("Back")
        } else {
            Image(card.abbreviation())
                .resizable()
                .scaledToFit()
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(Card(value: .queen, suit: .hearts))
    }
}
