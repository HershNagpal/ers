//
//  RuleSectionText.swift
//  ERS
//
//  Created by Hersh Nagpal on 3/25/23.
//

import SwiftUI

struct RuleSectionText: View {
    var text: LocalizedStringKey
    
    init(_ text: LocalizedStringKey) {
        self.text = text
    }
    
    var body: some View {
        Text(text)
            .font(.title2)
            .fontWeight(.thin)
    }
}

