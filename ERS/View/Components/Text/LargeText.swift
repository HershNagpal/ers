//
//  TitleText.swift
//  ERS
//
//  Created by Hersh Nagpal on 2/10/23.
//

import SwiftUI

struct LargeText: View {
    var text: LocalizedStringKey
    
    init(_ text: LocalizedStringKey) {
        self.text = text
    }
    
    var body: some View {
        Text(text)
            .font(.largeTitle)
            .fontWeight(.thin)
            .shadow(radius: 2, x: 2, y: 2)
            .foregroundColor(.black)
    }
}

struct LargeText_Previews: PreviewProvider {
    static var previews: some View {
        LargeText("Egyptian Rat Screw")
    }
}
