//
//  RuleCardView.swift
//  ERS
//
//  Created by Hersh Nagpal on 3/25/23.
//

import SwiftUI

struct RuleCardView: View {
    let ruleName: LocalizedStringKey
    let ruleDescription: LocalizedStringKey
    @Binding var isOn: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Toggle(isOn: $isOn, label: {
                RuleTitleText(ruleName)
            })
            .toggleStyle(SwitchToggleStyle(tint: Colors.orange))
            RuleDescriptionText(ruleDescription)
        }
        .frame(maxWidth: .infinity)
        .padding(15)
        .foregroundColor(.black)
        .background(Colors.grey)
        .cornerRadius(15)
        .shadow(radius: 2, x: -2, y: 2)
    }
}

