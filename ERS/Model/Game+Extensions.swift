//
//  Game+Extensions.swift
//  ERS
//
//  Created by Hersh Nagpal on 8/23/24.
//

import Foundation
import GameKit

extension Game: GKGameCenterControllerDelegate {
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true)
    }
    
    
}
