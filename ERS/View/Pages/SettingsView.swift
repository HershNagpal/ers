//
//  SettingsView.swift
//  ERS
//
//  Created by Hersh Nagpal on 2/9/23.
//

import SwiftUI
import StoreKit

struct SettingsView: View {
    @EnvironmentObject private var purchaseManager: PurchaseManager
    
    private var disableRuleToggles: Binding<Bool> { Binding (
        get: { !purchasedRules && !rulesWithAds},
        set: { _ in }
        )
    }
    
    let burnValues = [1,2,3,4,5,10]
    let difficulties = ["easy", "medium", "hard", "ouch"]
    
    @State var showRestoreAlert = false
    @State var showRestoreErrorAlert = false
    @State var freeSettingsDisabled = false

    @AppStorage("purchasedRules") var purchasedRules: Bool = false
    @AppStorage("rulesWithAds") var rulesWithAds: Bool = false
    
    @AppStorage("easyDeal") var easyDeal: Bool = true
    @AppStorage("easyClaim") var easyClaim: Bool = true
    
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
    
    func restorePurchases() {
        Task {
            do {
                try await AppStore.sync()
                showRestoreAlert = true
            } catch {
                showRestoreErrorAlert = true
                print(error)
            }
        }
    }
    
    var body: some View {
        List() {
            Section(header: RuleSectionText("visuals")) {
                RuleToggleView(ruleName: "easy deal", ruleDescription: "easy deal description", isDisabled: $freeSettingsDisabled, isOn: $easyDeal)
                    .onChange(of: easyDeal) { value in
                        easyDeal = value
                    }
                RuleToggleView(ruleName: "easy claim", ruleDescription: "easy claim description", isDisabled: $freeSettingsDisabled, isOn: $easyClaim)
                    .onChange(of: easyClaim) { value in
                        easyClaim = value
                    }
            }
            
            Section(header: RuleSectionText("singleplayer")) {
                VStack(alignment: .leading) {
                    Picker(selection: $difficulty, label: RuleTitleText("difficulty")) {
                        ForEach(0...3, id: \.self) { index in
                            Text(LocalizedStringKey(String(difficulties[index])))
                        }
                        .pickerStyle(.menu)
                    }
                    RuleDescriptionText("difficulty description")
                }
                .onChange(of: difficulty) { value in
                    difficulty = value
                }
                .frame(maxWidth: .infinity)
                .foregroundColor(.black)
            }
            
            Section(header: RuleSectionText("basic rules")) {
                RuleToggleView(ruleName: "doubles", ruleDescription: "doubles description", isDisabled: $freeSettingsDisabled, isOn: $doublesOn)
                    .onChange(of: doublesOn) { value in
                        doublesOn = value
                    }
                RuleToggleView(ruleName: "sandwich", ruleDescription: "sandwich description", isDisabled: $freeSettingsDisabled, isOn: $sandwichOn)
                    .onChange(of: sandwichOn) { value in
                        sandwichOn = value
                    }
                RuleToggleView(ruleName: "couples", ruleDescription: "couples description", isDisabled: $freeSettingsDisabled, isOn: $couplesOn)
                    .onChange(of: couplesOn) { value in
                        couplesOn = value
                    }
            }
            
            Section(header: RuleSectionText("extra rules")) {
                if (!purchasedRules) {
                    RuleToggleView(ruleName: "rules with ads switch", ruleDescription: "rules with ads description", isDisabled: $freeSettingsDisabled, isOn: $rulesWithAds)
                        .onChange(of: rulesWithAds) { value in
                            rulesWithAds = value
                            if rulesWithAds == false {
                                divorceOn = false
                                queenOfDeathOn = false
                                topAndBottomOn = false
                                addToTenOn = false
                                sequenceOn = false
                                burnAmount = 1
                            }
                        }
                }
                RuleToggleView(ruleName: "divorce", ruleDescription: "divorce description", isDisabled: disableRuleToggles, isOn: $divorceOn)
                    .onChange(of: divorceOn) { value in
                        divorceOn = value
                    }
                RuleToggleView(ruleName: "queen of death", ruleDescription: "queen of death description", isDisabled: disableRuleToggles, isOn: $queenOfDeathOn)
                    .onChange(of: queenOfDeathOn) { value in
                        queenOfDeathOn = value
                    }
                RuleToggleView(ruleName: "top and bottom", ruleDescription: "top and bottom description", isDisabled: disableRuleToggles, isOn: $topAndBottomOn)
                    .onChange(of: topAndBottomOn) { value in
                        topAndBottomOn = value
                    }
                RuleToggleView(ruleName: "add to ten", ruleDescription: "add to ten description", isDisabled: disableRuleToggles, isOn: $addToTenOn)
                    .onChange(of: addToTenOn) { value in
                        addToTenOn = value
                    }
                RuleToggleView(ruleName: "sequence", ruleDescription: "sequence description", isDisabled: disableRuleToggles, isOn: $sequenceOn)
                    .onChange(of: sequenceOn) { value in
                        sequenceOn = value
                    }
                VStack(alignment: .leading) {
                    Picker(selection: $burnAmount, label: RuleTitleText("burn amount")) {
                        ForEach(burnValues, id: \.self) { option in
                            RuleDescriptionText("\(option)")
                        }
                        .pickerStyle(.menu)
                        .disabled(!purchasedRules)
                    }
                    RuleDescriptionText("burn amount description")
                }
                .onChange(of: burnAmount) { value in
                    burnAmount = value
                }
                .disabled(!purchasedRules)
                .frame(maxWidth: .infinity)
                .foregroundColor(.black)
            }
            if (!purchasedRules) {
                Section(header: RuleSectionText("purchases")) {
                    ForEach(purchaseManager.products) { (product) in
                        SettingsButton(text: LocalizedStringKey(product.id), onPress: {
                            Task {
                                do {
                                    try await purchaseManager.purchase(product)
                                } catch {
                                    print(error)
                                }
                            }
                        })
                    }
                    SettingsButton(text: "restore purchases", onPress: {restorePurchases()})
                        .alert("purchases restored", isPresented: $showRestoreAlert) {
                            Button("OK", role: .cancel) { }
                        }
                        .alert("error restoring purchases", isPresented: $showRestoreErrorAlert) {
                            Button("OK", role: .cancel) { }
                        }
                }
            }
        }
        .task {
            do {
                try await purchaseManager.loadProducts()
                await purchaseManager.updatePurchasedProducts()
            } catch {
                print(error)
            }
        }
        .scrollContentBackground(.hidden)
        .background(Colors.yellow)
    }
}
