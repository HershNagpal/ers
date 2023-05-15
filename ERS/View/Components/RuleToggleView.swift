//
//  RuleCardView.swift
//  ERS
//
//  Created by Hersh Nagpal on 3/25/23.
//

import SwiftUI

struct RuleToggleView: View {
    let ruleName: LocalizedStringKey
    let ruleDescription: LocalizedStringKey
    var isDisabled: Bool?
    @Binding var isOn: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Toggle(isOn: $isOn, label: {
                RuleTitleText(ruleName)
            })
            .toggleStyle(SwitchToggleStyle(tint: Colors.orange))
            .disabled(isDisabled ?? false)
            RuleDescriptionText(ruleDescription)
        }
        .frame(maxWidth: .infinity)
        .foregroundColor(.black)
    }
}

