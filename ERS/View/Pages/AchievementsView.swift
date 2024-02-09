//
//  AchievementsView.swift
//  ERS
//
//  Created by Hersh Nagpal on 2/8/24.
//

import SwiftUI
import GameKit

struct AchievementsView: View {
    @Binding var path: [String]
    
    var body: some View {
        ScrollView {
            ForEach(Achievement.achievementsList, id: \.self) {
                AchievementView(achievement: $0)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(10)
        .background(Colors.ersOrange)
    }
    
}

struct AchievementsView_Previews: PreviewProvider {
    static var previews: some View {
        @State var path = ["a"]
        AchievementsView(path: $path)
    }
}
