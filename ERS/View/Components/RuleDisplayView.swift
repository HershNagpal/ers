//
//  RuleDisplayView.swift
//  ERS
//
//  Created by Hersh Nagpal on 8/24/24.
//

import SwiftUI

struct RuleDisplayView: View {
    let localPlayer: PlayerNumber
    let rulesPlayer: PlayerNumber?
    let dismiss: (() -> Void)?
    let ruleState: RuleState
    
    var body: some View {
        VStack(spacing: 8) {
            MediumText("You are player \(localPlayer.rawValue)")
            if let rulesPlayer = rulesPlayer {
                MediumText("Selected player \(rulesPlayer.rawValue)'s rules")
            }
            if ruleState.doublesOn {
                MediumText("doubles")
            }
            if ruleState.sandwichOn {
                MediumText("sandwich")
            }
            if ruleState.couplesOn {
                MediumText("couples")
            }
            if ruleState.divorceOn {
                MediumText("divorce")
            }
            if ruleState.queenOfDeathOn {
                MediumText("queen of death")
            }
            if ruleState.topAndBottomOn {
                MediumText("top and bototm")
            }
            if ruleState.addToTenOn {
                MediumText("add to ten")
            }
            if ruleState.sequenceOn {
                MediumText("sequence")
            }
            MediumText("Burn Amount: \(ruleState.burnAmount)")
        }
    }
}

#Preview {
    RuleDisplayView(localPlayer: .one, rulesPlayer: .two, dismiss: {}, ruleState: RuleState(doublesOn: true, sandwichOn: true, couplesOn: true, divorceOn: true, queenOfDeathOn: false, topAndBottomOn: false, addToTenOn: false, sequenceOn: false, burnAmount: 2))
}
