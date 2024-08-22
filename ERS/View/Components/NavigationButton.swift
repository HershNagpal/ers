//
//  NavigationButton.swift
//  ERS
//
//  Created by Hersh Nagpal on 2/10/23.
//

import SwiftUI

struct NavigationButton: View {
    let text: LocalizedStringKey
    let onPress: () -> Void
    let isDisabled: Bool
    
    init(text: LocalizedStringKey, onPress: @escaping () -> Void, isDisabled: Bool = false) {
        self.text = text
        self.onPress = onPress
        self.isDisabled = isDisabled
    }
    
    var body: some View {
        if !isDisabled {
            Button() {
                onPress()
            } label: {
                HStack {
                    ButtonText(text)
                        .padding([.leading, .trailing])
                }
                    .frame(maxWidth: 500)
                    .padding()
                    .foregroundColor(.white)
                    .background(.black)
            }
            .cornerRadius(10)
            .shadow(radius: 2, x: -2, y: 2)
        } else {
            Button() {
                return
            } label: {
                ButtonText(text)
                    .frame(width: 300, height: 50)
                    .padding(10)
                    .foregroundColor(.white)
                    .background(Colors.ersDarkGrey)
            }
            .cornerRadius(10)
        }
    }
}

struct NavigationButton_Previews: PreviewProvider {
    static var previews: some View {
        NavigationButton(text: "Singleplayer", onPress: {})
    }
}
