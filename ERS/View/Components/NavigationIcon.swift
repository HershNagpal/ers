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
    
    var body: some View {
        Button() {
            onPress()
        } label: {
            Image(systemName: iconName)
                .frame(width: 35, height: 35)
                .padding()
                .foregroundColor(.white)
                .background(.black)
                .font(.system(size: 35))
        }
        .cornerRadius(10)
        .shadow(radius: 2, x: -2, y: 2)
    }
}

#Preview {
    HStack(spacing: 24) {
        NavigationIcon(iconName: "trophy.fill", onPress: {})
        NavigationIcon(iconName: "doc.questionmark", onPress: {})
        NavigationIcon(iconName: "gearshape.fill", onPress: {})
    }
}
