//
//  AchievementDescriptionText.swift
//  ERS
//
//  Created by Hersh Nagpal on 2/9/24.
//

import SwiftUI

struct AchievementDescriptionText: View {
    var text: String
    
    init(_ text: String) {
        self.text = text
    }
    
    var body: some View {
        Text(text)
            .font(.subheadline)
            .fontWeight(.thin)
            .foregroundColor(.black)
    }
}

#Preview {
    AchievementDescriptionText("Win a singleplayer game against the Easy difficult bot")
}
