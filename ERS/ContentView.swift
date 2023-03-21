//
//  ContentView.swift
//  ERS
//
//  Created by Hersh Nagpal on 1/19/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var currentView: ViewType
    
    var body: some View {
        switch (currentView) {
        case .game:
            ERSView(back: {self.changeView(.menu)})
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
        ContentView(currentView: .menu)
    }
}
