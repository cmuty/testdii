import SwiftUI
import CoreImage.CIFilterBuiltins

struct PassportCard: View {
    let user: User
    let onMenuTap: () -> Void
    @State private var isFlipped = false
    @State private var showingQR = true // true = QR, false = Barcode
    @State private var verificationData = VerificationData()
    @State private var timeRemaining: TimeInterval = 180 // 3 minutes
    @State private var timer: Timer?
    
    var body: some View {
        ZStack {
            // Front side
            PassportCardFront(user: user, onMenuTap: onMenuTap)
                .opacity(isFlipped ? 0 : 1)
                .rotation3DEffect(
                    .degrees(isFlipped ? 180 : 0),
                    axis: (x: 0, y: 1, z: 0)
                )
            
            // Back side
            PassportCardBack(
                showingQR: $showingQR,
                verificationData: verificationData,
                timeRemaining: timeRemaining
            )
            .opacity(isFlipped ? 1 : 0)
            .rotation3DEffect(
                .degrees(isFlipped ? 0 : -180),
                axis: (x: 0, y: 1, z: 0)
            )
        }
        .frame(width: 360, height: 450)
        .onTapGesture {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                isFlipped.toggle()
                
                // Сбрасываем таймер при перевороте на обратную сторону
                if isFlipped {
                    verificationData = VerificationData()
                    timeRemaining = 180
                }
            }
        }
        .onAppear {
            startTimer()
        }
        .onDisappear {
            timer?.invalidate()
        }
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                // Regenerate code
                verificationData = VerificationData()
                timeRemaining = 180
            }
        }
    }
}

// MARK: - Front Side
struct PassportCardFront: View {
    let user: User
    let onMenuTap: () -> Void
    
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
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(.black)
                                Text("народження:")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(.black)
                                Text(user.birthDate)
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
    }
    
    func loadSignature() -> UIImage? {
        guard let data = UserDefaults.standard.data(forKey: "userSignature") else { return nil }
        return UIImage(data: data)
    }
}

// MARK: - Back Side
struct PassportCardBack: View {
    @Binding var showingQR: Bool
    let verificationData: VerificationData
    let timeRemaining: TimeInterval
    
    var timeString: String {
        let minutes = Int(timeRemaining) / 60
        let seconds = Int(timeRemaining) % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
    
    var body: some View {
        RoundedRectangle(cornerRadius: 32)
            .fill(Color(red: 1.0, green: 1.0, blue: 1.0)) // Чисто белый как фон QR/штрихкода
            .overlay(
                VStack(spacing: 0) {
                    Spacer()
                        .frame(height: 40)
                    
                    // Timer text
                    Text("Код діятиме ще \(timeString) хв")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(.gray)
                        .padding(.bottom, 24)
                    
                    // QR or Barcode
                    if showingQR {
                        if let qrImage = generateQRCode(from: verificationData.url) {
                            Image(uiImage: qrImage)
                                .interpolation(.none)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 250, height: 250)
                        }
                    } else {
                        VStack(spacing: 20) {
                            if let barcodeImage = generateBarcode(from: verificationData.barcodeNumber) {
                                Image(uiImage: barcodeImage)
                                    .interpolation(.none)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 320, height: 100)
                            }
                            
                            Text(verificationData.barcodeFormatted)
                                .font(.system(size: 22, weight: .medium))
                                .foregroundColor(.black)
                                .tracking(5)
                        }
                        .padding(.horizontal, 20)
                    }
                    
                    Spacer()
                    
                    // Toggle buttons
                    HStack(spacing: 40) {
                        Button(action: {
                            withAnimation(.spring(response: 0.3)) {
                                showingQR = true
                            }
                        }) {
                            VStack(spacing: 8) {
                                Circle()
                                    .fill(showingQR ? Color.black : Color.gray.opacity(0.3))
                                    .frame(width: 56, height: 56)
                                    .overlay(
                                        Image(systemName: "qrcode")
                                            .font(.system(size: 24))
                                            .foregroundColor(.white)
                                    )
                                
                                Text("QR-код")
                                    .font(.system(size: 15, weight: .regular))
                                    .foregroundColor(.black)
                            }
                        }
                        
                        Button(action: {
                            withAnimation(.spring(response: 0.3)) {
                                showingQR = false
                            }
                        }) {
                            VStack(spacing: 8) {
                                Circle()
                                    .fill(!showingQR ? Color.black : Color.gray.opacity(0.3))
                                    .frame(width: 56, height: 56)
                                    .overlay(
                                        Image(systemName: "barcode")
                                            .font(.system(size: 24))
                                            .foregroundColor(.white)
                                    )
                                
                                Text("Штрихкод")
                                    .font(.system(size: 15, weight: .regular))
                                    .foregroundColor(.black)
                            }
                        }
                    }
                    .padding(.bottom, 40)
                }
            )
            .frame(width: 360, height: 450)
            .shadow(color: Color.black.opacity(0.1), radius: 20, x: 0, y: 10)
    }
    
    func generateQRCode(from string: String) -> UIImage? {
        let context = CIContext()
        let filter = CIFilter.qrCodeGenerator()
        filter.message = Data(string.utf8)
        filter.correctionLevel = "M"
        
        if let outputImage = filter.outputImage {
            let transform = CGAffineTransform(scaleX: 10, y: 10)
            let scaledImage = outputImage.transformed(by: transform)
            
            if let cgImage = context.createCGImage(scaledImage, from: scaledImage.extent) {
                return UIImage(cgImage: cgImage)
            }
        }
        return nil
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

// MARK: - Verification Data Generator
// MARK: - Marquee Text
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
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "HH:mm | dd.MM.yyyy"
        
        // Використовуємо дату реєстрації з бекенду
        if let registeredAtString = UserDefaults.standard.string(forKey: "registeredAt"),
           let registeredDate = inputFormatter.date(from: registeredAtString) {
            currentDateTime = outputFormatter.string(from: registeredDate)
        } else {
            currentDateTime = outputFormatter.string(from: Date())
        }
    }
}
