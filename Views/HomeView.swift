import SwiftUI

struct HomeView: View {
    @EnvironmentObject var authManager: AuthManager
    
    // Получаем имя из полного имени (первое слово)
    private var firstName: String {
        if !authManager.userFullName.isEmpty {
            return authManager.userFullName.components(separatedBy: " ").first ?? authManager.userName
        }
        return authManager.userName
    }
    
    var body: some View {
        ZStack {
            AnimatedGradientBackground()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    // Приветствие
                    Text("Привіт, \(firstName)! 👋")
                        .font(.system(size: 30, weight: .bold))
                        .padding(.top, 64)
                        .padding(.bottom, 8)
                    
                    // Незламність
                    GlassmorphicCard(cornerRadius: 24, opacity: 0.7) {
                        HStack(spacing: 12) {
                            HStack(spacing: 4) {
                                Circle()
                                    .fill(Color.blue)
                                    .frame(width: 32, height: 32)
                                Image(systemName: "bolt.fill")
                                    .foregroundColor(.yellow)
                                    .font(.system(size: 24))
                            }
                            
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Незламність")
                                    .font(.system(size: 18, weight: .semibold))
                                Text("Мапа Пунктів Незламності та укриттів")
                                    .font(.system(size: 14))
                                    .foregroundColor(.gray)
                                    .lineLimit(2)
                            }
                            
                            Spacer()
                        }
                        .padding(16)
                    }
                    
                    // Кнопки сервисов
                    HStack(spacing: 12) {
                        ServiceButton(icon: "qrcode", title: "Сканувати QR-код")
                        ServiceButton(icon: "shield.fill", title: "Військові облігації")
                        ServiceButton(icon: "wifi.slash", title: "Відсутній зв'язок")
                    }
                    
                    // ЛІНІЯ ДРОНІВ
                    ZStack {
                        RoundedRectangle(cornerRadius: 24)
                            .fill(
                                LinearGradient(
                                    colors: [Color(hex: "2a3f2a"), Color(hex: "1a2f1a")],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                        
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                HStack(spacing: 8) {
                                    Image(systemName: "shield.fill")
                                        .font(.system(size: 28))
                                    Text("ЛІНІЯ ДРОНІВ")
                                        .font(.system(size: 24, weight: .bold))
                                }
                                Text("Змінити хід подій")
                                    .font(.system(size: 14))
                                    .opacity(0.9)
                            }
                            .foregroundColor(.white)
                            
                            Spacer()
                        }
                        .padding(24)
                    }
                    .frame(height: 120)
                    
                    // Що нового
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Що нового?")
                            .font(.system(size: 20, weight: .bold))
                        
                        GlassmorphicCard(cornerRadius: 24, opacity: 0.7) {
                            Color.clear
                                .frame(height: 120)
                        }
                    }
                    
                    Spacer(minLength: 100)
                }
                .padding(.horizontal, 24)
            }
        }
    }
}

struct ServiceButton: View {
    let icon: String
    let title: String
    
    var body: some View {
        VStack(spacing: 8) {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.black)
                .frame(width: 48, height: 48)
                .overlay(
                    Image(systemName: icon)
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                )
            
            Text(title)
                .font(.system(size: 13, weight: .semibold))
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .padding(.horizontal, 8)
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(Color.white.opacity(0.7))
                .background(.ultraThinMaterial)
        )
    }
}

