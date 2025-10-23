import SwiftUI
import CoreImage.CIFilterBuiltins

struct DocumentFullInfoView: View {
    @Binding var isPresented: Bool
    let user: User
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(UIColor.systemGroupedBackground)
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 16) {
                        // Title
                        HStack {
                            Text("єДокумент")
                                .font(.system(size: 34, weight: .regular, design: .default))
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 8)
                        
                        // Бегущая строка
                        MarqueeTextInfo()
                            .padding(.bottom, 8)
                        
                        // ФИО Card
                        VStack(alignment: .leading, spacing: 12) {
                            HStack(alignment: .top, spacing: 16) {
                                // Photo
                                if let photoData = UserDefaults.standard.data(forKey: "userPhoto"),
                                   let uiImage = UIImage(data: photoData) {
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 100, height: 130)
                                        .clipShape(RoundedRectangle(cornerRadius: 12))
                                } else {
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color.gray.opacity(0.2))
                                        .frame(width: 100, height: 130)
                                }
                                
                                VStack(alignment: .leading, spacing: 16) {
                                    // Ukrainian name
                                    VStack(alignment: .leading, spacing: 2) {
                                        Text(user.lastName + " " + user.firstName)
                                            .font(.system(size: 18, weight: .regular))
                                        Text(user.patronymic)
                                            .font(.system(size: 18, weight: .regular))
                                        
                                        Text(transliterate(user.lastName) + " " + transliterate(user.firstName))
                                            .font(.system(size: 16, weight: .regular))
                                            .foregroundColor(.black)
                                            .padding(.top, 4)
                                    }
                                    
                                    // Birth date
                                    VStack(alignment: .leading, spacing: 2) {
                                        Text("Дата")
                                            .font(.system(size: 14, weight: .regular))
                                        Text("народження:")
                                            .font(.system(size: 14, weight: .regular))
                                        Text("Date of birth")
                                            .font(.system(size: 13, weight: .regular))
                                            .foregroundColor(.gray)
                                        Text(user.birthDate)
                                            .font(.system(size: 14, weight: .medium))
                                    }
                                }
                            }
                        }
                        .padding(16)
                        .background(Color.white.opacity(0.6))
                        .cornerRadius(12)
                        .padding(.horizontal, 20)
                        
                        // Sex Card
                        VStack(spacing: 0) {
                            HStack {
                                VStack(alignment: .leading, spacing: 2) {
                                    Text("Стать:")
                                        .font(.system(size: 16, weight: .regular))
                                    Text("Sex")
                                        .font(.system(size: 14, weight: .regular))
                                        .foregroundColor(.gray)
                                }
                                
                                Spacer()
                                
                                VStack(alignment: .trailing, spacing: 2) {
                                    Text("Ч")
                                        .font(.system(size: 16, weight: .regular))
                                    Text("M")
                                        .font(.system(size: 14, weight: .regular))
                                        .foregroundColor(.gray)
                                }
                            }
                            .padding(16)
                        }
                        .background(Color.white.opacity(0.6))
                        .cornerRadius(12)
                        .padding(.horizontal, 20)
                        
                        // РНОКПП Card
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Text("РНОКПП (ІПН):")
                                    .font(.system(size: 16, weight: .regular))
                                
                                Spacer()
                                
                                Text(user.taxId)
                                    .font(.system(size: 16, weight: .medium))
                                
                                Button(action: {
                                    UIPasteboard.general.string = user.taxId
                                }) {
                                    Image(systemName: "doc.on.doc")
                                        .font(.system(size: 16))
                                        .foregroundColor(.black)
                                }
                            }
                            
                            Divider()
                                .padding(.vertical, 4)
                            
                            Text("Документ, що посвідчує особу:")
                                .font(.system(size: 15, weight: .regular))
                                .foregroundColor(.black)
                            
                            Text("Паспорт громадянина України")
                                .font(.system(size: 15, weight: .regular))
                            
                            Text(generatePassportNumber())
                                .font(.system(size: 15, weight: .regular))
                        }
                        .padding(16)
                        .background(Color.white.opacity(0.6))
                        .cornerRadius(12)
                        .padding(.horizontal, 20)
                        
                        // Address Card
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Місце проживання зазначене в банку:")
                                .font(.system(size: 15, weight: .medium))
                            
                            Text("Україна, область Харківська, місто Харків, провулок Білостоцький, буд 47")
                                .font(.system(size: 15, weight: .regular))
                                .foregroundColor(.black.opacity(0.8))
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
    
    private func generatePassportNumber() -> String {
        let numbers = [0, 1, 2, 3]
        var result = ""
        for _ in 0..<9 {
            result += String(numbers.randomElement() ?? 0)
        }
        return result
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
        let url = "https://diia.app/documents/internal-passport/\(datePart)/verify/\(verifyPart)"
        
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
struct MarqueeTextInfo: View {
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
                            Animation.linear(duration: 30)
                                .repeatForever(autoreverses: false)
                        ) {
                            offset = -textWidth
                        }
                    }
            }
        }
        .frame(height: 32)
        .cornerRadius(8)
        .padding(.horizontal, 20)
        .clipped()
    }
}

#Preview {
    DocumentFullInfoView(
        isPresented: .constant(true),
        user: User.mock
    )
}

