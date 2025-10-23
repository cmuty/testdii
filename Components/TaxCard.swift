import SwiftUI

struct TaxCard: View {
    let user: User
    
    var body: some View {
        GlassmorphicCard(cornerRadius: 32, opacity: 0.15) {
            VStack(alignment: .leading, spacing: 0) {
                // Заголовок
                VStack(alignment: .leading, spacing: 2) {
                    Text("Картка платника")
                        .font(.system(size: 22, weight: .regular))
                        .foregroundColor(.black)
                    Text("податків")
                        .font(.system(size: 22, weight: .regular))
                        .foregroundColor(.black)
                }
                .padding(.bottom, 20)
                .padding(.horizontal, 20)
                .padding(.top, 22)
                
                // РНОКПП заголовок
                VStack(alignment: .leading, spacing: 16) {
                    Text("РНОКПП")
                        .font(.system(size: 13, weight: .regular))
                        .foregroundColor(.black)
                    
                    // ФІО
                    VStack(alignment: .leading, spacing: 4) {
                        Text(user.lastName)
                            .font(.system(size: 20, weight: .regular))
                        Text(user.firstName)
                            .font(.system(size: 20, weight: .regular))
                        Text(user.patronymic)
                            .font(.system(size: 20, weight: .regular))
                    }
                    .foregroundColor(.black)
                    
                    // Дата народження
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Дата народження:")
                            .font(.system(size: 15, weight: .regular))
                            .foregroundColor(.black)
                        Text("07.01.2010")
                            .font(.system(size: 15, weight: .regular))
                            .foregroundColor(.black)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 28)
                
                Spacer()
                
                // Бегущая строка
                TaxMarqueeText()
                
                // РНОКПП внизу
                HStack(alignment: .center) {
                    Text("4018401651")
                        .font(.system(size: 36, weight: .medium))
                        .foregroundColor(.black)
                    
                    Button(action: {
                        UIPasteboard.general.string = "4018401651"
                    }) {
                        Image(systemName: "doc.on.doc")
                            .font(.system(size: 20))
                            .foregroundColor(.black)
                    }
                    .padding(.leading, 8)
                    
                    Spacer()
                    
                    Button(action: {}) {
                        Image(systemName: "ellipsis")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.white)
                            .frame(width: 32, height: 32)
                            .background(Circle().fill(Color.black))
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 24)
                .padding(.bottom, 28)
            }
        }
        .frame(maxWidth: 360, height: 430)
    }
}

struct TaxMarqueeText: View {
    @State private var offset: CGFloat = 0
    @State private var currentTime: String = ""
    
    var text: String {
        "Документ оновлено о \(currentTime) Перевірено Державною податковою службою "
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
                    .font(.system(size: 14, weight: .semibold, design: .default))
                    .foregroundColor(Color(hex: "111111"))
                    .lineLimit(1)
                    .fixedSize(horizontal: true, vertical: false)
                    .frame(height: 32)
                    .offset(x: offset)
                    .onAppear {
                        updateTime()
                        
                        let textWidth = (text as NSString).size(
                            withAttributes: [.font: UIFont.systemFont(ofSize: 14, weight: .semibold)]
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
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm | dd.MM.yyyy"
        formatter.locale = Locale(identifier: "uk_UA")
        currentTime = formatter.string(from: Date())
    }
}

