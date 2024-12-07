//
//  HomeView.swift
//  ERS
//
//  Created by Hersh Nagpal on 3/22/23.
//

import SwiftUI
import GameKit

@MainActor
final class HomeViewModel: ObservableObject {
}

struct HomeView: View {
    @EnvironmentObject var vm: HomeViewModel
    @EnvironmentObject var asm: AppStorageManager
    @EnvironmentObject var navigationManger: NavigationManager
    
    var body: some View {
        NavigationStack(path: $navigationManger.path) {
            VStack(spacing: 20) {
                Spacer()
                ZStack {
                    Image(systemName: "hand.wave")
                        .resizable()
                        .frame(width: 250, height: 250)
                        .foregroundColor(.ersOrange)
                    TitleText("ers")
                }
                Spacer()
                NavigationButton(text: "multiplayer", onPress: { navigationManger.navigateToMultiplayer() })
                NavigationButton(text: "singleplayer", onPress: { navigationManger.navigateToSingleplayer() })

                HStack(spacing: 32) {
                    Spacer()
                    NavigationIcon(iconName: "trophy.fill", onPress: { navigationManger.navigateToAchievements() })
                    NavigationIcon(iconName: "doc.questionmark", onPress: { navigationManger.navigateToTutorial() })
                    NavigationIcon(iconName: "gearshape.fill", onPress: { navigationManger.navigateToOptions() })
                    Spacer()
                }
            }
            .padding(24)
            .background(LinearGradient(gradient: Gradient(colors: [.ersDarkBackground, .ersGreyBackground]), startPoint: .bottom, endPoint: .top))
            .navigationDestination(for: String.self) { string in
                switch string {
                case PathComponent.options.rawValue:
                    SettingsView()
                        .navigationTitle("options")
                case PathComponent.multiplayer.rawValue:
                    LocalGameView(vm: LocalGameViewModel(ruleState: asm.asRuleState()), navigateHome: navigationManger.navigateHome, isSingleplayer: false)
                        .navigationBarBackButtonHidden()
                        .statusBar(hidden: true)
                case PathComponent.singleplayer.rawValue:
                    LocalGameView(vm: LocalGameViewModel(ruleState: asm.asRuleState()), navigateHome: navigationManger.navigateHome, isSingleplayer: true)
                        .navigationBarBackButtonHidden()
                        .statusBar(hidden: true)
                case PathComponent.tutorial.rawValue:
                    TutorialView(navigateHome: navigationManger.navigateHome)
                        .navigationTitle("tutorial")
                case PathComponent.achievements.rawValue:
                    AchievementsView()
                        .navigationTitle("achievements")
                default:
                    Spacer()
                }
            }
        }
    }
}

enum AlertType {
    case authError, notSignedIn
}
