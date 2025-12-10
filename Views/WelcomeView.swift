import SwiftUI

// Простое приветствие как было раньше
struct WelcomeView: View {
    @EnvironmentObject var authManager: AuthManager
    
    @State private var titleScale: CGFloat = 0.5
    @State private var titleOpacity: Double = 0
    @State private var iconScale: CGFloat = 0.3
    @State private var iconOpacity: Double = 0
    @State private var iconRotation: Double = -180
    
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
        
        // После завершения анимации (3 секунды)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            authManager.markWelcomeSeen()
        }
    }
}

