//
//  SettingsButton.swift
//  ERS
//
//  Created by Hersh Nagpal on 5/15/23.
//

import SwiftUI

struct SettingsButton: View {
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
                RuleTitleText(text)
                    .padding(10)
            }
        } else {
            Button() {
                return
            } label: {
                RuleTitleText(text)
                    .foregroundColor(.white)
                    .background(.gray)
            }
        }
    }
}

struct SettingsButton_Previews: PreviewProvider {
    static var previews: some View {
        NavigationButton(text: "Restore Purchases", onPress: {})
    }
}
