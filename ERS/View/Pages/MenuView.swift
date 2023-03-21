//
//  MenuView.swift
//  ERS
//
//  Created by Hersh Nagpal on 2/9/23.
//

import SwiftUI

struct MenuView: View {
    let openGame: () -> Void
    let openSettings: () -> Void
    
    var body: some View {
        VStack() {
            Spacer()
            TitleText(text: "Egyptian Rat Screw")
            Spacer()
            NavigationButton(text: "Start Game", onPress: self.openGame)
                .padding(.bottom)
            NavigationButton(text: "Settings", onPress: self.openSettings)
            Spacer()
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(openGame: {}, openSettings: {})
    }
}
