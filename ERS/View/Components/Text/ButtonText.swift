//
//  ButtonText.swift
//  ERS
//
//  Created by Hersh Nagpal on 3/23/23.
//

import SwiftUI

struct ButtonText: View {
    var text: String
    
    init(_ text: String) {
        self.text = text
    }
    
    var body: some View {
        Text(text)
            .font(.title)
            .fontWeight(.thin)
    }
}

struct ButtonText_Previews: PreviewProvider {
    static var previews: some View {
        ButtonText("Button")
    }
}
