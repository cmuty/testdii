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
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundColor(.black)
                        .padding(.bottom, 20)
                    
                    // Фото + данные
                    HStack(alignment: .top, spacing: 16) {
                        // Фото
                        RoundedRectangle(cornerRadius: 14)
                            .fill(Color.gray.opacity(0.2))
                            .frame(width: 110, height: 145)
                            .overlay(
                                Image(systemName: "person.fill")
                                    .font(.system(size: 48))
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
                                Text("РНОКПП:")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(.black)
                                Text("4018401651")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(.black)
                            }
                        }
                        .padding(.top, 4)
                        
                        Spacer()
                    }
                    .padding(.bottom, 20)
                }
                .padding(.horizontal, 20)
                .padding(.top, 22)
                
                // Бегущая строка
                MarqueeText()
                
                Spacer()
                
                // ФИО и кнопка
                HStack(alignment: .bottom) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text(user.lastName)
                            .font(.system(size: 26, weight: .regular))
                        Text(user.firstName)
                            .font(.system(size: 26, weight: .regular))
                        Text(user.patronymic)
                            .font(.system(size: 26, weight: .regular))
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
                .padding(.top, 12)
                .padding(.bottom, 24)
            }
        }
        .frame(maxWidth: 360, minHeight: 700)
    }
}

struct MarqueeText: View {
    @State private var offset: CGFloat = 0
    
    let text = "Документ діє під час воєнного стану. Ой у лузі червона калина похилилася, чогось наша славна Україна зажурилася. А ми ту червону калину підіймемо, а ми нашу славну Україну, гей, гей, розвеселимо! А ми тую червону калину підіймемо, а ми нашу славну Україну, гей, гей, розвеселимо! "
    
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
                        let textWidth = (text as NSString).size(
                            withAttributes: [.font: UIFont.systemFont(ofSize: 14, weight: .semibold)]
                        ).width
                        
                        withAnimation(
                            Animation.linear(duration: 40)
                                .repeatForever(autoreverses: false)
                        ) {
                            offset = -textWidth
                        }
                    }
            }
        }
        .frame(height: 32)
        .clipped()
    }
}

