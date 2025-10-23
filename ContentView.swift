import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authManager: AuthManager
    @State private var showNoSubscriptionAlert = false
    
    var body: some View {
        Group {
            if !authManager.hasSeenWelcome {
                WelcomeView()
            } else if !authManager.isAuthenticated {
                AuthView()
            } else if !authManager.subscriptionActive {
                // Блокуємо доступ якщо немає підписки
                ZStack {
                    AnimatedGradientBackground()
                    
                    VStack {
                        Spacer()
                    }
                }
                .alert("У вас немає активної підписки", isPresented: .constant(true)) {
                    Button("Перейти до бота") {
                        if let url = URL(string: "https://t.me/maijediiabot") {
                            UIApplication.shared.open(url)
                        }
                    }
                    Button("Вийти", role: .destructive) {
                        authManager.logout()
                    }
                } message: {
                    Text("Для використання застосунку потрібна активна підписка. Перейдіть до бота для отримання підписки.")
                }
            } else if !authManager.hasSignature {
                SignatureView()
            } else {
                MainTabView()
            }
        }
        .animation(.easeInOut, value: authManager.isAuthenticated)
    }
}

