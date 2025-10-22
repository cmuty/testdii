import SwiftUI

struct WelcomeView: View {
    @EnvironmentObject var authManager: AuthManager
    
    var body: some View {
        ZStack {
            AnimatedGradientBackground()
            
            VStack {
                Spacer()
                
                Text("Привіт 👋")
                    .font(.system(size: 60, weight: .bold))
                    .foregroundColor(.black)
                
                Spacer()
                
                HStack(spacing: 16) {
                    Button(action: {
                        authManager.markWelcomeSeen()
                    }) {
                        Text("Дія")
                            .font(.system(size: 24, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(width: 128, height: 128)
                            .background(Color.black)
                            .cornerRadius(24)
                    }
                    
                    Button(action: {}) {
                        Text("🇺🇦")
                            .font(.system(size: 50))
                            .frame(width: 128, height: 128)
                            .background(
                                RoundedRectangle(cornerRadius: 24)
                                    .fill(Color.white.opacity(0.7))
                                    .background(.ultraThinMaterial)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 24)
                                            .stroke(Color.white.opacity(0.3), lineWidth: 2)
                                    )
                            )
                    }
                }
                .padding(.bottom, 80)
            }
            .padding()
        }
    }
}

