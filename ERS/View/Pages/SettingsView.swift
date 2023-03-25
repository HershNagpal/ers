//
//  SettingsView.swift
//  ERS
//
//  Created by Hersh Nagpal on 2/9/23.
//

import SwiftUI

struct SettingsView: View {
    let burnValues = [1,2,3,4,5,10]
    let difficulties = ["easy", "medium", "hard", "ouch"]
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
    
    var body: some View {
        List {
            Section("visuals") {
                RuleCardView(ruleName: "easy deal", ruleDescription: "easy deal description", isOn: $easyDeal)
                    .onChange(of: easyDeal) { value in
                        UserDefaults.standard.set(easyDeal, forKey: "easyDeal")
                    }
                RuleCardView(ruleName: "easy claim", ruleDescription: "easy claim description", isOn: $easyClaim)
                    .onChange(of: easyClaim) { value in
                        UserDefaults.standard.set(easyClaim, forKey: "easyClaim")
                    }
            }
            
            Section("practice mode") {
                Picker("difficulty", selection: $difficulty) {
                    ForEach(0...3, id: \.self) { index in
                        Text(LocalizedStringKey(String(difficulties[index])))
                    }
                    .pickerStyle(.menu)
                    .onChange(of: difficulty) { value in
                        UserDefaults.standard.set(difficulty, forKey: "difficulty")
                    }
                }
            }
            
            Section("slap rules") {
                RuleCardView(ruleName: "doubles", ruleDescription: "doubles description", isOn: $doublesOn)
                    .onChange(of: doublesOn) { value in
                        UserDefaults.standard.set(doublesOn, forKey: "doublesOn")
                    }
                RuleCardView(ruleName: "sandwich", ruleDescription: "sandwich description", isOn: $sandwichOn)
                    .onChange(of: sandwichOn) { value in
                        UserDefaults.standard.set(sandwichOn, forKey: "sandwichOn")
                    }
                RuleCardView(ruleName: "couples", ruleDescription: "couples description", isOn: $couplesOn)
                    .onChange(of: couplesOn) { value in
                        UserDefaults.standard.set(couplesOn, forKey: "couplesOn")
                    }
                RuleCardView(ruleName: "divorce", ruleDescription: "divorce description", isOn: $divorceOn)
                    .onChange(of: divorceOn) { value in
                        UserDefaults.standard.set(divorceOn, forKey: "divorceOn")
                    }
                RuleCardView(ruleName: "queen of death", ruleDescription: "queen of death description", isOn: $queenOfDeathOn)
                    .onChange(of: queenOfDeathOn) { value in
                        UserDefaults.standard.set(queenOfDeathOn, forKey: "queenOfDeathOn")
                    }
                RuleCardView(ruleName: "top and bottom", ruleDescription: "top and bottom description", isOn: $topAndBottomOn)
                    .onChange(of: topAndBottomOn) { value in
                        UserDefaults.standard.set(topAndBottomOn, forKey: "topAndBottomOn")
                    }
                RuleCardView(ruleName: "add to ten", ruleDescription: "add to ten description", isOn: $addToTenOn)
                    .onChange(of: addToTenOn) { value in
                        UserDefaults.standard.set(addToTenOn, forKey: "addToTenOn")
                    }
                RuleCardView(ruleName: "sequence", ruleDescription: "sequence description", isOn: $sequenceOn)
                    .onChange(of: sequenceOn) { value in
                        UserDefaults.standard.set(sequenceOn, forKey: "sequenceOn")
                    }
            }
            Picker("burn amount", selection: $burnAmount) {
                ForEach(burnValues, id: \.self) { num in
                    Text("\(num)")
                }
                .pickerStyle(.menu)
                .onChange(of: burnAmount) { value in
                    UserDefaults.standard.set(burnAmount, forKey: "burnAmount")
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
