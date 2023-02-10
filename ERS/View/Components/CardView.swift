//
//  Card.swift
//  ERS
//
//  Created by Hersh Nagpal on 1/21/23.
//

import SwiftUI

struct CardView: View {
    
    let card: Card?
    let cardImgApi: String = "https://deckofcardsapi.com/static/img/"
    let cardImgExt: String = ".png"
    
    init(_ card: Card?) {
        self.card = card
    }
    
    var body: some View {
        self.card != nil
        ? AsyncImage(url: getCardUrl(card!)) {
            image in image
                .resizable()
                .scaledToFit()
        } placeholder: {
            ProgressView()
        }
        : AsyncImage(url: getCardBackUrl()) {
            image in image
                .resizable()
                .scaledToFit()
        } placeholder: {
            ProgressView()
        }
    }
    
    func getCardUrl(_ card: Card) -> URL? {
        return URL(string: (cardImgApi + card.abbreviation() + cardImgExt))
    }
    
    func getCardBackUrl() -> URL? {
        return URL(string: (cardImgApi + "back" + cardImgExt))
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(Card(value: .queen, suit: .hearts))
    }
}
