import SwiftUI
import CoreImage.CIFilterBuiltins

struct DocumentCard: View {
    let user: User
    let onMenuTap: () -> Void
    @State private var isFlipped = false
    @State private var barcodeNumber = ""
    
    var body: some View {
        ZStack {
            // Front side
            DocumentCardFront(user: user, onMenuTap: onMenuTap)
                .opacity(isFlipped ? 0 : 1)
                .rotation3DEffect(
                    .degrees(isFlipped ? 180 : 0),
                    axis: (x: 0, y: 1, z: 0)
                )
            
            // Back side
            DocumentCardBack(barcodeNumber: barcodeNumber)
                .opacity(isFlipped ? 1 : 0)
                .rotation3DEffect(
                    .degrees(isFlipped ? 0 : -180),
                    axis: (x: 0, y: 1, z: 0)
                )
        }
        .frame(width: 360, height: 470)
        .onTapGesture {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                isFlipped.toggle()
                
                // Генерируем новый штрихкод при перевороте
                if isFlipped {
                    barcodeNumber = generateBarcodeNumber()
                }
            }
        }
    }
    
    private func generateBarcodeNumber() -> String {
        var result = ""
        for _ in 0..<13 {
            result += String(Int.random(in: 0...9))
        }
        return result
    }
}

// MARK: - Front Side
struct DocumentCardFront: View {
    let user: User
    let onMenuTap: () -> Void
    
    var body: some View {
        GlassmorphicCard(cornerRadius: 32, opacity: 0.1) {
            VStack(alignment: .leading, spacing: 0) {
                // Верхняя часть с фото и данными
                VStack(alignment: .leading, spacing: 0) {
                    // Заголовок
                    Text("єДокумент")
                        .font(.system(size: 28, weight: .regular, design: .default))
                        .foregroundColor(.black)
                        .padding(.bottom, 20)
                    
                    // Фото + данные
                    HStack(alignment: .top, spacing: 16) {
                        // Фото
                        if let photoData = UserDefaults.standard.data(forKey: "userPhoto"),
                           let uiImage = UIImage(data: photoData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 130, height: 170)
                                .clipShape(RoundedRectangle(cornerRadius: 14))
                        } else {
                            RoundedRectangle(cornerRadius: 14)
                                .fill(Color.gray.opacity(0.2))
                                .frame(width: 130, height: 170)
                                .overlay(
                                    Image(systemName: "person.fill")
                                        .font(.system(size: 52))
                                        .foregroundColor(.gray.opacity(0.5))
                                )
                        }
                        
                        // Данные
                        VStack(alignment: .leading, spacing: 14) {
                            VStack(alignment: .leading, spacing: 3) {
                                Text("Дата")
                                    .font(.system(size: 16, weight: .regular, design: .default))
                                    .foregroundColor(.black)
                                Text("народження:")
                                    .font(.system(size: 16, weight: .regular, design: .default))
                                    .foregroundColor(.black)
                                Text(user.birthDate)
                                    .font(.system(size: 16, weight: .regular, design: .default))
                                    .foregroundColor(.black)
                            }
                            
                            VStack(alignment: .leading, spacing: 3) {
                                Text("РНОКПП:")
                                    .font(.system(size: 16, weight: .regular, design: .default))
                                    .foregroundColor(.black)
                                Text(user.taxId)
                                    .font(.system(size: 16, weight: .regular, design: .default))
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
                
                Spacer()
                    .frame(minHeight: 40)
                
                // Бегущая строка
                MarqueeText()
                
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
        .frame(width: 360, height: 470)
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
                    .font(.system(size: 14, weight: .regular, design: .default))
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

// MARK: - Back Side
struct DocumentCardBack: View {
    let barcodeNumber: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 32)
            .fill(Color(red: 1.0, green: 1.0, blue: 1.0))
            .overlay(
                VStack(spacing: 0) {
                    Spacer()
                    
                    // Штрихкод
                    if let barcodeImage = generateBarcode(from: barcodeNumber.isEmpty ? "1234567890123" : barcodeNumber) {
                        Image(uiImage: barcodeImage)
                            .interpolation(.none)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 320, height: 150)
                            .padding(.horizontal, 20)
                    }
                    
                    Spacer()
                }
            )
            .frame(width: 360, height: 470)
            .shadow(color: Color.black.opacity(0.1), radius: 20, x: 0, y: 10)
    }
    
    func generateBarcode(from string: String) -> UIImage? {
        let context = CIContext()
        let filter = CIFilter.code128BarcodeGenerator()
        filter.message = Data(string.utf8)
        
        if let outputImage = filter.outputImage {
            let transform = CGAffineTransform(scaleX: 3, y: 3)
            let scaledImage = outputImage.transformed(by: transform)
            
            if let cgImage = context.createCGImage(scaledImage, from: scaledImage.extent) {
                return UIImage(cgImage: cgImage)
            }
        }
        return nil
    }
}

