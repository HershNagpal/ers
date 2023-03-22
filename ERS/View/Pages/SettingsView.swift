//
//  SettingsView.swift
//  ERS
//
//  Created by Hersh Nagpal on 2/9/23.
//

import SwiftUI

struct SettingsView: View {
    var back: () -> Void
    
    var body: some View {
        VStack() {
            LargeText("Settings")
            MediumText("Wow look at all these settings")
            BackButton(onPress: back)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(back: {})
    }
}
