//
//  SettingsView.swift
//  ERS
//
//  Created by Hersh Nagpal on 2/9/23.
//

import SwiftUI

struct SettingsView: View {
    let burnValues = [1,2,3,4,5]
    @State var easyModeOn: Bool = UserDefaults.standard.bool(forKey: "easyModeOn")
    @State var doublesOn: Bool = UserDefaults.standard.bool(forKey: "doublesOn")
    @State var sandwichOn: Bool = UserDefaults.standard.bool(forKey: "sandwichOn")
    @State var couplesOn: Bool = UserDefaults.standard.bool(forKey: "couplesOn")
    @State var divorceOn: Bool = UserDefaults.standard.bool(forKey: "divorceOn")
    @State var queenOfDeathOn: Bool = UserDefaults.standard.bool(forKey: "queenOfDeathOn")
    
    @State var burnAmount: Int = UserDefaults.standard.integer(forKey: "burnAmount")
    
    var body: some View {
        List {
            Section("Visuals") {
                Toggle("Easy Mode", isOn: $easyModeOn)
                    .onChange(of: easyModeOn) { value in
                        UserDefaults.standard.set(easyModeOn, forKey: "easyModeOn")
                    }
            }
            Section("Slap Rules") {
                Toggle("Doubles", isOn: $doublesOn)
                    .onChange(of: doublesOn) { value in
                        UserDefaults.standard.set(doublesOn, forKey: "doublesOn")
                    }
                Toggle("Sandwich", isOn: $sandwichOn)
                    .onChange(of: sandwichOn) { value in
                        UserDefaults.standard.set(sandwichOn, forKey: "sandwichOn")
                    }
                Toggle("Couples", isOn: $couplesOn)
                    .onChange(of: couplesOn) { value in
                        UserDefaults.standard.set(couplesOn, forKey: "couplesOn")
                    }
                Toggle("Divorce", isOn: $divorceOn)
                    .onChange(of: divorceOn) { value in
                        UserDefaults.standard.set(divorceOn, forKey: "divorceOn")
                    }
                Toggle("Queen of Death", isOn: $queenOfDeathOn)
                    .onChange(of: queenOfDeathOn) { value in
                        UserDefaults.standard.set(queenOfDeathOn, forKey: "queenOfDeathOn")
                    }
                Picker("Burn Amount on Misslap", selection: $burnAmount) {
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
