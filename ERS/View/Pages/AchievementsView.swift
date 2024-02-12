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
        VStack {
            ScrollView {
                ForEach(AchievementManager.achievementsList, id: \.self) {
                    AchievementView(achievement: $0)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(10)
        .background(LinearGradient(gradient: Gradient(colors: [.ersYellow, .ersOrange]), startPoint: .top, endPoint: .bottom))
        .ignoresSafeArea(.all, edges: .bottom)
    }
}

struct AchievementsView_Previews: PreviewProvider {
    static var previews: some View {
        @State var path = ["a"]
        AchievementsView(path: $path)
    }
}
