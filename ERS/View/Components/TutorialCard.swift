//
//  TutorialCard.swift
//  ERS
//
//  Created by Hersh Nagpal on 3/24/23.
//

import SwiftUI

struct TutorialCard: View {
    var text: LocalizedStringKey
    static let tutorialStrings: [String] = [
        "Welcome to the tutorial for Egyptian Rat Screw! This is a card game where players try to collect the whole deck through quick reflexes and some good luck."
    ]
    
    init(_ text: LocalizedStringKey) {
        self.text = text
    }
    
    var body: some View {
        VStack {
            MediumText(text)
        }
        .foregroundColor(.black)
        .frame(width: 200)
        .background(Colors.orange)
    }
}

struct TutorialCard_Previews: PreviewProvider {
    static var previews: some View {
        TutorialCard("This is a tutorial")
    }
}
