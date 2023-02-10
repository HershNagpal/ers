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
            Text(String(score))
                .fontWeight(.light)
        }
        .frame(minWidth: 50)
        .padding(10)
        .background(.black)
        .cornerRadius(10)
        .foregroundColor(.white)
        .shadow(radius: 2, x: -2, y: 2)
    }
}

struct ScoreView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreView(playerName: "Hersh", score: 99)
    }
}
