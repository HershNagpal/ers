//
//  RuleTitleText.swift
//  ERS
//
//  Created by Hersh Nagpal on 3/25/23.
//

import SwiftUI

struct RuleTitleText: View {
    var text: LocalizedStringKey
    
    init(_ text: LocalizedStringKey) {
        self.text = text
    }
    
    var body: some View {
        Text(text)
            .font(.title2)
            .fontWeight(.light)
            .foregroundColor(.black)
    }
}

struct RuleTitleText_Previews: PreviewProvider {
    static var previews: some View {
        RuleTitleText("Rule Title")
    }
}
