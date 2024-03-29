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
    @State var burnScaleAmount: Double = 0
    @State var deckScaleAmount: Double = 0
    @State var lastDeckCount: Int
    
    var body: some View {
        HStack(spacing: 5) {
            VStack(spacing: 0) {
                Image("stack")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 40, maxHeight: 40)
                MediumText("\(stack.count)")
                    
            }
            VStack(spacing: 0) {
                Image("burn")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 40, maxHeight: 40)
                    .scaleEffect(1 + burnScaleAmount)
                    .onChange(of: burnPile.count) { count in
                        if count != 0 && burnPile.count != 0 {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                burnScaleAmount = 0.5
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                withAnimation(.easeInOut(duration: 0.2)) {
                                    burnScaleAmount = 0.0
                                }
                            }
                        }
                    }
                MediumText("\(burnPile.count)")
            }
            VStack(spacing: 0) {
                Image("deck")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 40, maxHeight: 40)
                    .scaleEffect(1 + deckScaleAmount)
                    .onChange(of: deck.numCards()) { count in
                        if count > lastDeckCount {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                deckScaleAmount = 0.5
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                withAnimation(.easeInOut(duration: 0.2)) {
                                    deckScaleAmount = 0.0
                                }
                            }
                        }
                        lastDeckCount = count
                    }
                MediumText("\(deck.numCards())")
            }
            Spacer()
        }
    }
}

