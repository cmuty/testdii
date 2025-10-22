import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authManager: AuthManager
    
    var body: some View {
        Group {
            if authManager.isAuthenticated {
                MainTabView()
            } else if authManager.hasSeenWelcome {
                AuthView()
            } else {
                WelcomeView()
            }
        }
        .animation(.easeInOut, value: authManager.isAuthenticated)
    }
}

