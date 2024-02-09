//
//  AchievementTitleText.swift
//  ERS
//
//  Created by Hersh Nagpal on 2/9/24.
//

import SwiftUI

struct AchievementTitleText: View {
    var text: String
    
    init(_ text: String) {
        self.text = text
    }
    
    var body: some View {
        Text(text)
            .font(.title2)
            .fontWeight(.thin)
    }
}

#Preview {
    AchievementTitleText("Defeat Easy Bot")
}
