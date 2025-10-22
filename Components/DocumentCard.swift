import SwiftUI

struct DocumentCard: View {
    let user: User
    
    var body: some View {
        GlassmorphicCard(cornerRadius: 32, opacity: 0.4) {
            VStack(alignment: .leading, spacing: 0) {
                // Верхняя часть с фото и данными
                VStack(alignment: .leading, spacing: 0) {
                    // Заголовок
                    Text("єДокумент")
                        .font(.system(size: 28, weight: .semibold))
                        .foregroundColor(.black)
                        .padding(.bottom, 24)
                    
                    // Фото + данные
                    HStack(alignment: .top, spacing: 20) {
                        // Фото
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.gray.opacity(0.2))
                            .frame(width: 120, height: 156)
                            .overlay(
                                Image(systemName: "person.fill")
                                    .font(.system(size: 50))
                                    .foregroundColor(.gray.opacity(0.5))
                            )
                        
                        // Данные
                        VStack(alignment: .leading, spacing: 12) {
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Дата\nнародження:")
                                    .font(.system(size: 15, weight: .medium))
                                    .foregroundColor(.black)
                                    .lineSpacing(2)
                                
                                Text(user.birthDate)
                                    .font(.system(size: 15, weight: .medium))
                                    .foregroundColor(.black)
                            }
                            
                            VStack(alignment: .leading, spacing: 2) {
                                Text("РНОКПП:")
                                    .font(.system(size: 15, weight: .medium))
                                    .foregroundColor(.black)
                                
                                Text(user.taxId)
                                    .font(.system(size: 15, weight: .medium))
                                    .foregroundColor(.black)
                            }
                        }
                        .padding(.top, 4)
                        
                        Spacer()
                    }
                    .padding(.bottom, 24)
                }
                .padding(.horizontal, 24)
                .padding(.top, 24)
                
                // Бегущая строка
                MarqueeText()
                
                // ФИО и кнопка
                HStack(alignment: .bottom) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(user.lastName)
                            .font(.system(size: 30, weight: .semibold))
                        Text(user.firstName)
                            .font(.system(size: 30, weight: .semibold))
                        Text(user.patronymic)
                            .font(.system(size: 30, weight: .semibold))
                    }
                    .foregroundColor(.black)
                    .lineSpacing(-2)
                    
                    Spacer()
                    
                    Button(action: {}) {
                        Image(systemName: "ellipsis")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(.white)
                            .frame(width: 36, height: 36)
                            .background(Circle().fill(Color.black))
                    }
                }
                .padding(.horizontal, 24)
                .padding(.top, 20)
                .padding(.bottom, 28)
            }
        }
        .frame(maxWidth: 380)
    }
}

struct MarqueeText: View {
    @State private var offset: CGFloat = 0
    
    let text = "Документ діє під час воєнного стану. Ой у лузі червона калина похилилася, чогось наша славна Україна зажурилася. А ми ту червону калину підіймемо, а ми нашу славну Україну, гей, гей, розвеселимо! "
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                ForEach(0..<4) { _ in
                    Text(text)
                        .font(.system(size: 14, weight: .semibold, design: .default))
                        .foregroundColor(Color(hex: "111111"))
                }
            }
            .offset(x: offset)
            .onAppear {
                let baseDistance = geometry.size.width
                withAnimation(
                    Animation.linear(duration: 70)
                        .repeatForever(autoreverses: false)
                ) {
                    offset = -baseDistance * 2
                }
            }
        }
        .frame(height: 30)
        .background(
            LinearGradient(
                colors: [
                    Color(hex: "a4eb97"),
                    Color(hex: "9addb0"),
                    Color(hex: "8ed1cc")
                ],
                startPoint: .leading,
                endPoint: .trailing
            )
        )
        .clipped()
    }
}

