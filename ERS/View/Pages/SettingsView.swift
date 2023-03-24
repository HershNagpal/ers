//
//  SettingsView.swift
//  ERS
//
//  Created by Hersh Nagpal on 2/9/23.
//

import SwiftUI

struct SettingsView: View {
    let burnValues = [1,2,3,4,5]
    @State var easyDeal: Bool = UserDefaults.standard.bool(forKey: "easyDeal")
    @State var easyClaim: Bool = UserDefaults.standard.bool(forKey: "easyClaim")
    
    @State var doublesOn: Bool = UserDefaults.standard.bool(forKey: "doublesOn")
    @State var sandwichOn: Bool = UserDefaults.standard.bool(forKey: "sandwichOn")
    @State var couplesOn: Bool = UserDefaults.standard.bool(forKey: "couplesOn")
    @State var divorceOn: Bool = UserDefaults.standard.bool(forKey: "divorceOn")
    @State var queenOfDeathOn: Bool = UserDefaults.standard.bool(forKey: "queenOfDeathOn")
    
    @State var burnAmount: Int = UserDefaults.standard.integer(forKey: "burnAmount")
    
    var body: some View {
        List {
            Section("visuals") {
                Toggle("easy deal", isOn: $easyDeal)
                    .onChange(of: easyDeal) { value in
                        UserDefaults.standard.set(easyDeal, forKey: "easyDeal")
                    }
                Toggle("easy claim", isOn: $easyClaim)
                    .onChange(of: easyClaim) { value in
                        UserDefaults.standard.set(easyClaim, forKey: "easyClaim")
                    }
            }
            
            Section("slap rules") {
                Toggle("doubles", isOn: $doublesOn)
                    .onChange(of: doublesOn) { value in
                        UserDefaults.standard.set(doublesOn, forKey: "doublesOn")
                    }
                Toggle("sandwich", isOn: $sandwichOn)
                    .onChange(of: sandwichOn) { value in
                        UserDefaults.standard.set(sandwichOn, forKey: "sandwichOn")
                    }
                Toggle("couples", isOn: $couplesOn)
                    .onChange(of: couplesOn) { value in
                        UserDefaults.standard.set(couplesOn, forKey: "couplesOn")
                    }
                Toggle("divorce", isOn: $divorceOn)
                    .onChange(of: divorceOn) { value in
                        UserDefaults.standard.set(divorceOn, forKey: "divorceOn")
                    }
                Toggle("queen of death", isOn: $queenOfDeathOn)
                    .onChange(of: queenOfDeathOn) { value in
                        UserDefaults.standard.set(queenOfDeathOn, forKey: "queenOfDeathOn")
                    }
                Picker("burn amount", selection: $burnAmount) {
                    ForEach([1,2,3,5,10], id: \.self) { num in
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
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
