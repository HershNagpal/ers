//
//  AchievementView.swift
//  ERS
//
//  Created by Hersh Nagpal on 2/8/24.
//

import SwiftUI
import GameKit

struct AchievementView: View {
    let achievement: Achievement
    
    var body: some View {
        HStack {
            Image(systemName: achievement.image)
                .foregroundColor(achievement.isCompleted ? .ersGreen : .ersDarkGrey)
                .font(.title)
            VStack(alignment: .leading) {
                AchievementTitleText(achievement.title)
                AchievementDescriptionText(achievement.isCompleted ? achievement.achievedDescription : achievement.unachievedDescription)
                if achievement.percentComplete > 0 && achievement.percentComplete < 100 {
                    ProgressView(value: Float(achievement.percentComplete)/100)
                        .tint(.ersGreen)
                }
            }
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .foregroundColor(.black)
        .background(.white)
        .border(achievement.isCompleted ? .ersGreen : .ersDarkGrey, width: 5)
        .cornerRadius(8)
    }
}


#Preview {
    VStack {
        AchievementView(achievement: 
                            Achievement( id: .allRulesWin,
                         title: "Rules and Consequences",
                         image: "flag.fill", percentComplete: 0,
                         achievedDescription: "Won a game with every rule activated.",
                         unachievedDescription: "Win a game with every rule and extra rule activated."))
        AchievementView(achievement:
                            Achievement( id: .hundredGames,
                         title: "Rules and Consequences",
                                         image: "flag.fill", percentComplete: 50,
                         achievedDescription: "Won a game with every rule activated.",
                         unachievedDescription: "Win a game with every rule and extra rule activated."))
        AchievementView(achievement:
                            Achievement( id: .hundredGames,
                         title: "Rules and Consequences",
                                         image: "flag.fill", percentComplete: 100,
                         achievedDescription: "Won a game with every rule activated.",
                         unachievedDescription: "Win a game with every rule and extra rule activated."))
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .padding(10)
    .background(Colors.ersOrange)
}
