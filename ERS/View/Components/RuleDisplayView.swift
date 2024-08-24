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
    
    var body: some View {
        VStack(spacing: 8) {
            MediumText("You are player \(localPlayer.rawValue)")
            MediumText("Selected player \(rulesPlayer.rawValue)'s rules")
            if asm.doublesOn {
                MediumText("Doubles")
            }
            if asm.sandwichOn {
                MediumText("Sandwich")
            }
            if asm.couplesOn {
                MediumText("Couples")
            }
            if asm.divorceOn {
                MediumText("Divorce")
            }
            if asm.queenOfDeathOn {
                MediumText("Queen of Death")
            }
            if asm.topAndBottomOn {
                MediumText("Top and Bottom")
            }
            if asm.addToTenOn {
                MediumText("Add to Ten")
            }
            if asm.sequenceOn {
                MediumText("Sequence")
            }
        }
    }
}

#Preview {
    RuleDisplayView(localPlayer: .one, rulesPlayer: .two, dismiss: {})
}
