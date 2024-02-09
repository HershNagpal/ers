//
//  HomeView.swift
//  ERS
//
//  Created by Hersh Nagpal on 3/22/23.
//

import SwiftUI
import GameKit

@available(iOS 16.0, *)
struct HomeView: View {
    @State var path = [String]()
    @State var showAlert = false
    @State var alertType: AlertType = .notSignedIn
    
    func authenticateUser() {
        GKLocalPlayer.local.authenticateHandler = { vc, error in
            guard error == nil else {
                print(error?.localizedDescription ?? "")
                alertType = .authError
                showAlert = true
                return
            }
        }
    }
    
    func handlePressOnline() {
        if GKLocalPlayer.local.isAuthenticated {
            path.append("online")
        } else {
            alertType = .notSignedIn
            showAlert = true
        }
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack(spacing: 20) {
                Spacer()
                ZStack {
                    Image("hand")
                        .resizable()
                        .frame(width: 150, height: 150)
                    TitleText("ers")
                        .foregroundColor(.white)
                        .shadow(color: .black, radius: 1)
                }
                Spacer()
                NavigationButton(text: "multiplayer", onPress: {path.append("multiplayer")})
                NavigationButton(text: "singleplayer", onPress: {path.append("singleplayer")})
                NavigationButton(text: "online", onPress: handlePressOnline)
                NavigationButton(text: "tutorial", onPress: {path.append("tutorial")})
                NavigationButton(text: "options", onPress: {path.append("options")})
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .background(Colors.yellow)
            .navigationDestination(for: String.self) { string in
                switch string {
                case "options":
                    SettingsView()
                        .navigationTitle("options")
                case "multiplayer":
                    GameView(path: $path)
                        .navigationBarBackButtonHidden()
                        .statusBar(hidden: true)
                case "online":
                    GameView(path: $path)
                        .navigationBarBackButtonHidden()
                        .statusBar(hidden: true)
                case "singleplayer":
                    PracticeView(path: $path)
                        .navigationBarBackButtonHidden()
                        .statusBar(hidden: true)
                case "tutorial":
                    TutorialView(path: $path)
                        .navigationTitle("tutorial")
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
                        message: Text("sign in to play"),
                        primaryButton: .default(
                            Text("sign in"),
                            action: {
                                showAlert = false
                                authenticateUser()
                            }
                        ),
                        secondaryButton: .destructive(
                            Text("cancel"),
                            action: {showAlert = false}
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
