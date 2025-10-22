import SwiftUI

struct WelcomeView: View {
    @EnvironmentObject var authManager: AuthManager
    @State private var scale: CGFloat = 0.8
    @State private var opacity: Double = 0
    
    var body: some View {
        ZStack {
            AnimatedGradientBackground()
            
            VStack(spacing: 24) {
                Text("Дія")
                    .font(.system(size: 72, weight: .bold))
                    .foregroundColor(.black)
                
                Text("🇺🇦")
                    .font(.system(size: 80))
            }
            .scaleEffect(scale)
            .opacity(opacity)
            .onAppear {
                // Анімація появи
                withAnimation(.easeOut(duration: 0.6)) {
                    scale = 1.0
                    opacity = 1.0
                }
                
                // Автоматично переходимо далі через 1.5 секунди
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    withAnimation(.easeOut(duration: 0.3)) {
                        opacity = 0
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        authManager.markWelcomeSeen()
                    }
                }
            }
        }
    }
}

