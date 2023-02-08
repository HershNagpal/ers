//
//  ScoreView.swift
//  ERS
//
//  Created by Hersh Nagpal on 2/7/23.
//

import SwiftUI

struct ScoreView: View {
    
    var playerName: String
    var score: Int
    
    var body: some View {
        VStack {
            Text(playerName)
                .bold()
            Text(String(score))
        }
        .padding(10)
        .background(.green)
        .cornerRadius(5)
    }
}

struct ScoreView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreView(playerName: "Hersh", score: 99)
    }
}
