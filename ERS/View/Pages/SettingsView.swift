//
//  SettingsView.swift
//  ERS
//
//  Created by Hersh Nagpal on 2/9/23.
//

import SwiftUI

struct SettingsView: View {
    @State var easyModeOn: Bool = UserDefaults.standard.bool(forKey: "easyModeOn")
    
        var body: some View {
        List {
            Toggle("Easy Mode", isOn: $easyModeOn)
                .onChange(of: easyModeOn) { value in
                    UserDefaults.standard.set(easyModeOn, forKey: "easyModeOn")
                }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
