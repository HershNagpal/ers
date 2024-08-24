//
//  AppStorageManager.swift
//  ERS
//
//  Created by Hersh Nagpal on 7/11/24.
//

import Foundation
import SwiftUI

final class AppStorageManager: ObservableObject {
    @AppStorage("purchasedRules") var purchasedRules: Bool = false
    @AppStorage("rulesWithAds") var rulesWithAds: Bool = false
    
    @AppStorage("easyDeal") var easyDeal: Bool = true
    @AppStorage("easyClaim") var easyClaim: Bool = true
    @AppStorage("confettiSlap") var confettiSlap: Bool = true
    @AppStorage("hapticFeedback") var hapticFeedback: Bool = true
    @AppStorage("flatStack") var flatStack: Bool = false
    
    @AppStorage("doublesOn") var doublesOn: Bool = true
    @AppStorage("sandwichOn") var sandwichOn: Bool = true
    @AppStorage("couplesOn") var couplesOn: Bool = true
    @AppStorage("divorceOn") var divorceOn: Bool = false
    @AppStorage("queenOfDeathOn") var queenOfDeathOn: Bool = false
    @AppStorage("topAndBottomOn") var topAndBottomOn: Bool = false
    @AppStorage("addToTenOn") var addToTenOn: Bool = false
    @AppStorage("sequenceOn") var sequenceOn: Bool = false
    
    @AppStorage("difficulty") var difficulty: Int = 1
    @AppStorage("burnAmount") var burnAmount: Int = 1
    
    @AppStorage("online") var online: Bool = false
    
    func saveRuleState() -> RuleState {
        RuleState(doublesOn: doublesOn, sandwichOn: sandwichOn, couplesOn: couplesOn, divorceOn: divorceOn, queenOfDeathOn: queenOfDeathOn, topAndBottomOn: topAndBottomOn, addToTenOn: addToTenOn, sequenceOn: sequenceOn, burnAmount: burnAmount)
    }
    
    func apply(state: RuleState) -> Void {
        doublesOn = state.doublesOn
        sandwichOn = state.sandwichOn
        couplesOn = state.couplesOn
        divorceOn = state.divorceOn
        queenOfDeathOn = state.queenOfDeathOn
        topAndBottomOn = state.topAndBottomOn
        addToTenOn = state.addToTenOn
        sequenceOn = state.sequenceOn
        burnAmount = state.burnAmount
    }
    
    func reset() {
        doublesOn = true
        sandwichOn = true
        couplesOn = true
        divorceOn = false
        queenOfDeathOn = false
        topAndBottomOn = false
        addToTenOn = false
        sequenceOn = false
        burnAmount = 1
    }
    
    func turnOffExtraRules() {
        divorceOn = false
        queenOfDeathOn = false
        topAndBottomOn = false
        addToTenOn = false
        sequenceOn = false
        burnAmount = 1
    }
    
    var disableRuleToggles: Binding<Bool> { Binding (
        get: { [self] in !purchasedRules },
        set: { _ in }
        )
    }
}
