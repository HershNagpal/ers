//
//  ERSStackView.swift
//  ERS
//
//  Created by Hersh Nagpal on 3/21/23.
//

import SwiftUI

struct CardStackView: View {
    @StateObject var game: ERSGame
    
    var body: some View {
        VStack {
            HStack {
                Text("Stack: \(game.stack.count)")
                Text("Burned: \(game.burnPile.count)")
            }
                .rotationEffect(Angle(degrees: 180))
                .offset(x: 0, y: -40)
            
            ZStack() {
                CardView(
                    game.stack.count > 2 ? game.stack[2] : Card(value: .none, suit: .none)
                )
                    .offset(x: -60, y: -40)
                    .shadow(radius: 2, x: 2, y: 2)
                    .padding(.bottom)
                    .frame(width: 200)
                CardView(
                    game.stack.count > 1 ? game.stack[1] : Card(value: .none, suit: .none)
                )
                    .offset(x: 0, y: 0)
                    .shadow(radius: 2, x: 2, y: 2)
                    .padding(.bottom)
                    .frame(width: 200)
                CardView(
                    game.stack.count >= 1 ? game.stack[0] : Card(value: .none, suit: .none)
                )
                    .offset(x: 60, y: 40)
                    .shadow(radius: 2, x: 2, y: 2)
                    .padding(.bottom)
                    .frame(width: 200)
            }
            HStack {
                Text("Stack: \(game.stack.count)")
                Text("Burned: \(game.burnPile.count)")
            }
                .offset(x: 0, y: 40)
        }
    }
}

struct ERSStackView_Previews: PreviewProvider {
    static var previews: some View {
        CardStackView(game: ERSGame())
    }
}
