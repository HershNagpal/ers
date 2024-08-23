//
//  ERSStackView.swift
//  ERS
//
//  Created by Hersh Nagpal on 3/21/23.
//

import SwiftUI

struct CardStackView: View {
    @Binding var stack: [Card]
    let rotationValue: Double = 30
    @AppStorage("flatStack") var flatStack: Bool = true
    
    var body: some View {
        if flatStack {
            ZStack() {
                CardView(
                    stack.count > 2 ? stack[2] : Card(value: .none, suit: .none)
                )
                .offset(x: -60, y: -40)
                .shadow(radius: 2, x: 2, y: 2)
                .padding(.bottom)
                .frame(width: 200)
                CardView(
                    stack.count > 1 ? stack[1] : Card(value: .none, suit: .none)
                )
                .offset(x: 0, y: 0)
                .shadow(radius: 2, x: 2, y: 2)
                .padding(.bottom)
                .frame(width: 200)
                CardView(
                    stack.count >= 1 ? stack[0] : Card(value: .none, suit: .none)
                )
                .offset(x: 60, y: 40)
                .shadow(radius: 2, x: 2, y: 2)
                .padding(.bottom)
                .frame(width: 200)
            }
        } else {
            ZStack() {
                ForEach(Array(stack.reversed().enumerated()), id: \.offset) { index, card in
                    CardView(card)
                        .rotationEffect(.degrees(Double(index) * rotationValue))
                        .shadow(radius: 2, x: 2, y: 2)
                        .padding(.bottom)
                        .frame(width: 200)
                }
            }
        }
    }
}

