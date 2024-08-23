//
//  NavigationIcon.swift
//  ERS
//
//  Created by Hersh Nagpal on 8/21/24.
//

import SwiftUI

struct NavigationIcon: View {
    let iconName: String
    let onPress: () -> Void
    let backgroundColor: Color
    let foregroundColor: Color
    
    init(iconName: String, onPress: @escaping () -> Void, isDisabled: Bool = false, backgroundColor: Color = .black, foregroundColor: Color = .white) {
        self.iconName = iconName
        self.onPress = onPress
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
    }
    
    var body: some View {
        Button() {
            onPress()
        } label: {
            Image(systemName: iconName)
                .frame(width: 35, height: 35)
                .padding()
                .foregroundColor(foregroundColor)
                .background(backgroundColor)
                .font(.system(size: 35))
        }
        .cornerRadius(10)
    }
}

#Preview {
    HStack(spacing: 24) {
        NavigationIcon(iconName: "trophy.fill", onPress: {})
        NavigationIcon(iconName: "doc.questionmark", onPress: {})
        NavigationIcon(iconName: "gearshape.fill", onPress: {})
    }
}
