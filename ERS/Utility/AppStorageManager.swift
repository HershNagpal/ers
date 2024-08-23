//
//  AppStorageManager.swift
//  ERS
//
//  Created by Hersh Nagpal on 7/11/24.
//

import Foundation
import SwiftUI

class AppStorageManager: ObservableObject {
    @AppStorage("purchasedRules") var purchasedRules: Bool = false
    @AppStorage("rulesWithAds") var rulesWithAds: Bool = false
    
    @AppStorage("easyDeal") var easyDeal: Bool = true
    @AppStorage("easyClaim") var easyClaim: Bool = true
    @AppStorage("confettiSlap") var confettiSlap: Bool = true
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
    
    var disableRuleToggles: Binding<Bool> { Binding (
        get: { [self] in !purchasedRules },
        set: { _ in }
        )
    }
}
