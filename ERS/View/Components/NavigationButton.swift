//
//  NavigationButton.swift
//  ERS
//
//  Created by Hersh Nagpal on 2/10/23.
//

import SwiftUI

struct NavigationButton: View {
    let text: String
    let onPress: () -> Void
    
    var body: some View {
        Button() {
            onPress()
        } label: {
            ButtonText(text)
                .frame(width: 300, height: 50)
                .padding(10)
                .background(.black)
        }
        
        .cornerRadius(10)
        .foregroundColor(.white)
        .shadow(radius: 2, x: -2, y: 2)
        
    }
}

struct NavigationButton_Previews: PreviewProvider {
    static var previews: some View {
        NavigationButton(text: "Start Game", onPress: {})
    }
}
