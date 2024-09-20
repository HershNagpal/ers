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
    
    func navigateToMultiplayer() {
        path.append(PathComponent.multiplayer.rawValue)
    }
    
    func navigateToSingleplayer() {
        path.append(PathComponent.singleplayer.rawValue)
    }
    
    func navigateToAchievements() {
        path.append(PathComponent.achievements.rawValue)
    }
    
    func navigateToOptions() {
        path.append(PathComponent.options.rawValue)
    }
    
    func navigateToTutorial() {
        path.append(PathComponent.tutorial.rawValue)
    }
}

public enum PathComponent: String {
    case multiplayer, options, singleplayer, achievements, tutorial
}
