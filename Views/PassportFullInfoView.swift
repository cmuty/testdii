import SwiftUI
import CoreImage.CIFilterBuiltins

struct PassportFullInfoView: View {
    @Binding var isPresented: Bool
    let user: User
    @State private var verificationData = VerificationData()
    @State private var timeRemaining: TimeInterval = 180
    @State private var timer: Timer?
    @State private var showingQR = true
    
    private let generator = StaticDataGenerator.shared
    
    var timeString: String {
        let minutes = Int(timeRemaining) / 60
        let seconds = Int(timeRemaining) % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(UIColor.systemGroupedBackground)
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 16) {
                        // Title
                        HStack {
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Паспорт громадянина")
                                    .font(.system(size: 28, weight: .regular, design: .default))
                                Text("України")
                                    .font(.system(size: 28, weight: .regular, design: .default))
                            }
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 8)
                        
                        // Passport number with copy button
                        HStack {
                            Text(generator.getPassportNumber())
                                .font(.system(size: 36, weight: .medium))
                            
                            Button(action: {
                                UIPasteboard.general.string = generator.getPassportNumber()
                            }) {
                                Image(systemName: "doc.on.doc")
                                    .font(.system(size: 20))
                                    .foregroundColor(.black)
                            }
                            
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 4)
                        
                        // Бегущая строка
                        PassportMarqueeTextInfo()
                            .padding(.bottom, 8)
                        
                        // ФИО Card (увеличенная)
                        VStack(alignment: .leading, spacing: 16) {
                            // ФИО над фото
                            VStack(alignment: .leading, spacing: 4) {
                                Text(user.lastName + " " + user.firstName)
                                    .font(.system(size: 22, weight: .regular, design: .default))
                                Text(user.patronymic)
                                    .font(.system(size: 22, weight: .regular, design: .default))
                                
                                Text(transliterate(user.firstName) + " " + transliterate(user.lastName))
                                    .font(.system(size: 18, weight: .regular, design: .default))
                                    .foregroundColor(.black.opacity(0.7))
                                    .padding(.top, 4)
                            }
                            
                            HStack(alignment: .top, spacing: 20) {
                                // Photo (увеличенное)
                                if let photoData = UserDefaults.standard.data(forKey: "userPhoto"),
                                   let uiImage = UIImage(data: photoData) {
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 140, height: 180)
                                        .clipShape(RoundedRectangle(cornerRadius: 12))
                                } else {
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color.gray.opacity(0.2))
                                        .frame(width: 140, height: 180)
                                }
                                
                                VStack(alignment: .leading, spacing: 16) {
                                    // Birth date справа от фото
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text("Дата")
                                            .font(.system(size: 16, weight: .regular, design: .default))
                                        Text("народження:")
                                            .font(.system(size: 16, weight: .regular, design: .default))
                                        Text("Date of birth")
                                            .font(.system(size: 14, weight: .regular, design: .default))
                                            .foregroundColor(.gray)
                                        Text(user.birthDate)
                                            .font(.system(size: 16, weight: .regular, design: .default))
                                            .padding(.top, 4)
                                    }
                                    
                                    // Signature
                                    if let signature = loadSignature() {
                                        Image(uiImage: signature)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 100, height: 40)
                                    }
                                }
                                
                                Spacer()
                            }
                        }
                        .padding(20)
                        .background(Color.white.opacity(0.6))
                        .cornerRadius(12)
                        .padding(.horizontal, 20)
                        
                        // Стать + Громадянство карточка
                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                VStack(alignment: .leading, spacing: 2) {
                                    Text("Стать:")
                                        .font(.system(size: 16, weight: .regular, design: .default))
                                    Text("Sex")
                                        .font(.system(size: 14, weight: .regular, design: .default))
                                        .foregroundColor(.gray)
                                }
                                
                                Spacer()
                                
                                VStack(alignment: .trailing, spacing: 2) {
                                    Text("Ч")
                                        .font(.system(size: 16, weight: .regular, design: .default))
                                    Text("M")
                                        .font(.system(size: 14, weight: .regular, design: .default))
                                        .foregroundColor(.gray)
                                }
                            }
                            
                            Divider()
                                .padding(.vertical, 4)
                            
                            HStack {
                                VStack(alignment: .leading, spacing: 2) {
                                    Text("Громадянство:")
                                        .font(.system(size: 16, weight: .regular, design: .default))
                                    Text("Nationality")
                                        .font(.system(size: 14, weight: .regular, design: .default))
                                        .foregroundColor(.gray)
                                }
                                
                                Spacer()
                                
                                VStack(alignment: .trailing, spacing: 2) {
                                    Text("Україна")
                                        .font(.system(size: 16, weight: .regular, design: .default))
                                    Text("Ukraine")
                                        .font(.system(size: 14, weight: .regular, design: .default))
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                        .padding(16)
                        .background(Color.white.opacity(0.6))
                        .cornerRadius(12)
                        .padding(.horizontal, 20)
                        
                        // Дата выдачи + орган
                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                VStack(alignment: .leading, spacing: 2) {
                                    Text("Дата видачі:")
                                        .font(.system(size: 16, weight: .regular, design: .default))
                                    Text("Date of issue")
                                        .font(.system(size: 14, weight: .regular, design: .default))
                                        .foregroundColor(.gray)
                                }
                                
                                Spacer()
                                
                                Text(generator.getPassportIssueDate(birthDate: user.birthDate))
                                    .font(.system(size: 16, weight: .regular, design: .default))
                            }
                            
                            Divider()
                                .padding(.vertical, 4)
                            
                            HStack {
                                VStack(alignment: .leading, spacing: 2) {
                                    Text("Дійсний до:")
                                        .font(.system(size: 16, weight: .regular, design: .default))
                                    Text("Date of expiry")
                                        .font(.system(size: 14, weight: .regular, design: .default))
                                        .foregroundColor(.gray)
                                }
                                
                                Spacer()
                                
                                Text(generator.getPassportExpiryDate(issueDate: generator.getPassportIssueDate(birthDate: user.birthDate)))
                                    .font(.system(size: 16, weight: .regular, design: .default))
                            }
                            
                            Divider()
                                .padding(.vertical, 4)
                            
                            HStack {
                                VStack(alignment: .leading, spacing: 2) {
                                    Text("Орган, що видав:")
                                        .font(.system(size: 16, weight: .regular, design: .default))
                                    Text("Authority")
                                        .font(.system(size: 14, weight: .regular, design: .default))
                                        .foregroundColor(.gray)
                                }
                                
                                Spacer()
                                
                                Text(generator.getIssuingAuthority())
                                    .font(.system(size: 16, weight: .regular, design: .default))
                            }
                        }
                        .padding(16)
                        .background(Color.white.opacity(0.6))
                        .cornerRadius(12)
                        .padding(.horizontal, 20)
                        
                        // РНОКПП карточка
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Text("РНОКПП (ІПН):")
                                    .font(.system(size: 16, weight: .regular, design: .default))
                                
                                Spacer()
                                
                                Text(generator.getRNOKPP())
                                    .font(.system(size: 14, weight: .regular, design: .default))
                                
                                Button(action: {
                                    UIPasteboard.general.string = generator.getRNOKPP()
                                }) {
                                    Image(systemName: "doc.on.doc")
                                        .font(.system(size: 16))
                                        .foregroundColor(.black)
                                }
                            }
                            
                            Text("Individual Tax Number")
                                .font(.system(size: 14, weight: .regular, design: .default))
                                .foregroundColor(.gray)
                            
                            Text("Пройшов перевірку Державною податковою")
                                .font(.system(size: 15, weight: .regular, design: .default))
                            
                            Text("службою \(formatRegisteredDate())")
                                .font(.system(size: 15, weight: .regular, design: .default))
                            
                            Text("Verified by State Tax Service on \(formatRegisteredDate())")
                                .font(.system(size: 14, weight: .regular, design: .default))
                                .foregroundColor(.gray)
                        }
                        .padding(16)
                        .background(Color.white.opacity(0.6))
                        .cornerRadius(12)
                        .padding(.horizontal, 20)
                        
                        // Запис + місце народження + проживання
                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                VStack(alignment: .leading, spacing: 2) {
                                    Text("Запис № (УНЗР):")
                                        .font(.system(size: 16, weight: .regular, design: .default))
                                    Text("Record No.")
                                        .font(.system(size: 14, weight: .regular, design: .default))
                                        .foregroundColor(.gray)
                                }
                                
                                Spacer()
                                
                                Text(generator.getUNZR(birthDate: user.birthDate))
                                    .font(.system(size: 14, weight: .regular, design: .default))
                                
                                Button(action: {
                                    UIPasteboard.general.string = generator.getUNZR(birthDate: user.birthDate)
                                }) {
                                    Image(systemName: "doc.on.doc")
                                        .font(.system(size: 16))
                                        .foregroundColor(.black)
                                }
                            }
                            
                            Divider()
                                .padding(.vertical, 4)
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Місце народження:")
                                    .font(.system(size: 16, weight: .regular, design: .default))
                                Text("Place of birth")
                                    .font(.system(size: 14, weight: .regular, design: .default))
                                    .foregroundColor(.gray)
                                Text("М. ХАРКІВ ХАРКІВСЬКА")
                                    .font(.system(size: 15, weight: .regular, design: .default))
                                Text("ОБЛАСТЬ УКРАЇНА")
                                    .font(.system(size: 15, weight: .regular, design: .default))
                            }
                            
                            Divider()
                                .padding(.vertical, 4)
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Місце проживання:")
                                    .font(.system(size: 16, weight: .regular, design: .default))
                                Text("Legal address")
                                    .font(.system(size: 14, weight: .regular, design: .default))
                                    .foregroundColor(.gray)
                                Text("УКРАЇНА ХАРКІВСЬКА ОБЛАСТЬ")
                                    .font(.system(size: 15, weight: .regular, design: .default))
                                Text("ХАРКІВСЬКИЙ РАЙОН М. ХАРКІВ")
                                    .font(.system(size: 15, weight: .regular, design: .default))
                                Text("ПРОВ. БІЛОСТОЦЬКИЙ БУД 47")
                                    .font(.system(size: 15, weight: .regular, design: .default))
                            }
                            
                            Divider()
                                .padding(.vertical, 4)
                            
                            HStack {
                                VStack(alignment: .leading, spacing: 2) {
                                    Text("Дата реєстрації:")
                                        .font(.system(size: 16, weight: .regular, design: .default))
                                    Text("Registered on")
                                        .font(.system(size: 14, weight: .regular, design: .default))
                                        .foregroundColor(.gray)
                                }
                                
                                Spacer()
                                
                                Text(generator.getRegistrationDate(birthDate: user.birthDate))
                                    .font(.system(size: 16, weight: .regular, design: .default))
                            }
                        }
                        .padding(16)
                        .background(Color.white.opacity(0.6))
                        .cornerRadius(12)
                        .padding(.horizontal, 20)
                        
                        // QR Code Card
                        VStack(spacing: 16) {
                            Text("Код діятиме ще \(timeString) хв")
                                .font(.system(size: 16, weight: .regular))
                                .foregroundColor(.gray)
                            
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
                            }
                            
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
                        }
                        .padding(24)
                        .background(Color.white.opacity(0.6))
                        .cornerRadius(12)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 40)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    RoundedRectangle(cornerRadius: 3)
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 36, height: 5)
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
                verificationData = VerificationData()
                timeRemaining = 180
            }
        }
    }
    
    private func transliterate(_ text: String) -> String {
        let transliterationMap: [Character: String] = [
            "А": "A", "Б": "B", "В": "V", "Г": "H", "Ґ": "G", "Д": "D", "Е": "E", "Є": "Ye",
            "Ж": "Zh", "З": "Z", "И": "Y", "І": "I", "Ї": "Yi", "Й": "Y", "К": "K", "Л": "L",
            "М": "M", "Н": "N", "О": "O", "П": "P", "Р": "R", "С": "S", "Т": "T", "У": "U",
            "Ф": "F", "Х": "Kh", "Ц": "Ts", "Ч": "Ch", "Ш": "Sh", "Щ": "Shch", "Ь": "", "Ю": "Yu",
            "Я": "Ya", "а": "a", "б": "b", "в": "v", "г": "h", "ґ": "g", "д": "d", "е": "e",
            "є": "ie", "ж": "zh", "з": "z", "и": "y", "і": "i", "ї": "i", "й": "i", "к": "k",
            "л": "l", "м": "m", "н": "n", "о": "o", "п": "p", "р": "r", "с": "s", "т": "t",
            "у": "u", "ф": "f", "х": "kh", "ц": "ts", "ч": "ch", "ш": "sh", "щ": "shch", "ь": "",
            "ю": "iu", "я": "ia"
        ]
        
        return text.map { transliterationMap[$0] ?? String($0) }.joined()
    }
    
    func loadSignature() -> UIImage? {
        guard let data = UserDefaults.standard.data(forKey: "userSignature") else { return nil }
        return UIImage(data: data)
    }
    
    private func formatRegisteredDate() -> String {
        guard let registeredAtString = UserDefaults.standard.string(forKey: "registeredAt") else {
            return "22.10.2025"
        }
        
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "dd.MM.yyyy"
        
        if let date = inputFormatter.date(from: registeredAtString) {
            return outputFormatter.string(from: date)
        }
        
        return "22.10.2025"
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

// Бегущая строка для паспорта
struct PassportMarqueeTextInfo: View {
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
                            Animation.linear(duration: 50)
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
    
    private func updateTime() {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "HH:mm | dd.MM.yyyy"
        outputFormatter.locale = Locale(identifier: "uk_UA")
        
        if let registeredAtString = UserDefaults.standard.string(forKey: "registeredAt"),
           let registeredDate = inputFormatter.date(from: registeredAtString) {
            currentTime = outputFormatter.string(from: registeredDate)
        } else {
            currentTime = outputFormatter.string(from: Date())
        }
    }
}

#Preview {
    PassportFullInfoView(
        isPresented: .constant(true),
        user: User.mock
    )
}

