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
                        .font(.system(size: 48, weight: .regular, design: .default))
                        .foregroundColor(.black)
                    Text("👋")
                        .font(.system(size: 48))
                }
                
                Spacer()
                
                // Іконка Дія внизу по середині
                Image("DiiaIcon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120, height: 120)
                    .cornerRadius(28)
                    .padding(.bottom, 60)
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

