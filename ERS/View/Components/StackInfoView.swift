//
//  StackInfoView.swift
//  ERS
//
//  Created by Hersh Nagpal on 3/22/23.
//

import SwiftUI

struct StackInfoView: View {
    @Binding var stack: [Card]
    @Binding var burnPile: [Card]
    @Binding var deck: Deck
    
    var body: some View {
        HStack(spacing: 0) {
            VStack(spacing: 0) {
                Image("stack")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 50, maxHeight: 50)
                MediumText("\(stack.count)")
                    
            }
            VStack(spacing: 0) {
                Image("burn")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 50, maxHeight: 50)
                MediumText("\(burnPile.count)")
            }
            VStack(spacing: 0) {
                Image("deck")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 50, maxHeight: 50)
                MediumText("\(deck.numCards())")
            }
            Spacer()
        }
    }
}

