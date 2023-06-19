//
//  TitleText.swift
//  ERS
//
//  Created by Hersh Nagpal on 6/19/23.
//

import SwiftUI

struct TitleText: View {
    var text: LocalizedStringKey
    
    init(_ text: LocalizedStringKey) {
        self.text = text
    }
    
    var body: some View {
        Text(text)
            .font(.largeTitle)
            .fontWeight(.heavy)
            .shadow(radius: 2, x: 2, y: 2)
    }
}

struct TitleText_Previews: PreviewProvider {
    static var previews: some View {
        TitleText("Egyptian Rat Screw")
    }
}
