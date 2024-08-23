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
    let backgroundColor: Color
    let foregroundColor: Color
    
    init(text: LocalizedStringKey, onPress: @escaping () -> Void, isDisabled: Bool = false, backgroundColor: Color = .black, foregroundColor: Color = .white) {
        self.text = text
        self.onPress = onPress
        self.isDisabled = isDisabled
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
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
                    .foregroundColor(foregroundColor)
                    .background(backgroundColor)
            }
            .cornerRadius(10)
        } else {
            Button() {
                return
            } label: {
                ButtonText(text)
                    .frame(width: 300, height: 50)
                    .padding(10)
                    .foregroundColor(.white)
                    .background(.gray)
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
