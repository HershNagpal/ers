//
//  DealButton.swift
//  ERS
//
//  Created by Hersh Nagpal on 2/10/23.
//

import SwiftUI

struct DealButton: View {
    var text: String?
    let onPress: () -> Void

    var body: some View {
        Button() {
            onPress()
        } label: {
            Text(text ?? "Deal")
        }
        .frame(width: 150)
        .padding(10)
        .background(.green)
        .cornerRadius(10)
        .foregroundColor(.white)
        .shadow(radius: 2, x: -2, y: 2)
    }
}

struct DealButton_Previews: PreviewProvider {
    static var previews: some View {
        DealButton(text: nil, onPress: {})
    }
}
