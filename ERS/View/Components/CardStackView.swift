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
        }
    }
}

struct ERSStackView_Previews: PreviewProvider {
    static var previews: some View {
        CardStackView(game: ERSGame())
    }
}
