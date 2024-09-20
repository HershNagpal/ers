//
//  NavigationManager.swift
//  ERS
//
//  Created by Hersh Nagpal on 9/19/24.
//

import Foundation
import SwiftUI

@MainActor
class NavigationManager: ObservableObject {
    @Published var path: [String]
    
    init() {
        self.path = []
    }
    
    func navigateHome() {
        path.removeAll()
    }
    
    
}

public enum PathComponent: String {
    case multiplayer, options, singleplayer, achievements, tutorial
}
