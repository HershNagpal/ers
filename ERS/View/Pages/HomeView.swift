//
//  HomeView.swift
//  ERS
//
//  Created by Hersh Nagpal on 3/22/23.
//

import SwiftUI

@available(iOS 16.0, *)
struct HomeView: View {
    @State var path = [String]()
    
    init() {
            UserDefaults.standard.register(defaults: [
                "easyDeal": true,
                "easyClaim": true,
                "doublesOn": true,
                "sandwichOn": true,
                "couplesOn": true,
                "divorceOn": false,
                "queenOfDeathOn": false,
                "topAndBottomOn": false,
                "burnAmount": 1,
            ])
        }
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack(spacing: 20) {
                Spacer()
                LargeText("ers")
                Spacer()
                NavigationButton(text: "play", onPress: {path.append("game")})
                NavigationButton(text: "tutorial", onPress: {path.append("tutorial")})
                NavigationButton(text: "settings", onPress: {path.append("settings")})
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .background(Colors.yellow)
            .navigationDestination(for: String.self) { string in
                switch string {
                case "settings":
                    SettingsView()
                        .navigationTitle("settings")
                case "game":
                    GameView(path: $path)
                        .navigationBarBackButtonHidden()
                        .statusBar(hidden: true)
                case "tutorial":
                    TutorialView(path: $path)
                        .navigationTitle("tutorial")
                default:
                    Spacer()
                }
            }
        }
    }
}
