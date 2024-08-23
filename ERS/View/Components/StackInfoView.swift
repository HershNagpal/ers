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
    @State var burnScale: Bool = false
    @State var deckScale: Bool = false
    @State var lastDeckCount: Int
    
    var body: some View {
        HStack(spacing: 8) {
            VStack(spacing: 4) {
                Image(systemName: "rectangle.stack")
                    .resizable()
                    .scaledToFit()
                    .rotationEffect(.degrees(270))
                    .frame(maxWidth: 30, maxHeight: 30)
                MediumText("\(stack.count)")
                    
            }
            VStack(spacing: 4) {
                Image(systemName: "flame")
                    .resizable()
                    .scaledToFit()
                    .symbolRenderingMode(.multicolor)
                    .symbolEffect(.bounce, value: burnScale)
                    .frame(maxWidth: 30, maxHeight: 30)
                    .onChange(of: burnPile.count) {
                        burnScale.toggle()
                    }
                MediumText("\(burnPile.count)")
            }
            Spacer()
        }
    }
}

