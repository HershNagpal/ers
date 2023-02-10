//
//  ContentView.swift
//  ERS
//
//  Created by Hersh Nagpal on 1/19/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var currentView: ViewType
    @State var player1Name: String?
    @State var player2Name: String?
    
    var body: some View {
        switch (currentView) {
        case .game:
            GameView(player1Name: player1Name ?? "Player 1", player2Name: player2Name ?? "Player 2", back: {self.changeView(.menu)})
        case .menu:
            MenuView(openGame: {self.changeView(.game)}, openSettings: {self.changeView(.settings)})
        case .settings:
            SettingsView(back: {self.changeView(.menu)})
            
        }
    }
    
    func changeView(_ newView: ViewType) {
        self.currentView = newView
    }
}

enum ViewType: String {
    case menu, game, settings
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(currentView: .menu, player1Name: "Hee", player2Name: "Hoo")
    }
}
