//
//  DebugView.swift
//  ERS
//
//  Created by Hersh Nagpal on 3/21/23.
//

import SwiftUI

struct DebugView: View {
    @StateObject var game: ERSGame
    
    var body: some View {
        VStack {
            Text("Current: \(game.currentPlayer.rawValue)")
            Text("Claim: \(game.stackClaimSlap.rawValue)")
            Text("Countdown: \(game.countdown)")
        }
            .padding(10)
            .foregroundColor(.white)
            .background(.black)
            .cornerRadius(10)
    }
}
