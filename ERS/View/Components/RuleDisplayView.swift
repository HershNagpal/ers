//
//  RuleDisplayView.swift
//  ERS
//
//  Created by Hersh Nagpal on 8/24/24.
//

import SwiftUI

struct RuleDisplayView: View {
    @EnvironmentObject var asm: AppStorageManager
    let localPlayer: PlayerNumber
    let rulesPlayer: PlayerNumber
    let dismiss: () -> Void
    let ruleState: RuleState
    
    var body: some View {
        VStack(spacing: 8) {
            MediumText("You are player \(localPlayer.rawValue)")
            MediumText("Selected player \(rulesPlayer.rawValue)'s rules")
            if ruleState.doublesOn {
                MediumText("Doubles")
            }
            if ruleState.sandwichOn {
                MediumText("Sandwich")
            }
            if ruleState.couplesOn {
                MediumText("Couples")
            }
            if ruleState.divorceOn {
                MediumText("Divorce")
            }
            if ruleState.queenOfDeathOn {
                MediumText("Queen of Death")
            }
            if ruleState.topAndBottomOn {
                MediumText("Top and Bottom")
            }
            if ruleState.addToTenOn {
                MediumText("Add to Ten")
            }
            if ruleState.sequenceOn {
                MediumText("Sequence")
            }
            MediumText("Burn Amount: \(ruleState.burnAmount)")
        }
    }
}

#Preview {
    RuleDisplayView(localPlayer: .one, rulesPlayer: .two, dismiss: {}, ruleState: RuleState(doublesOn: true, sandwichOn: true, couplesOn: true, divorceOn: true, queenOfDeathOn: false, topAndBottomOn: false, addToTenOn: false, sequenceOn: false, burnAmount: 2))
}
