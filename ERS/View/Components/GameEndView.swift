//
//  GameEndView.swift
//  ERS
//
//  Created by Hersh Nagpal on 3/23/23.
//

import SwiftUI

struct GameEndView: View {
    @Binding var winner: PlayerNumber
    let navigateHome: () -> Void
    
    var body: some View {
        VStack {
            LargeText(LocalizedStringKey("player " + winner.rawValue + " wins"))
            NavigationButton(text: "back to menu", onPress: { navigateHome() })
                .padding()
        }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .background(.ultraThinMaterial)
    }
}

