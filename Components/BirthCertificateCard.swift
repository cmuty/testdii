import SwiftUI
import UIKit

struct BirthCertificateCard: View {
    let user: User
    let onMenuTap: () -> Void
    
    var body: some View {
        GlassmorphicCard(cornerRadius: 32, opacity: 0.1) {
            VStack(alignment: .leading, spacing: 0) {
                // Верхняя часть с заголовком
                VStack(alignment: .leading, spacing: 8) {
                    // Заголовок
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Актовий запис про")
                            .font(.system(size: 28, weight: .regular, design: .default))
                            .foregroundColor(.black)
                        Text("моє народження")
                            .font(.system(size: 28, weight: .regular, design: .default))
                            .foregroundColor(.black)
                    }
                    
                    // Подзаголовок
                    Text("Свідоцтва про народження")
                        .font(.system(size: 18, weight: .regular, design: .default))
                        .foregroundColor(.black.opacity(0.8))
                        .padding(.top, 4)
                    
                    // Дата народження
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Дата народження:")
                            .font(.system(size: 14, weight: .regular, design: .default))
                            .foregroundColor(.black)
                        Text(user.birthDate)
                            .font(.system(size: 14, weight: .regular, design: .default))
                            .foregroundColor(.black)
                    }
                    .padding(.top, 12)
                    
                    // Місце народження
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Місце народження:")
                            .font(.system(size: 14, weight: .regular, design: .default))
                            .foregroundColor(.black)
                        Text(user.birthPlace)
                            .font(.system(size: 14, weight: .regular, design: .default))
                            .foregroundColor(.black)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding(.top, 8)
                }
                .padding(.horizontal, 20)
                .padding(.top, 22)
                
                Spacer()
                
                // Бегущая строка
                BirthCertificateMarqueeText()
                
                // ФИО и кнопка
                HStack(alignment: .bottom) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text(user.lastName)
                            .font(.system(size: 26, weight: .regular, design: .default))
                        Text(user.firstName)
                            .font(.system(size: 26, weight: .regular, design: .default))
                        Text(user.patronymic)
                            .font(.system(size: 26, weight: .regular, design: .default))
                    }
                    .foregroundColor(.black)
                    
                    Spacer()
                    
                    Button(action: onMenuTap) {
                        Image(systemName: "ellipsis")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.white)
                            .frame(width: 32, height: 32)
                            .background(Circle().fill(Color.black))
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 8)
                .padding(.bottom, 24)
            }
        }
        .frame(width: 360, height: 540)
    }
}

struct BirthCertificateMarqueeText: View {
    @State private var offset: CGFloat = 0
    @State private var currentTime: String = ""
    
    var text: String {
        "Документ оновлено о \(currentTime) • "
    }
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(hex: "a4eb97"),
                    Color(hex: "9addb0"),
                    Color(hex: "8ed1cc")
                ],
                startPoint: .leading,
                endPoint: .trailing
            )
            
            GeometryReader { geometry in
                Text(text + text + text)
                    .font(.system(size: 14, weight: .regular, design: .default))
                    .foregroundColor(Color(hex: "111111"))
                    .lineLimit(1)
                    .fixedSize(horizontal: true, vertical: false)
                    .frame(height: 32)
                    .offset(x: offset)
                    .onAppear {
                        updateTime()
                        
                        let textWidth = (text as NSString).size(
                            withAttributes: [.font: UIFont.systemFont(ofSize: 14, weight: .regular)]
                        ).width
                        
                        withAnimation(
                            Animation.linear(duration: 30)
                                .repeatForever(autoreverses: false)
                        ) {
                            offset = -textWidth
                        }
                        
                        // Оновлюємо час кожну хвилину
                        Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { _ in
                            updateTime()
                        }
                    }
            }
        }
        .frame(height: 32)
        .clipped()
    }
    
    private func updateTime() {
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "HH:mm | dd.MM.yyyy"
        outputFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        // Використовуємо дату останнього входу
        if let lastLoginDate = UserDefaults.standard.object(forKey: "lastLoginDate") as? Date {
            currentTime = outputFormatter.string(from: lastLoginDate)
        } else {
            currentTime = outputFormatter.string(from: Date())
        }
    }
}

