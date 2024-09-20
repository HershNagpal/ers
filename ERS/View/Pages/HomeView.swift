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
    @EnvironmentObject var onlineMatchManager: OnlineMatchManager
    @EnvironmentObject var navigationManger: NavigationManager
    @State var showAlert = false
    @State var alertType: AlertType = .notSignedIn
    
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
                HStack {
                    NavigationButton(text: "multiplayer", onPress: { navigationManger.navigateToMultiplayer() })
                    MultiplayerToggleView(showGameCenterAlert: $showAlert, backgroundColor: .black, foregroundColor: .white)
                }
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
            .onAppear {
                onlineMatchManager.authenticatePlayer()
                AchievementManager.syncAchievements()
                guard GKLocalPlayer.local.isAuthenticated else {
                    asm.online = false
                    return
                }
                onlineMatchManager.resetController()
            }
            .navigationDestination(for: String.self) { string in
                switch string {
                case PathComponent.options.rawValue:
                    SettingsView()
                        .navigationTitle("options")
                case PathComponent.multiplayer.rawValue:
                    if asm.online && GKLocalPlayer.local.isAuthenticated {
                        OnlineGameView(navigateHome: navigationManger.navigateHome)
                            .navigationBarBackButtonHidden()
                            .statusBar(hidden: true)
                            .environmentObject(onlineMatchManager)
                    } else {
                        LocalGameView(vm: LocalGameViewModel(ruleState: asm.asRuleState()), navigateHome: navigationManger.navigateHome, isSingleplayer: false)
                            .navigationBarBackButtonHidden()
                            .statusBar(hidden: true)
                    }
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
            .alert(isPresented: $showAlert) {
                switch alertType {
                case .authError:
                    Alert(title: Text("auth error"))
                case .notSignedIn:
                    Alert(
                        title: Text("not signed in"),
                        message: Text("sign in to play")
                    )
                }
            }
        }
    }
}

enum AlertType {
    case authError, notSignedIn
}
