//
//  GameEndView.swift
//  ERS
//
//  Created by Hersh Nagpal on 3/23/23.
//

import SwiftUI

struct GameEndView: View {
    @Binding var path: [String]
    @Binding var winner: PlayerNumber
    
    var body: some View {
        VStack {
            LargeText("Player \(winner.rawValue) wins!")
            NavigationButton(text: "Back to menu", onPress: {path.removeAll()})
        }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .background(.ultraThinMaterial)
    }
}
