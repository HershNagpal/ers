//
//  ERSStackView.swift
//  ERS
//
//  Created by Hersh Nagpal on 3/21/23.
//

import SwiftUI

struct ERSStackView: View {
    @State var stack: [Card]
    
    var body: some View {
        ZStack() {
            CardView(stack[2])
                .offset(x: -60, y: -40)
                .shadow(radius: 2, x: 2, y: 2)
                .padding(.bottom)
                .frame(width: 200)
            CardView(stack[1])
                .offset(x: 0, y: 0)
                .shadow(radius: 2, x: 2, y: 2)
                .padding(.bottom)
                .frame(width: 200)
            CardView(stack[0])
                .offset(x: 60, y: 40)
                .shadow(radius: 2, x: 2, y: 2)
                .padding(.bottom)
                .frame(width: 200)
        }
    }
}

struct ERSStackView_Previews: PreviewProvider {
    static var previews: some View {
        ERSStackView(stack: [Card(value: .jack, suit: .hearts),
                     Card(value: .queen, suit: .hearts),
                     Card(value: .king, suit: .hearts)])
    }
}
