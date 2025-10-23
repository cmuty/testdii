import SwiftUI

struct NoSubscriptionView: View {
    @EnvironmentObject var authManager: AuthManager
    
    var body: some View {
        ZStack {
            AnimatedGradientBackground()
            
            VStack(spacing: 32) {
                Spacer()
                
                // Иконка
                Image(systemName: "lock.shield")
                    .font(.system(size: 80))
                    .foregroundColor(.white.opacity(0.9))
                
                // Текст
                VStack(spacing: 12) {
                    Text("У вас немає активної підписки")
                        .font(.system(size: 28, weight: .bold))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                    
                    Text("Для використання застосунку потрібна активна підписка.\nПерейдіть до бота для отримання підписки.")
                        .font(.system(size: 16))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white.opacity(0.8))
                        .padding(.horizontal, 32)
                }
                
                Spacer()
                
                // Кнопки
                VStack(spacing: 16) {
                    // Кнопка перехода в бота
                    Button(action: {
                        if let url = URL(string: "https://t.me/maijediiabot") {
                            UIApplication.shared.open(url)
                        }
                    }) {
                        HStack {
                            Image(systemName: "paperplane.fill")
                            Text("Перейти до бота")
                                .font(.system(size: 18, weight: .semibold))
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(Color.black)
                        .cornerRadius(16)
                    }
                    
                    // Кнопка выхода
                    Button(action: {
                        authManager.logout()
                    }) {
                        Text("Вийти")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.white.opacity(0.8))
                    }
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 48)
            }
        }
    }
}

