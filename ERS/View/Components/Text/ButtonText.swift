//
//  ButtonText.swift
//  ERS
//
//  Created by Hersh Nagpal on 3/23/23.
//

import SwiftUI

struct ButtonText: View {
    var text: LocalizedStringKey
    
    init(_ text: LocalizedStringKey) {
        self.text = text
    }
    
    var body: some View {
        Text(text)
            .font(.title)
            .fontWeight(.thin)
            .foregroundColor(.white)
    }
}

struct ButtonText_Previews: PreviewProvider {
    static var previews: some View {
        ButtonText("Button")
    }
}
