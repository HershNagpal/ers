//
//  LocalGameView.swift
//  ERS
//
//  Created by Hersh Nagpal on 8/23/24.
//

import SwiftUI

@MainActor
class LocalGameViewModel: ObservableObject {
    @Published var game = Game()
}

struct LocalGameView: View {
    @ObservedObject var vm = LocalGameViewModel()
    
    @Binding var path: [String]
    let isSingleplayer: Bool
    
    var body: some View {
        GameView(path: $path, game: vm.game, localPlayer: .one, isSingleplayer: isSingleplayer, sendAction: nil)
    }
}

#Preview {
    LocalGameView(path: .constant([]), isSingleplayer: true)
}
