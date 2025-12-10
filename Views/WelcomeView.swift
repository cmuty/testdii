import SwiftUI

// Прямая копия из ios-diia-main - используем оригинальный SplashScreenViewController
struct WelcomeView: View {
    @EnvironmentObject var authManager: AuthManager
    
    // Callback для уведомления о завершении анимации (для авторизованных пользователей)
    var onAnimationComplete: (() -> Void)? = nil
    
    var body: some View {
        SplashScreenViewWrapper(onFinish: {
            // Если пользователь не авторизован - просто отмечаем что видели приветствие
            if !authManager.isAuthenticated {
                authManager.markWelcomeSeen()
            } else {
                // Если авторизован - вызываем callback
                onAnimationComplete?()
            }
        })
    }
}

