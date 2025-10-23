import SwiftUI

struct HomeView: View {
    @EnvironmentObject var authManager: AuthManager
    @State private var currentNewsIndex = 0
    
    // Получаем имя из полного имени (второе слово - это имя)
    private var firstName: String {
        if !authManager.userFullName.isEmpty {
            let components = authManager.userFullName.components(separatedBy: " ")
            if components.count >= 2 {
                return components[1] // Второе слово - это имя
            }
            return components.first ?? authManager.userName
        }
        return authManager.userName
    }
    
    var body: some View {
        ZStack {
            AnimatedGradientBackground()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    // Приветствие
                    Text("Привіт, \(firstName) 👋")
                        .font(.system(size: 32, weight: .bold, design: .default))
                        .padding(.top, 64)
                        .padding(.bottom, 8)
                    
                    // Незламність
                    Button(action: {
                        print("Незламність")
                    }) {
                        HStack(spacing: 12) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Незламність")
                                    .font(.system(size: 18, weight: .semibold, design: .default))
                                    .foregroundColor(.black)
                                Text("Мапа Пунктів Незламності та укриттів.\nЗаява про відсутній зв'язок.")
                                    .font(.system(size: 14, weight: .regular, design: .default))
                                    .foregroundColor(.gray)
                                    .lineLimit(3)
                                
                                HStack(spacing: 8) {
                                    Circle()
                                        .fill(Color.blue)
                                        .frame(width: 36, height: 36)
                                        .overlay(
                                            Image(systemName: "shield.fill")
                                                .font(.system(size: 18))
                                                .foregroundColor(.white)
                                        )
                                    
                                    Circle()
                                        .fill(Color.yellow)
                                        .frame(width: 36, height: 36)
                                        .overlay(
                                            Image(systemName: "bolt.fill")
                                                .font(.system(size: 18))
                                                .foregroundColor(.white)
                                        )
                                }
                                .padding(.top, 4)
                            }
                            
                            Spacer()
                            
                            Circle()
                                .fill(Color.black)
                                .frame(width: 32, height: 32)
                                .overlay(
                                    Image(systemName: "arrow.right")
                                        .font(.system(size: 14, weight: .semibold))
                                        .foregroundColor(.white)
                                )
                        }
                        .padding(16)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.white.opacity(0.7))
                        )
                    }
                    
                    // Кнопки сервисов
                    HStack(spacing: 12) {
                        ServiceButton(icon: "qrcode", title: "Сканувати\nQR-код")
                        ServiceButton(icon: "shield.fill", title: "Військові\nоблігації")
                        ServiceButton(icon: "antenna.radiowaves.left.and.right", title: "Відсутній\nзв'язок")
                    }
                    
                    // ЛІНІЯ ДРОНІВ
                    Button(action: {
                        print("Лінія дронів")
                    }) {
                        ZStack {
                            // Background image
                            Image("liniya-droniv-1024x659")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(height: 180)
                                .clipped()
                            
                            // Dark overlay
                            Rectangle()
                                .fill(Color.black.opacity(0.3))
                            
                            // Content
                            VStack {
                                Spacer()
                                
                                HStack {
                                    Text("Змінити хід подій")
                                        .font(.system(size: 17, weight: .semibold, design: .default))
                                        .foregroundColor(.white)
                                    
                                    Spacer()
                                    
                                    Circle()
                                        .fill(Color.white)
                                        .frame(width: 32, height: 32)
                                        .overlay(
                                            Image(systemName: "arrow.right")
                                                .font(.system(size: 14, weight: .semibold))
                                                .foregroundColor(.black)
                                        )
                                }
                                .padding(16)
                                .background(Color.black.opacity(0.5))
                            }
                        }
                        .frame(height: 180)
                        .cornerRadius(16)
                    }
                    
                    // Що нового
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Що нового?")
                            .font(.system(size: 22, weight: .bold, design: .default))
                        
                        TabView(selection: $currentNewsIndex) {
                            NewsCard(
                                emoji: "🚗🚫",
                                time: "Сьогодні, 17:15",
                                title: "Заміна водійського посвідчення тимчасово на паузі"
                            )
                            .tag(0)
                            
                            NewsCard(
                                emoji: "🧳🏠📄",
                                time: "Сьогодні, 10:30",
                                title: "Долучайтесь до бета-тесту нової категорії Реєстру збитків"
                            )
                            .tag(1)
                        }
                        .tabViewStyle(.page(indexDisplayMode: .always))
                        .frame(height: 200)
                        .indexViewStyle(.page(backgroundDisplayMode: .always))
                    }
                    
                    // Популярні послуги
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Популярні послуги")
                            .font(.system(size: 22, weight: .bold, design: .default))
                        
                        VStack(spacing: 0) {
                            PopularServiceButton(title: "Опитування") {
                                print("Опитування")
                            }
                            
                            Divider()
                                .padding(.leading, 20)
                            
                            PopularServiceButton(title: "Заміна водійського посвідчення") {
                                print("Заміна водійського посвідчення")
                            }
                            
                            Divider()
                                .padding(.leading, 20)
                            
                            PopularServiceButton(title: "Податки ФОП") {
                                print("Податки ФОП")
                            }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.white.opacity(0.7))
                        )
                    }
                    
                    Spacer(minLength: 100)
                }
                .padding(.horizontal, 20)
            }
        }
    }
}

struct ServiceButton: View {
    let icon: String
    let title: String
    
    var body: some View {
        VStack(spacing: 8) {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.black)
                .frame(width: 56, height: 56)
                .overlay(
                    Image(systemName: icon)
                        .foregroundColor(.white)
                        .font(.system(size: 24))
                )
            
            Text(title)
                .font(.system(size: 12, weight: .regular, design: .default))
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .padding(.horizontal, 8)
    }
}

// News Card Component
struct NewsCard: View {
    let emoji: String
    let time: String
    let title: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Emoji section with gradient background
            ZStack {
                LinearGradient(
                    colors: [
                        Color(hex: "FFF5E1"),
                        Color(hex: "FFE4B5")
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                
                Text(emoji)
                    .font(.system(size: 60))
            }
            .frame(height: 120)
            
            // Text section
            VStack(alignment: .leading, spacing: 8) {
                Text(time)
                    .font(.system(size: 13, weight: .regular, design: .default))
                    .foregroundColor(.gray)
                
                Text(title)
                    .font(.system(size: 17, weight: .semibold, design: .default))
                    .foregroundColor(.black)
                    .lineLimit(2)
            }
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.white.opacity(0.9))
        }
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

// Popular Service Button Component
struct PopularServiceButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(title)
                    .font(.system(size: 17, weight: .regular, design: .default))
                    .foregroundColor(.black)
                
                Spacer()
                
                Circle()
                    .fill(Color.black)
                    .frame(width: 28, height: 28)
                    .overlay(
                        Image(systemName: "arrow.right")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(.white)
                    )
            }
            .padding(.horizontal, 20)
            .frame(height: 56)
            .contentShape(Rectangle())
        }
    }
}

