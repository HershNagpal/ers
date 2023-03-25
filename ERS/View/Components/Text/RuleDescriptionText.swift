//
//  RuleDescriptionText.swift
//  ERS
//
//  Created by Hersh Nagpal on 3/25/23.
//

import SwiftUI

struct RuleDescriptionText: View {
    var text: LocalizedStringKey
    
    init(_ text: LocalizedStringKey) {
        self.text = text
    }
    
    var body: some View {
        Text(text)
            .font(.footnote)
            .fontWeight(.light)
            .foregroundColor(.black)
    }
}

struct RuleDescriptionText_Previews: PreviewProvider {
    static var previews: some View {
        RuleDescriptionText("doubles description")
    }
}
