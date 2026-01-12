import SwiftUI
import CoreImage.CIFilterBuiltins

struct BirthCertificateFullInfoView: View {
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
    
    var fatherData: StaticDataGenerator.ParentData {
        generator.getFatherData(userLastName: user.lastName, userPatronymic: user.patronymic)
    }
    
    var fatherFirstName: String {
        // Извлекаем имя отца из отчества пользователя
        if user.patronymic.hasSuffix("ович") {
            // Убираем "ович" (4 символа) чтобы получить имя отца
            let baseName = String(user.patronymic.dropLast(4))
            return baseName.isEmpty ? "Олег" : baseName
        } else if user.patronymic.hasSuffix("овича") {
            // Убираем "овича" (5 символов)
            let baseName = String(user.patronymic.dropLast(5))
            return baseName.isEmpty ? "Олег" : baseName
        }
        return "Олег"
    }
    
    var motherData: StaticDataGenerator.ParentData {
        generator.getMotherData(userLastName: user.lastName, fatherFirstName: fatherFirstName)
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
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Актовий запис про")
                                    .font(.system(size: 28, weight: .regular, design: .default))
                                Text("моє народження")
                                    .font(.system(size: 28, weight: .regular, design: .default))
                            }
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 8)
                        
                        // Номер запису
                        HStack {
                            Text(generator.getBirthRecordNumber())
                                .font(.system(size: 28, weight: .regular, design: .default))
                            
                            Button(action: {
                                UIPasteboard.general.string = generator.getBirthRecordNumber()
                            }) {
                                Image(systemName: "doc.on.doc")
                                    .font(.system(size: 18))
                                    .foregroundColor(.black)
                            }
                            
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 4)
                        
                        // Бегущая строка
                        BirthCertificateMarqueeTextInfo()
                            .padding(.bottom, 8)
                        
                        // ФИО, Стать, Дата народження, РНОКПП, Місце народження
                        VStack(alignment: .leading, spacing: 16) {
                            // ФИО (слева)
                            VStack(alignment: .leading, spacing: 4) {
                                Text(user.lastName)
                                    .font(.system(size: 22, weight: .regular, design: .default))
                                Text(user.firstName)
                                    .font(.system(size: 22, weight: .regular, design: .default))
                                Text(user.patronymic)
                                    .font(.system(size: 22, weight: .regular, design: .default))
                            }
                            .foregroundColor(.black)
                            
                            // Стать
                            HStack {
                                Text("Стать:")
                                    .font(.system(size: 16, weight: .regular, design: .default))
                                Spacer()
                                Text(generator.getGender())
                                    .font(.system(size: 16, weight: .regular, design: .default))
                            }
                            
                            // Дата народження
                            HStack {
                                Text("Дата народження:")
                                    .font(.system(size: 16, weight: .regular, design: .default))
                                Spacer()
                                Text(user.birthDate)
                                    .font(.system(size: 16, weight: .regular, design: .default))
                            }
                            
                            // РНОКПП
                            HStack {
                                Text("РНОКПП:")
                                    .font(.system(size: 16, weight: .regular, design: .default))
                                Spacer()
                                Text(user.taxId)
                                    .font(.system(size: 16, weight: .regular, design: .default))
                                Button(action: {
                                    UIPasteboard.general.string = user.taxId
                                }) {
                                    Image(systemName: "doc.on.doc")
                                        .font(.system(size: 16))
                                        .foregroundColor(.black)
                                }
                            }
                            
                            // Місце народження
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Місце народження:")
                                    .font(.system(size: 16, weight: .regular, design: .default))
                                Text(user.birthPlace)
                                    .font(.system(size: 15, weight: .regular, design: .default))
                                    .foregroundColor(.black.opacity(0.8))
                                    .padding(.top, 4)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                        }
                        .padding(16)
                        .background(Color.white.opacity(0.6))
                        .cornerRadius(12)
                        .padding(.horizontal, 20)
                        
                        // Інформація про батька
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Інформація про батька")
                                .font(.system(size: 20, weight: .regular, design: .default))
                                .padding(.bottom, 4)
                            
                            // ПІБ
                            HStack {
                                Text("ПІБ:")
                                    .font(.system(size: 16, weight: .regular, design: .default))
                                Spacer()
                                Group {
                                    let nameParts = fatherData.fullName.components(separatedBy: " ")
                                    if nameParts.count >= 3 {
                                        VStack(alignment: .trailing, spacing: 0) {
                                            Text("\(nameParts[0]) \(nameParts[1])")
                                                .font(.system(size: 16, weight: .regular, design: .default))
                                                .foregroundColor(.black.opacity(0.8))
                                            Text(nameParts[2...].joined(separator: " "))
                                                .font(.system(size: 16, weight: .regular, design: .default))
                                                .foregroundColor(.black.opacity(0.8))
                                        }
                                    } else {
                                        Text(fatherData.fullName)
                                            .font(.system(size: 16, weight: .regular, design: .default))
                                            .foregroundColor(.black.opacity(0.8))
                                    }
                                }
                            }
                            
                            // Громадянство
                            HStack {
                                Text("Громадянство:")
                                    .font(.system(size: 16, weight: .regular, design: .default))
                                Spacer()
                                Text("Громадянин України")
                                    .font(.system(size: 16, weight: .regular, design: .default))
                                    .foregroundColor(.black.opacity(0.8))
                            }
                            
                            // РНОКПП батька
                            HStack {
                                Text("РНОКПП:")
                                    .font(.system(size: 16, weight: .regular, design: .default))
                                Spacer()
                                if let fatherRnokpp = fatherData.rnokpp {
                                    Text(fatherRnokpp)
                                        .font(.system(size: 16, weight: .regular, design: .default))
                                        .foregroundColor(.black.opacity(0.8))
                                    Button(action: {
                                        UIPasteboard.general.string = fatherRnokpp
                                    }) {
                                        Image(systemName: "doc.on.doc")
                                            .font(.system(size: 16))
                                            .foregroundColor(.black)
                                    }
                                }
                            }
                            
                            // Дата народження батька
                            HStack {
                                Text("Дата народження:")
                                    .font(.system(size: 16, weight: .regular, design: .default))
                                Spacer()
                                Text(fatherData.birthDate)
                                    .font(.system(size: 16, weight: .regular, design: .default))
                                    .foregroundColor(.black.opacity(0.8))
                            }
                        }
                        .padding(16)
                        .background(Color.white.opacity(0.6))
                        .cornerRadius(12)
                        .padding(.horizontal, 20)
                        
                        // Інформація про матір
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Інформація про матір")
                                .font(.system(size: 20, weight: .regular, design: .default))
                                .padding(.bottom, 4)
                            
                            // ПІБ (формат: ПІБ: Прізвище Ім'я\nПо батькові)
                            HStack {
                                Text("ПІБ:")
                                    .font(.system(size: 16, weight: .regular, design: .default))
                                Spacer()
                                Group {
                                    let nameParts = motherData.fullName.components(separatedBy: " ")
                                    if nameParts.count >= 3 {
                                        VStack(alignment: .trailing, spacing: 0) {
                                            Text("\(nameParts[0]) \(nameParts[1])")
                                                .font(.system(size: 16, weight: .regular, design: .default))
                                                .foregroundColor(.black.opacity(0.8))
                                            Text(nameParts[2...].joined(separator: " "))
                                                .font(.system(size: 16, weight: .regular, design: .default))
                                                .foregroundColor(.black.opacity(0.8))
                                        }
                                    } else {
                                        Text(motherData.fullName)
                                            .font(.system(size: 16, weight: .regular, design: .default))
                                            .foregroundColor(.black.opacity(0.8))
                                    }
                                }
                            }
                            
                            // Громадянство
                            HStack {
                                Text("Громадянство:")
                                    .font(.system(size: 16, weight: .regular, design: .default))
                                Spacer()
                                Text("Громадянка України")
                                    .font(.system(size: 16, weight: .regular, design: .default))
                                    .foregroundColor(.black.opacity(0.8))
                            }
                            
                            // Дата народження матері
                            HStack {
                                Text("Дата народження:")
                                    .font(.system(size: 16, weight: .regular, design: .default))
                                Spacer()
                                Text(motherData.birthDate)
                                    .font(.system(size: 16, weight: .regular, design: .default))
                                    .foregroundColor(.black.opacity(0.8))
                            }
                        }
                        .padding(16)
                        .background(Color.white.opacity(0.6))
                        .cornerRadius(12)
                        .padding(.horizontal, 20)
                        
                        // Актовий запис
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Актовий запис")
                                .font(.system(size: 20, weight: .regular, design: .default))
                                .padding(.bottom, 4)
                            
                            // Номер запису
                            HStack {
                                Text("Номер запису:")
                                    .font(.system(size: 16, weight: .regular, design: .default))
                                Spacer()
                                Text(generator.getBirthRecordNumber())
                                    .font(.system(size: 16, weight: .regular, design: .default))
                                Button(action: {
                                    UIPasteboard.general.string = generator.getBirthRecordNumber()
                                }) {
                                    Image(systemName: "doc.on.doc")
                                        .font(.system(size: 16))
                                        .foregroundColor(.black)
                                }
                            }
                            
                            // Орган державної реєстрації
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Орган державної реєстрації актів цивільного стану, що склав актовий запис:")
                                    .font(.system(size: 16, weight: .regular, design: .default))
                                Text("Відділ реєстрації актів цивільного стану")
                                    .font(.system(size: 15, weight: .regular, design: .default))
                                    .foregroundColor(.black.opacity(0.8))
                                    .padding(.top, 4)
                                Text(generator.getRegistrationBody())
                                    .font(.system(size: 15, weight: .regular, design: .default))
                                    .foregroundColor(.black.opacity(0.8))
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            
                            // Дата складання
                            HStack {
                                Text("Дата складання:")
                                    .font(.system(size: 16, weight: .regular, design: .default))
                                Spacer()
                                Text(generator.getCompilationDate(birthDate: user.birthDate))
                                    .font(.system(size: 16, weight: .regular, design: .default))
                            }
                        }
                        .padding(16)
                        .background(Color.white.opacity(0.6))
                        .cornerRadius(12)
                        .padding(.horizontal, 20)
                        
                        // Видані свідоцтва (особый формат)
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Видані свідоцтва")
                                .font(.system(size: 20, weight: .regular, design: .default))
                            
                            // Номер свідоцтва (маленький шрифт для label)
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Номер свідоцтва:")
                                    .font(.system(size: 14, weight: .regular, design: .default))
                                
                                HStack {
                                    Text(generator.getCertificateNumber())
                                        .font(.system(size: 24, weight: .regular, design: .default))
                                    Spacer()
                                    Button(action: {
                                        UIPasteboard.general.string = generator.getCertificateNumber()
                                    }) {
                                        Image(systemName: "doc.on.doc")
                                            .font(.system(size: 16))
                                            .foregroundColor(.black)
                                    }
                                }
                            }
                            
                            // Дата видачі
                            HStack {
                                Text("Дата видачі:")
                                    .font(.system(size: 14, weight: .regular, design: .default))
                                Spacer()
                                Text(generator.getIssueDate(birthDate: user.birthDate))
                                    .font(.system(size: 16, weight: .regular, design: .default))
                            }
                        }
                        .padding(16)
                        .background(Color.white.opacity(0.6))
                        .cornerRadius(12)
                        .padding(.horizontal, 20)
                        
                        // QR/Barcode Card with toggle
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
                        .background(Color(red: 1.0, green: 1.0, blue: 1.0))
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

// Бегущая строка для полной информации
struct BirthCertificateMarqueeTextInfo: View {
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

#Preview {
    BirthCertificateFullInfoView(
        isPresented: .constant(true),
        user: User.mock
    )
}
