import SwiftUI

// Экран приветствия с анимацией (как в ios-diia-main)
struct WelcomeView: View {
    @EnvironmentObject var authManager: AuthManager
    @StateObject private var pinCodeManager = PinCodeManager.shared
    
    @State private var titleScale: CGFloat = 0.5
    @State private var titleOpacity: Double = 0
    @State private var iconScale: CGFloat = 0.3
    @State private var iconOpacity: Double = 0
    @State private var iconRotation: Double = -180
    
    // Длительность анимации как в ios-diia-main (3 секунды)
    private let animationDuration: Double = 3.0
    
    // Callback для уведомления о завершении анимации (для авторизованных пользователей)
    var onAnimationComplete: (() -> Void)? = nil
    
    var body: some View {
        ZStack {
            AnimatedGradientBackground()
            
            VStack(spacing: 0) {
                Spacer()
                
                // Текст "Привіт" с анимацией появления
                Text("Привіт")
                    .font(.system(size: 48, weight: .regular, design: .default))
                    .foregroundColor(.black)
                    .scaleEffect(titleScale)
                    .opacity(titleOpacity)
                    .padding(.bottom, 40)
                
                // Иконка Дія с анимацией
                Image("DiiaIcon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120, height: 120)
                    .cornerRadius(28)
                    .scaleEffect(iconScale)
                    .opacity(iconOpacity)
                    .rotationEffect(.degrees(iconRotation))
                
                Spacer()
                    .frame(height: 200)
            }
        }
        .onAppear {
            startAnimation()
        }
    }
    
    private func startAnimation() {
        // Анимация появления текста "Привіт"
        withAnimation(.spring(response: 0.6, dampingFraction: 0.7).delay(0.2)) {
            titleScale = 1.0
            titleOpacity = 1.0
        }
        
        // Анимация появления иконки (с задержкой и вращением)
        withAnimation(.spring(response: 0.8, dampingFraction: 0.6).delay(0.4)) {
            iconScale = 1.0
            iconOpacity = 1.0
            iconRotation = 0
        }
        
        // После завершения анимации (3 секунды как в ios-diia-main)
        DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
            // Если пользователь не авторизован - просто отмечаем что видели приветствие
            if !authManager.isAuthenticated {
                authManager.markWelcomeSeen()
            } else {
                // Если авторизован - скрываем приветствие и вызываем callback
                withAnimation(.easeOut(duration: 0.3)) {
                    titleOpacity = 0
                    iconOpacity = 0
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    // Вызываем callback для уведомления о завершении анимации
                    onAnimationComplete?()
                }
            }
        }
    }
}

