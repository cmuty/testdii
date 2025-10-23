import SwiftUI

struct PassportCard: View {
    let user: User
    
    var body: some View {
        GlassmorphicCard(cornerRadius: 32, opacity: 0.15) {
            VStack(alignment: .leading, spacing: 0) {
                // Верхня частина з фото та данними
                VStack(alignment: .leading, spacing: 0) {
                    // Заголовок
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Паспорт громадянина")
                            .font(.system(size: 28, weight: .regular, design: .default))
                            .foregroundColor(.black)
                        Text("України")
                            .font(.system(size: 28, weight: .regular, design: .default))
                            .foregroundColor(.black)
                    }
                    .padding(.bottom, 20)
                    
                    // Фото + данные
                    HStack(alignment: .top, spacing: 16) {
                        // Фото
                        RoundedRectangle(cornerRadius: 14)
                            .fill(Color.gray.opacity(0.2))
                            .frame(width: 130, height: 170)
                            .overlay(
                                Image(systemName: "person.fill")
                                    .font(.system(size: 52))
                                    .foregroundColor(.gray.opacity(0.5))
                            )
                        
                        // Данные
                        VStack(alignment: .leading, spacing: 14) {
                            VStack(alignment: .leading, spacing: 3) {
                                Text("Дата")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(.black)
                                Text("народження:")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(.black)
                                Text("07.01.2010")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(.black)
                            }
                            
                            VStack(alignment: .leading, spacing: 3) {
                                Text("Номер:")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(.black)
                                Text("010322300")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(.black)
                            }
                            
                            // Підпис
                            if let signature = loadSignature() {
                                Image(uiImage: signature)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 100, height: 40)
                            } else {
                                Image(systemName: "signature")
                                    .font(.system(size: 30))
                                    .foregroundColor(.gray.opacity(0.3))
                            }
                        }
                        .padding(.top, 4)
                        
                        Spacer()
                    }
                    .padding(.bottom, 20)
                }
                .padding(.horizontal, 20)
                .padding(.top, 22)
                
                Spacer()
                    .frame(minHeight: 40)
                
                // Бегущая строка
                PassportMarqueeText()
                
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
                    
                    Button(action: {}) {
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
        .frame(width: 360, height: 450)
    }
    
    func loadSignature() -> UIImage? {
        guard let data = UserDefaults.standard.data(forKey: "userSignature") else { return nil }
        return UIImage(data: data)
    }
}

struct PassportMarqueeText: View {
    @State private var offset: CGFloat = 0
    @State private var currentDateTime: String = ""
    
    var text: String {
        "Документ оновлено о \(currentDateTime) "
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
        
        // Використовуємо дату авторизації
        if let loginDate = UserDefaults.standard.object(forKey: "lastLoginDate") as? Date {
            currentDateTime = formatter.string(from: loginDate)
        } else {
            currentDateTime = formatter.string(from: Date())
        }
    }
}

