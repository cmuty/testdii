import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authManager: AuthManager
    @StateObject private var pinCodeManager = PinCodeManager.shared
    @State private var showNoSubscriptionAlert = false
    @State private var pinCodeEntered = false
    @State private var showWelcome = false
    @State private var welcomeFinished = false
    
    // Флаг для отслеживания, нужно ли показывать приветствие при следующем запуске
    @AppStorage("shouldShowWelcomeOnNextLaunch") private var shouldShowWelcomeOnNextLaunch = true
    
    var body: some View {
        Group {
            if !authManager.hasSeenWelcome && !authManager.isAuthenticated {
                // Показываем приветствие только для неавторизованных пользователей при первом запуске
                WelcomeView()
            } else if showWelcome && authManager.isAuthenticated && !welcomeFinished {
                // Показываем приветствие при каждом открытии для авторизованных пользователей
                WelcomeView(onAnimationComplete: {
                    welcomeFinished = true
                })
            } else if !authManager.isAuthenticated {
                AuthView()
            } else if authManager.shouldShowCreatePinCode {
                // Показываем экран создания пинкода после первой авторизации
                CreatePinCodeView {
                    authManager.shouldShowCreatePinCode = false
                    pinCodeEntered = true
                }
                .environmentObject(authManager)
            } else if authManager.isAuthenticated && pinCodeManager.hasPinCode() && !pinCodeEntered && welcomeFinished {
                // Показываем экран ввода пинкода после приветствия
                EnterPinCodeView {
                    pinCodeEntered = true
                }
                .environmentObject(authManager)
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
                        pinCodeEntered = false
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
        .animation(.easeInOut, value: pinCodeEntered)
        .animation(.easeInOut, value: showWelcome)
        .animation(.easeInOut, value: welcomeFinished)
        .onAppear {
            // При запуске приложения для авторизованных пользователей показываем приветствие
            checkAndShowWelcome()
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            // При возврате из фона для авторизованных пользователей показываем приветствие и пинкод
            if authManager.isAuthenticated {
                checkAndShowWelcome()
            }
        }
        .onChange(of: authManager.isAuthenticated) { isAuthenticated in
            if !isAuthenticated {
                pinCodeEntered = false
                showWelcome = false
                welcomeFinished = false
            } else if isAuthenticated {
                // При авторизации показываем приветствие, затем пинкод
                checkAndShowWelcome()
            }
        }
    }
    
    private func checkAndShowWelcome() {
        // При запуске приложения для авторизованных пользователей показываем приветствие
        if authManager.isAuthenticated {
            // Показываем приветствие при каждом открытии приложения
            showWelcome = true
            welcomeFinished = false
            pinCodeEntered = false
        }
    }
}

