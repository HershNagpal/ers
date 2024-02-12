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
            for id in AchievementId.allCases {
                if AchievementManager.hasCompletedAchievement(id) {
                    AchievementManager.reportCompletedAchievement(id)
                }
                GKAchievement.loadAchievements(completionHandler: {(achievements: [GKAchievement]?, error: Error?) in
                    let achievementID = id.rawValue
                    var achievement: GKAchievement? = nil
                    
                    // Find an existing achievement.
                    achievement = achievements?.first(where: { $0.identifier == achievementID})
                    
                    if let achievement = achievement {
                        if achievement.isCompleted {
                            AchievementManager.completeAchievement(id)
                        } else if id == .hundredBotWins || id == .thousandGames || id == .hundredGames {
                            let completion = achievement.percentComplete
                            print("Loading achievement \(id):\(achievement.percentComplete)")
                            switch id {
                            case .hundredGames:
                                AchievementManager.setAchievementProgress(id, exactAmount: Int(completion))
                                break
                            case .hundredBotWins:
                                AchievementManager.setAchievementProgress(id, exactAmount: Int(completion))
                                break
                            case .thousandGames:
                                AchievementManager.setAchievementProgress(id, exactAmount: Int(completion*10))
                                break
                            default:
                                break
                            }
                        }
                    }
                    
                    // Insert code to report the percentage.
                    
                    if error != nil {
                        // Handle the error that occurs.
                        print("Error Authenticating Achievements: \(String(describing: error))")
                    }
                })
            }
        }
    }
}

@available(iOS 16.0, *)
struct HomeView: View {
    @EnvironmentObject var vm: HomeViewModel
    
    @State var path = [String]()
    
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
                NavigationButton(text: "achievements", onPress: {path.append("achievements")})
                NavigationButton(text: "tutorial", onPress: {path.append("tutorial")})
                NavigationButton(text: "options", onPress: {path.append("options")})
                Spacer()
            }
            .onAppear {
                vm.authenticateUser()
            }
            .frame(maxWidth: .infinity)
            .background(LinearGradient(gradient: Gradient(colors: [.ersYellow, .ersOrange]), startPoint: .top, endPoint: .bottom))
            .navigationDestination(for: String.self) { string in
                switch string {
                case "options":
                    SettingsView()
                        .navigationTitle("options")
                case "multiplayer":
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
