import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authManager: AuthManager
    
    var body: some View {
        Group {
            if !authManager.hasSeenWelcome {
                WelcomeView()
            } else if !authManager.isAuthenticated {
                AuthView()
            } else if !authManager.hasSignature {
                SignatureView()
            } else {
                MainTabView()
            }
        }
        .animation(.easeInOut, value: authManager.isAuthenticated)
    }
}

