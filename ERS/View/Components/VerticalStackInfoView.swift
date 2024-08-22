//
//  VerticalStackInfoView.swift
//  ERS
//
//  Created by Hersh Nagpal on 8/22/24.
//

import Foundation
import SwiftUI

struct VerticalStackInfoView: View {
    @Binding var stack: [Card]
    @Binding var burnPile: [Card]
    @Binding var deck: Deck
    @State var burnScale: Bool = false
    @State var deckScale: Bool = false
    @State var lastDeckCount: Int
    
    var body: some View {
        EmptyView()
    }
}
