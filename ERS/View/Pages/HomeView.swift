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
    @Published var showAlert = false
    @Published var alertType: AlertType = .notSignedIn
    
    func authenticateUser() {
        GKLocalPlayer.local.authenticateHandler = { vc, error in
            guard error == nil else {
                print(error?.localizedDescription ?? "")
                self.alertType = .authError
//                showAlert = true
                return
            }
        }
    }
}

struct HomeView: View {
    @EnvironmentObject var vm: HomeViewModel
    
    @State var path = [String]()
    
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
                NavigationButton(text: "multiplayer", onPress: {path.append("multiplayer")})
                NavigationButton(text: "singleplayer", onPress: {path.append("singleplayer")})

                HStack(spacing: 32) {
                    Spacer()
                    NavigationIcon(iconName: "trophy.fill", onPress: {path.append("achievements")})
                    NavigationIcon(iconName: "doc.questionmark", onPress: {path.append("tutorial")})
                    NavigationIcon(iconName: "gearshape.fill", onPress: {path.append("options")})
                    Spacer()
                }
            }
            .onAppear {
                vm.authenticateUser()
                AchievementManager.syncAchievements()
            }
            .padding(24)
            .background(LinearGradient(gradient: Gradient(colors: [.ersDarkBackground, .ersGreyBackground]), startPoint: .bottom, endPoint: .top))
            .navigationDestination(for: String.self) { string in
                switch string {
                case "options":
                    SettingsView()
                        .navigationTitle("options")
                case "multiplayer":
                    MultiplayerView(path: $path)
                        .navigationBarBackButtonHidden()
                        .statusBar(hidden: true)
                case "singleplayer":
                    SingleplayerView(path: $path)
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
            .alert(isPresented: $vm.showAlert) {
                switch vm.alertType {
                case .authError:
                    Alert(title: Text("auth error"))
                case .notSignedIn:
                    Alert(
                        title: Text("not signed in"),
                        message: Text("sign in to play"),
                        primaryButton: .default(
                            Text("sign in"),
                            action: {
                                vm.showAlert = false
                                vm.authenticateUser()
                            }
                        ),
                        secondaryButton: .destructive(
                            Text("cancel"),
                            action: {vm.showAlert = false}
                        )
                    )
                }
            }
        }
    }
}

enum AlertType {
    case authError, notSignedIn
}
