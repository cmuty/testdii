import SwiftUI

struct DocumentCard: View {
    let user: User
    
    var body: some View {
        GlassmorphicCard(cornerRadius: 32, opacity: 0.15) {
            VStack(alignment: .leading, spacing: 0) {
                // Верхняя часть с фото и данными
                VStack(alignment: .leading, spacing: 0) {
                    // Заголовок
                    Text("єДокумент")
                        .font(.system(size: 28, weight: .semibold))
                        .foregroundColor(.black)
                        .padding(.bottom, 28)
                    
                    // Фото + данные
                    HStack(alignment: .top, spacing: 20) {
                        // Фото (увеличено)
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.gray.opacity(0.2))
                            .frame(width: 140, height: 182)
                            .overlay(
                                Image(systemName: "person.fill")
                                    .font(.system(size: 60))
                                    .foregroundColor(.gray.opacity(0.5))
                            )
                        
                        // Данные
                        VStack(alignment: .leading, spacing: 16) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Дата")
                                    .font(.system(size: 15, weight: .medium))
                                    .foregroundColor(.black)
                                Text("народження:")
                                    .font(.system(size: 15, weight: .medium))
                                    .foregroundColor(.black)
                                Text("07.01.2010")
                                    .font(.system(size: 15, weight: .medium))
                                    .foregroundColor(.black)
                            }
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("РНОКПП:")
                                    .font(.system(size: 15, weight: .medium))
                                    .foregroundColor(.black)
                                Text("4018401651")
                                    .font(.system(size: 15, weight: .medium))
                                    .foregroundColor(.black)
                            }
                        }
                        .padding(.top, 4)
                        
                        Spacer()
                    }
                    .padding(.bottom, 40)
                }
                .padding(.horizontal, 24)
                .padding(.top, 28)
                
                // Бегущая строка
                MarqueeText()
                
                // ФИО и кнопка
                HStack(alignment: .bottom) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text(user.lastName)
                            .font(.system(size: 30, weight: .regular))
                        Text(user.firstName)
                            .font(.system(size: 30, weight: .regular))
                        Text(user.patronymic)
                            .font(.system(size: 30, weight: .regular))
                    }
                    .foregroundColor(.black)
                    
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
                .padding(.top, 24)
                .padding(.bottom, 32)
            }
        }
        .frame(maxWidth: 380, minHeight: 520)
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
            .frame(width: geometry.size.width * 4)
            .offset(x: offset)
            .onAppear {
                let textWidth = geometry.size.width
                withAnimation(
                    Animation.linear(duration: 60)
                        .repeatForever(autoreverses: false)
                ) {
                    offset = -textWidth * 2
                }
            }
        }
        .frame(height: 34)
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

