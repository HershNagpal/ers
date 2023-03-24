//
//  TutorialView.swift
//  ERS
//
//  Created by Hersh Nagpal on 3/24/23.
//

import SwiftUI

struct TutorialView: View {
    @Binding var path: [String]
    @StateObject var game: Game = Game()
    @State var isPaused: Bool = false
    @State var tutorialCardText: String = TutorialCard.tutorialStrings[0]
    @State var isTutorialPopupOpen: Bool = true
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                PlayerInteractionView(isPaused: $isPaused, game: game, player: .two)
                    .rotationEffect(Angle(degrees: 180))
                    .ignoresSafeArea()
                StackInfoView(stack: $game.stack, burnPile: $game.burnPile, deck: $game.deck2)
                    .rotationEffect(Angle(degrees: 180))
                    .padding(.top, 10)
                CardStackView(stack: $game.stack)
                    .frame(maxWidth: .infinity, minHeight: 300, alignment: .center)
                StackInfoView(stack: $game.stack, burnPile: $game.burnPile, deck: $game.deck1)
                    .padding(.bottom, 10)
                PlayerInteractionView(isPaused: $isPaused, game: game, player: .one)
                    .ignoresSafeArea()
            }
                .background(Colors.grey)
            if game.winner != .none {
                GameEndView(path: $path, winner: $game.winner)
            }
            if isPaused {
                PauseView(isPaused: $isPaused, path: $path, resetGame: {
                    game.restart()
                    isPaused = false
                })
            }
            if isTutorialPopupOpen {
                
            }
            
        }
        .onAppear {
            game.deck1 = Deck([
                Card(value: .three, suit: .clubs),
                Card(value: .two, suit: .hearts),
                Card(value: .three, suit: .hearts),
                Card(value: .two, suit: .diamonds),
                Card(value: .eight, suit: .hearts),
            ])
            game.deck2 = Deck([
                Card(value: .five, suit: .spades),
                Card(value: .seven, suit: .spades),
                Card(value: .ten, suit: .diamonds),
                Card(value: .two, suit: .spades),
                Card(value: .ten, suit: .spades),
            ])
        }
    }
    

}
