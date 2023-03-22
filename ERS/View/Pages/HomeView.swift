//
//  HomeView.swift
//  ERS
//
//  Created by Hersh Nagpal on 3/22/23.
//

import SwiftUI

struct HomeView: View {
    @State var path = [String]()
    
    init() {
            UserDefaults.standard.register(defaults: [
                "easyModeOn": true,
                "doublesOn": true,
                "sandwichOn": true,
                "couplesOn": true,
                "divorceOn": false,
                "queenOfDeathOn": false,
                "burnAmount": 1,
            ])
        }
    
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack(path: $path) {
                VStack {
                    LargeText("Egyptian Rat Screw")
                    NavigationButton(text: "Play", onPress: {path.append("game")})
                    NavigationButton(text: "Settings", onPress: {path.append("settings")})
                }
                .navigationDestination(for: String.self) { string in
                    switch string {
                    case "settings":
                        SettingsView()
                            .navigationTitle("Settings")
                    case "game":
                        ERSView(path: $path)
                            .navigationBarBackButtonHidden()
                            .statusBar(hidden: true)
                    default:
                        Spacer()
                    }
                }
            }
            
        } else {
            // @TODO Fallback on earlier versions 
        }

    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
