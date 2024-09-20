//
//  LocalGameView.swift
//  ERS
//
//  Created by Hersh Nagpal on 8/23/24.
//

import SwiftUI

@MainActor
final class LocalGameViewModel: ObservableObject {
    @Published var game: Game
    
    init(ruleState: RuleState) {
        self.game = Game(ruleState: ruleState)
    }
}

struct LocalGameView: View {
    @EnvironmentObject var asm: AppStorageManager
    @ObservedObject var vm: LocalGameViewModel
    let navigateHome: () -> Void
    let isSingleplayer: Bool
    
    var body: some View {
        GameView(game: vm.game, localPlayer: .one, isSingleplayer: isSingleplayer, sendAction: nil, navigateHome: navigateHome)
    }
}
