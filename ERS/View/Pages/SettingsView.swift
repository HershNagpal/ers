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
    
    let burnValues = [1,2,3,4,5,10]
    let difficulties = ["easy", "medium", "hard", "ouch"]
    
    @State var showRestoreAlert = false
    @State var showRestoreErrorAlert = false
    @State var freeSettingsDisabled = false

//    @State var rulesLocked: Bool = !UserDefaults.standard.bool(forKey: "hasUnlockedRules")
    @AppStorage("rulesLocked") var rulesLocked = true
    
    @State var easyDeal: Bool = UserDefaults.standard.bool(forKey: "easyDeal")
    @State var easyClaim: Bool = UserDefaults.standard.bool(forKey: "easyClaim")
    
    @State var doublesOn: Bool = UserDefaults.standard.bool(forKey: "doublesOn")
    @State var sandwichOn: Bool = UserDefaults.standard.bool(forKey: "sandwichOn")
    @State var couplesOn: Bool = UserDefaults.standard.bool(forKey: "couplesOn")
    @State var divorceOn: Bool = UserDefaults.standard.bool(forKey: "divorceOn")
    @State var queenOfDeathOn: Bool = UserDefaults.standard.bool(forKey: "queenOfDeathOn")
    @State var topAndBottomOn: Bool = UserDefaults.standard.bool(forKey: "topAndBottomOn")
    @State var addToTenOn: Bool = UserDefaults.standard.bool(forKey: "addToTenOn")
    @State var sequenceOn: Bool = UserDefaults.standard.bool(forKey: "sequenceOn")
    
    @State var difficulty: Int = UserDefaults.standard.integer(forKey: "difficulty")
    
    @State var burnAmount: Int = UserDefaults.standard.integer(forKey: "burnAmount")
    
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
                        UserDefaults.standard.set(easyDeal, forKey: "easyDeal")
                    }
                RuleToggleView(ruleName: "easy claim", ruleDescription: "easy claim description", isDisabled: $freeSettingsDisabled, isOn: $easyClaim)
                    .onChange(of: easyClaim) { value in
                        UserDefaults.standard.set(easyClaim, forKey: "easyClaim")
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
                    UserDefaults.standard.set(difficulty, forKey: "difficulty")
                }
                .frame(maxWidth: .infinity)
                .foregroundColor(.black)
            }
            
            Section(header: RuleSectionText("basic rules")) {
                RuleToggleView(ruleName: "doubles", ruleDescription: "doubles description", isDisabled: $freeSettingsDisabled, isOn: $doublesOn)
                    .onChange(of: doublesOn) { value in
                        UserDefaults.standard.set(doublesOn, forKey: "doublesOn")
                    }
                RuleToggleView(ruleName: "sandwich", ruleDescription: "sandwich description", isDisabled: $freeSettingsDisabled, isOn: $sandwichOn)
                    .onChange(of: sandwichOn) { value in
                        UserDefaults.standard.set(sandwichOn, forKey: "sandwichOn")
                    }
                RuleToggleView(ruleName: "couples", ruleDescription: "couples description", isDisabled: $freeSettingsDisabled, isOn: $couplesOn)
                    .onChange(of: couplesOn) { value in
                        UserDefaults.standard.set(couplesOn, forKey: "couplesOn")
                    }
            }
            
            Section(header: RuleSectionText("extra rules")) {
                RuleToggleView(ruleName: "divorce", ruleDescription: "divorce description", isDisabled: $rulesLocked, isOn: $divorceOn)
                    .onChange(of: divorceOn) { value in
                        UserDefaults.standard.set(divorceOn, forKey: "divorceOn")
                    }
                RuleToggleView(ruleName: "queen of death", ruleDescription: "queen of death description", isDisabled: $rulesLocked, isOn: $queenOfDeathOn)
                    .onChange(of: queenOfDeathOn) { value in
                        UserDefaults.standard.set(queenOfDeathOn, forKey: "queenOfDeathOn")
                    }
                RuleToggleView(ruleName: "top and bottom", ruleDescription: "top and bottom description", isDisabled: $rulesLocked, isOn: $topAndBottomOn)
                    .onChange(of: topAndBottomOn) { value in
                        UserDefaults.standard.set(topAndBottomOn, forKey: "topAndBottomOn")
                    }
                RuleToggleView(ruleName: "add to ten", ruleDescription: "add to ten description", isDisabled: $rulesLocked, isOn: $addToTenOn)
                    .onChange(of: addToTenOn) { value in
                        UserDefaults.standard.set(addToTenOn, forKey: "addToTenOn")
                    }
                RuleToggleView(ruleName: "sequence", ruleDescription: "sequence description", isDisabled: $rulesLocked, isOn: $sequenceOn)
                    .onChange(of: sequenceOn) { value in
                        UserDefaults.standard.set(sequenceOn, forKey: "sequenceOn")
                    }
                VStack(alignment: .leading) {
                    Picker(selection: $burnAmount, label: RuleTitleText("burn amount")) {
                        ForEach(burnValues, id: \.self) { option in
                            RuleDescriptionText("\(option)")
                        }
                        .pickerStyle(.menu)
                        .disabled(rulesLocked)
                    }
                    RuleDescriptionText("burn amount description")
                }
                .onChange(of: burnAmount) { value in
                    UserDefaults.standard.set(burnAmount, forKey: "burnAmount")
                }
                .disabled(rulesLocked)
                .frame(maxWidth: .infinity)
                .foregroundColor(.black)
            }
            if (rulesLocked) {
                Section(header: RuleSectionText("purchases")) {
                    ForEach(purchaseManager.products) { (product) in
                        SettingsButton(text: LocalizedStringKey(product.id), onPress: {Task {
                            do {
                                try await purchaseManager.purchase(product)
                            } catch {
                                print(error)
                            }
                        }})
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
