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
    @EnvironmentObject var asm: AppStorageManager
    
    let burnValues = [1,2,3,4,5,10]
    let difficulties = ["easy", "medium", "hard", "ouch"]
    
    @State var showRestoreAlert = false
    @State var showRestoreErrorAlert = false
    @State var freeSettingsDisabled = false
    
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
                RuleToggleView(ruleName: "easy deal", ruleDescription: "easy deal description", isDisabled: $freeSettingsDisabled, isOn: $asm.easyDeal)
                    .onChange(of: asm.easyDeal) { value in
                        asm.easyDeal = value
                    }
                RuleToggleView(ruleName: "easy claim", ruleDescription: "easy claim description", isDisabled: $freeSettingsDisabled, isOn: $asm.easyClaim)
                    .onChange(of: asm.easyClaim) { value in
                        asm.easyClaim = value
                    }
                RuleToggleView(ruleName: "confetti slap", ruleDescription: "confetti slap description", isDisabled: $freeSettingsDisabled, isOn: $asm.confettiSlap)
                    .onChange(of: asm.confettiSlap) { value in
                        asm.confettiSlap = value
                    }
            }
            
            Section(header: RuleSectionText("singleplayer")) {
                VStack(alignment: .leading) {
                    Picker(selection: $asm.difficulty, label: RuleTitleText("difficulty")) {
                        ForEach(0...3, id: \.self) { index in
                            Text(LocalizedStringKey(String(difficulties[index])))
                        }
                        .pickerStyle(.menu)
                    }
                    RuleDescriptionText("difficulty description")
                }
                .onChange(of: asm.difficulty) { value in
                    asm.difficulty = value
                }
                .frame(maxWidth: .infinity)
                .foregroundColor(.black)
            }
            
            Section(header: RuleSectionText("basic rules")) {
                RuleToggleView(ruleName: "doubles", ruleDescription: "doubles description", isDisabled: $freeSettingsDisabled, isOn: $asm.doublesOn)
                    .onChange(of: asm.doublesOn) { value in
                        asm.doublesOn = value
                    }
                RuleToggleView(ruleName: "sandwich", ruleDescription: "sandwich description", isDisabled: $freeSettingsDisabled, isOn: $asm.sandwichOn)
                    .onChange(of: asm.sandwichOn) { value in
                        asm.sandwichOn = value
                    }
                RuleToggleView(ruleName: "couples", ruleDescription: "couples description", isDisabled: $freeSettingsDisabled, isOn: $asm.couplesOn)
                    .onChange(of: asm.couplesOn) { value in
                        asm.couplesOn = value
                    }
            }
            
            Section(header: RuleSectionText("extra rules")) {
//                if (purchasedRules) {
//                    RuleToggleView(ruleName: "rules with ads switch", ruleDescription: "add to ten description", isDisabled: $freeSettingsDisabled, isOn: $rulesUnlockedWithAds)
//                        .onChange(of: addToTenOn) { value in
//                            UserDefaults.standard.set(addToTenOn, forKey: "addToTenOn")
//                        }
//                }
                RuleToggleView(ruleName: "divorce", ruleDescription: "divorce description", isDisabled: asm.disableRuleToggles, isOn: $asm.divorceOn)
                    .onChange(of: asm.divorceOn) { value in
                        asm.divorceOn = value
                    }
                RuleToggleView(ruleName: "queen of death", ruleDescription: "queen of death description", isDisabled: asm.disableRuleToggles, isOn: $asm.queenOfDeathOn)
                    .onChange(of: asm.queenOfDeathOn) { value in
                        asm.queenOfDeathOn = value
                    }
                RuleToggleView(ruleName: "top and bottom", ruleDescription: "top and bottom description", isDisabled: asm.disableRuleToggles, isOn: $asm.topAndBottomOn)
                    .onChange(of: asm.topAndBottomOn) { value in
                        asm.topAndBottomOn = value
                    }
                RuleToggleView(ruleName: "add to ten", ruleDescription: "add to ten description", isDisabled: asm.disableRuleToggles, isOn: $asm.addToTenOn)
                    .onChange(of: asm.addToTenOn) { value in
                        asm.addToTenOn = value
                    }
                RuleToggleView(ruleName: "sequence", ruleDescription: "sequence description", isDisabled: asm.disableRuleToggles, isOn: $asm.sequenceOn)
                    .onChange(of: asm.sequenceOn) { value in
                        asm.sequenceOn = value
                    }
                VStack(alignment: .leading) {
                    Picker(selection: $asm.burnAmount, label: RuleTitleText("burn amount")) {
                        ForEach(burnValues, id: \.self) { option in
                            RuleDescriptionText("\(option)")
                        }
                        .pickerStyle(.menu)
                        .disabled(!asm.purchasedRules)
                    }
                    RuleDescriptionText("burn amount description")
                }
                .onChange(of: asm.burnAmount) { value in
                    asm.burnAmount = value
                }
                .disabled(!asm.purchasedRules)
                .frame(maxWidth: .infinity)
                .foregroundColor(.black)
            }
            if (!asm.purchasedRules) {
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
        .background(LinearGradient(gradient: Gradient(colors: [.ersYellow, .ersOrange]), startPoint: .top, endPoint: .bottom))
    }
}
