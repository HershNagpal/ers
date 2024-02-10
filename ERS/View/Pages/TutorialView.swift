//
//  TutorialView.swift
//  ERS
//
//  Created by Hersh Nagpal on 3/24/23.
//

import SwiftUI

struct TutorialView: View {
    @Binding var path: [String]
    @State var tutorialNumber: Int = 1
    @State var tutorialStack1: [Card] = [Card(value: .two, suit: .hearts)]
    @State var tutorialStack2: [Card] = [Card(value: .eight, suit: .spades), Card(value: .two, suit: .hearts)]
    @State var tutorialStackDoubles: [Card] = [Card(value: .two, suit: .hearts), Card(value: .two, suit: .spades), Card(value: .eight, suit: .diamonds)]
    @State var tutorialStackSandwich: [Card] = [Card(value: .ten, suit: .spades), Card(value: .three, suit: .diamonds), Card(value: .ten, suit: .clubs)]
    @State var tutorialStackCouples: [Card] = [Card(value: .king, suit: .clubs), Card(value: .queen, suit: .diamonds), Card(value: .ace, suit: .clubs)]
    @State var tutorialStackAce: [Card] = [Card(value: .ace, suit: .diamonds), Card(value: .three, suit: .spades), Card(value: .two, suit: .diamonds)]
    @State var tutorialStackFace: [Card] = [Card(value: .jack, suit: .hearts), Card(value: .queen, suit: .hearts), Card(value: .king, suit: .clubs)]
    @State var tutorialStackJack: [Card] = [Card(value: .four, suit: .hearts), Card(value: .jack, suit: .hearts), Card(value: .four, suit: .clubs)]
    
    var body: some View {
        VStack() {
            TutorialCard(tutorialNumber: $tutorialNumber)
            if(tutorialNumber == 2) {
                Spacer()
                Image("deck")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 200, maxHeight: 200)
                    .background(Colors.ersGreen)
                    .cornerRadius(15)
                Spacer()
            }
            else if(tutorialNumber == 3) {
                Spacer()
                CardStackView(stack: $tutorialStack1)
                    .padding(.top, 15)
                Spacer()
            }
            
            else if(tutorialNumber == 4) {
                Spacer()
                CardStackView(stack: $tutorialStack2)
                    .padding(.top, 15)
                Spacer()
            }
            
            else if(tutorialNumber == 5) {
                Spacer()
                Image("hand")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 200, maxHeight: 200)
                    .background(Colors.ersRed)
                    .cornerRadius(15)
                Spacer()
            }
            
            else if(tutorialNumber == 6) {
                Spacer()
                CardStackView(stack: $tutorialStackDoubles)
                    .padding(.top, 15)
                Spacer()
            }
            
            else if(tutorialNumber == 7) {
                Spacer()
                CardStackView(stack: $tutorialStackSandwich)
                    .padding(.top, 15)
                Spacer()
            }
            
            else if(tutorialNumber == 8) {
                Spacer()
                CardStackView(stack: $tutorialStackCouples)
                    .padding(.top, 15)
                Spacer()
            }
            else if(tutorialNumber == 9) {
                Spacer()
                CardStackView(stack: $tutorialStackAce)
                    .padding(.top, 15)
                Spacer()
            }
            else if(tutorialNumber == 10) {
                Spacer()
                CardStackView(stack: $tutorialStackFace)
                    .padding(.top, 15)
                Spacer()
            }
            else if(tutorialNumber == 11) {
                Spacer()
                CardStackView(stack: $tutorialStackFace)
                    .padding(.top, 15)
                Spacer()
            }
            else if(tutorialNumber == 12) {
                Spacer()
                CardStackView(stack: $tutorialStackJack)
                    .padding(.top, 15)
                Spacer()
            }
            else if(tutorialNumber == 13) {
                Spacer()
                Image("burn")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 200, maxHeight: 200)
                    .background(Colors.ersGrey)
                    .cornerRadius(15)
                Spacer()
            }
            else if(tutorialNumber == 14) {
                Spacer()
                Image("stack")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 200, maxHeight: 200)
                    .background(Colors.ersGrey)
                    .cornerRadius(15)
                Spacer()
            }
            
            Spacer()
            
            tutorialNumber >= 15
                ? NavigationButton(text: "back to menu", onPress: {path.removeAll()})
                : NavigationButton(text: "next", onPress: {withAnimation {tutorialNumber += 1}})
        }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(10)
            .background(Colors.ersOrange)
    }

}
