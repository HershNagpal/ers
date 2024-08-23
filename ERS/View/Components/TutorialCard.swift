//
//  TutorialCard.swift
//  ERS
//
//  Created by Hersh Nagpal on 3/24/23.
//

import SwiftUI

struct TutorialCard: View {
    @Binding var tutorialNumber: Int

    var body: some View {
        VStack {
            TutorialText(LocalizedStringKey("t"+String(tutorialNumber)))
        }
        .padding(15)
        .frame(maxWidth: .infinity)
        .background(Colors.ersDarkGrey)
        .cornerRadius(15)
    }
}

