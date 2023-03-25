//
//  TutorialText.swift
//  ERS
//
//  Created by Hersh Nagpal on 3/24/23.
//

import SwiftUI

struct TutorialText: View {
    var text: LocalizedStringKey
    
    init(_ text: LocalizedStringKey) {
        self.text = text
    }
    
    var body: some View {
        Text(text)
            .font(.title3)
            .fontWeight(.light)
    }
}

struct TutorialText_Previews: PreviewProvider {
    static var previews: some View {
        TutorialText("t2")
    }
}
