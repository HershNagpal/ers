//
//  MediumText.swift
//  ERS
//
//  Created by Hersh Nagpal on 3/21/23.
//

import SwiftUI

struct MediumText: View {
    var text: LocalizedStringKey
    
    init(_ text: LocalizedStringKey) {
        self.text = text
    }
    
    var body: some View {
        Text(text)
            .font(.subheadline)
            .fontWeight(.thin)
//            .shadow(radius: 2, x: 2, y: 2)
            .foregroundColor(.black)
    }
}


struct MediumText_Previews: PreviewProvider {
    static var previews: some View {
        MediumText("Cards in Deck: 60")
    }
}
