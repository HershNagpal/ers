//
//  MultiplayerToggleView.swift
//  ERS
//
//  Created by Hersh Nagpal on 8/23/24.
//

import SwiftUI
import GameKit

struct MultiplayerToggleView: View {
    @EnvironmentObject var asm: AppStorageManager
    @Binding var showGameCenterAlert: Bool
    let backgroundColor: Color
    let foregroundColor: Color
    
    var body: some View {
        Button() {
            guard GKLocalPlayer.local.isAuthenticated else {
                showGameCenterAlert = true
                return
            }
            asm.online.toggle()
        } label: {
            Image(systemName: asm.online ? "wifi" : "person.2")
                .frame(width: 35, height: 35)
                .padding()
                .foregroundColor(foregroundColor)
                .background(backgroundColor)
                .font(.system(size: 30))
                .contentTransition(.symbolEffect(.replace, options: .speed(2)))
        }
        .cornerRadius(10)
    }
}
