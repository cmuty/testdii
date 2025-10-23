import SwiftUI

struct WelcomeView: View {
    @EnvironmentObject var authManager: AuthManager
    @State private var scale: CGFloat = 0.8
    @State private var opacity: Double = 0
    
    var body: some View {
        ZStack {
            AnimatedGradientBackground()
            
            VStack(spacing: 40) {
                Spacer()
                
                // Привіт + емодзі
                HStack(spacing: 8) {
                    Text("Привіт")
                        .font(.system(size: 48, weight: .bold))
                        .foregroundColor(.black)
                    Text("👋")
                        .font(.system(size: 48))
                }
                
                // Іконки Дія внизу
                HStack(spacing: 20) {
                    // Чорна іконка
                    ZStack {
                        RoundedRectangle(cornerRadius: 28)
                            .fill(Color.black)
                            .frame(width: 100, height: 100)
                        
                        Text("Дія")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.white)
                    }
                    
                    // Біла іконка з тризубом
                    ZStack {
                        RoundedRectangle(cornerRadius: 28)
                            .stroke(Color.black, lineWidth: 3)
                            .fill(Color.white)
                            .frame(width: 100, height: 100)
                        
                        Image(systemName: "shield.fill")
                            .font(.system(size: 50))
                            .foregroundColor(.black)
                    }
                }
                
                Spacer()
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

