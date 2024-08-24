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
    @Binding var path: [String]
    @State var showAlert = false
    @State var alertType: AlertType = .notSignedIn
    
    var body: some View {
        NavigationStack(path: $path) {
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
                    NavigationButton(text: "multiplayer", onPress: {path.append("multiplayer")})
                    MultiplayerToggleView(showGameCenterAlert: $showAlert, backgroundColor: .black, foregroundColor: .white)
                }
                NavigationButton(text: "singleplayer", onPress: {path.append("singleplayer")})

                HStack(spacing: 32) {
                    Spacer()
                    NavigationIcon(iconName: "trophy.fill", onPress: {path.append("achievements")})
                    NavigationIcon(iconName: "doc.questionmark", onPress: {path.append("tutorial")})
                    NavigationIcon(iconName: "gearshape.fill", onPress: {path.append("options")})
                    Spacer()
                }
            }
            .onChange(of: onlineMatchManager.acceptedInvite) {
                if $1 {
                    asm.online = true
                    path.removeAll()
                    path.append("multiplayer")
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
            }
            .navigationDestination(for: String.self) { string in
                switch string {
                case "options":
                    SettingsView()
                        .navigationTitle("options")
                case "multiplayer":
                    if asm.online {
                        OnlineGameView(path: $path)
                            .navigationBarBackButtonHidden()
                            .statusBar(hidden: true)
                            .environmentObject(onlineMatchManager)
                    } else {
                        LocalGameView(path: $path, isSingleplayer: false)
                            .navigationBarBackButtonHidden()
                            .statusBar(hidden: true)
                    }
                case "singleplayer":
                    LocalGameView(path: $path, isSingleplayer: true)
                        .navigationBarBackButtonHidden()
                        .statusBar(hidden: true)
                case "tutorial":
                    TutorialView(path: $path)
                        .navigationTitle("tutorial")
                case "achievements":
                    AchievementsView(path: $path)
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
