import SwiftUI
import CoreImage.CIFilterBuiltins

struct BirthCertificateFullInfoView: View {
    @Binding var isPresented: Bool
    let user: User
    
    private let generator = StaticDataGenerator.shared
    
    var fatherData: StaticDataGenerator.ParentData {
        generator.getFatherData()
    }
    
    var motherData: StaticDataGenerator.ParentData {
        generator.getMotherData()
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
                            VStack(alignment: .leading, spacing: 4) {
                                Text("ПІБ:")
                                    .font(.system(size: 16, weight: .regular, design: .default))
                                Group {
                                    let nameParts = motherData.fullName.components(separatedBy: " ")
                                    if nameParts.count >= 3 {
                                        Text("\(nameParts[0]) \(nameParts[1])")
                                            .font(.system(size: 16, weight: .regular, design: .default))
                                            .foregroundColor(.black.opacity(0.8))
                                        Text(nameParts[2...].joined(separator: " "))
                                            .font(.system(size: 16, weight: .regular, design: .default))
                                            .foregroundColor(.black.opacity(0.8))
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
                        
                        // QR Code Card
                        VStack(spacing: 16) {
                            if let qrImage = generateStaticQRCode() {
                                Image(uiImage: qrImage)
                                    .interpolation(.none)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 280, height: 280)
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
    }
    
    private func generateStaticQRCode() -> UIImage? {
        // Генерируем URL для QR
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let dateString = dateFormatter.string(from: Date())
        
        let randomNum = Int.random(in: 10000...99999)
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let fullDate = dateFormatter.string(from: Date())
        
        let datePart = "\(dateString)-\(randomNum)-\(fullDate)"
        let verifyPart = UUID().uuidString.lowercased()
        let url = "https://diia.app/documents/birth-certificate/\(datePart)/verify/\(verifyPart)"
        
        let context = CIContext()
        let filter = CIFilter.qrCodeGenerator()
        filter.message = Data(url.utf8)
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
