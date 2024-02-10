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
    @State var isCompleted: Bool = false
    
    var body: some View {
        HStack {
            Image(systemName: achievement.image)
                .foregroundColor(isCompleted ? .ersGreen : .ersDarkGrey)
                .font(.title)
            VStack(alignment: .leading) {
                AchievementTitleText(achievement.title)
                AchievementDescriptionText(isCompleted ? achievement.achievedDescription : achievement.unachievedDescription)
                if achievement.id == .hundredBotWins {
                    ProgressView(value: Float(Achievement.getAchievementProgress(.botGamesWon))/100)
                        .tint(.ersGreen)
                } else if achievement.id == .hundredGames {
                    ProgressView(value: Float(Achievement.getAchievementProgress(.gamesPlayed))/100)
                        .tint(.ersGreen)
                } else if achievement.id == .thousandGames {
                    ProgressView(value: Float(Achievement.getAchievementProgress(.gamesPlayed))/1000)
                        .tint(.ersGreen)
                }
            }
            Spacer()
        }
        .onAppear {
            self.isCompleted = Achievement.hasCompletedAchievement(achievement.id.rawValue)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .foregroundColor(.black)
        .background(.white)
        .border(isCompleted ? .ersGreen : .ersDarkGrey, width: 5)
        .cornerRadius(8)
    }
}


#Preview {
    VStack {
        AchievementView(achievement: 
                            Achievement( id: .allRulesWin,
                         title: "Rules and Consequences",
                         image: "flag.fill", isCompleted: nil,
                         achievedDescription: "Won a game with every rule activated.",
                         unachievedDescription: "Win a game with every rule and extra rule activated."))
        AchievementView(achievement:
                            Achievement( id: .hundredGames,
                         title: "Rules and Consequences",
                         image: "flag.fill", isCompleted: nil,
                         achievedDescription: "Won a game with every rule activated.",
                         unachievedDescription: "Win a game with every rule and extra rule activated."))
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .padding(10)
    .background(Colors.ersOrange)
}
