//
//  ERSStackView.swift
//  ERS
//
//  Created by Hersh Nagpal on 3/21/23.
//

import SwiftUI

struct ERSStackView: View {
    @State var card1: Card
    @State var card2: Card
    @State var card3: Card
    
    var body: some View {
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
    }
}

struct ERSStackView_Previews: PreviewProvider {
    static var previews: some View {
        ERSStackView(card1: Card(value: .jack, suit: .hearts),
                     card2: Card(value: .queen, suit: .hearts),
                     card3: Card(value: .king, suit: .hearts))
    }
}
