//
//  AchievementsView.swift
//  ERS
//
//  Created by Hersh Nagpal on 2/8/24.
//

import SwiftUI
import GameKit

struct AchievementsView: View {
    var body: some View {
        VStack {
            ScrollView {
                ForEach(AchievementManager.achievementsList, id: \.self) {
                    let achievement = Achievement(
                        id: $0.id,
                        title: $0.title,
                        image: $0.image,
                        percentComplete: AchievementManager.getAchievementProgress($0.id),
                        achievedDescription: $0.achievedDescription,
                        unachievedDescription: $0.unachievedDescription)
                    AchievementView(achievement: achievement)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(10)
        .background(LinearGradient(gradient: Gradient(colors: [.ersDarkBackground, .ersGreyBackground]), startPoint: .bottom, endPoint: .top)).background(LinearGradient(gradient: Gradient(colors: [.ersDarkBackground, .ersGreyBackground]), startPoint: .bottom, endPoint: .top))
        .ignoresSafeArea(.all, edges: .bottom)
        .onAppear {
            AchievementManager.syncAchievements()
        }
    }
}

struct AchievementsView_Previews: PreviewProvider {
    static var previews: some View {
        AchievementsView()
    }
}
