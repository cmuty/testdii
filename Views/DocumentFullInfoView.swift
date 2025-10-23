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
                                .font(.system(size: 28, weight: .regular, design: .default))
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 8)
                        
                        // Бегущая строка (на всю ширину)
                        MarqueeTextInfo()
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
                                
                                Spacer()
                            }
                        }
                        .padding(20)
                        .background(Color.white.opacity(0.6))
                        .cornerRadius(12)
                        .padding(.horizontal, 20)
                        
                        // Объединенная карточка: Стать + РНОКПП + Документ
                        VStack(alignment: .leading, spacing: 12) {
                            // Стать
                            HStack {
                                VStack(alignment: .leading, spacing: 2) {
                                    Text("Стать:")
                                        .font(.system(size: 16, weight: .regular, design: .default))
                                    Text("Sex")
                                        .font(.system(size: 14, weight: .regular, design: .default))
                                        .foregroundColor(.gray)
                                }
                                
                                Spacer()
                                
                                VStack(alignment: .center, spacing: 2) {
                                    Text("Ч")
                                        .font(.system(size: 16, weight: .regular, design: .default))
                                    Text("M")
                                        .font(.system(size: 14, weight: .regular, design: .default))
                                        .foregroundColor(.gray)
                                }
                                .frame(maxWidth: .infinity)
                            }
                            
                            Divider()
                                .padding(.vertical, 4)
                            
                            // РНОКПП
                            HStack {
                                Text("РНОКПП (ІПН):")
                                    .font(.system(size: 16, weight: .regular, design: .default))
                                
                                Spacer()
                                
                                Text(user.taxId)
                                    .font(.system(size: 14, weight: .regular, design: .default))
                                
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
                            
                            // Документ
                            VStack(alignment: .leading, spacing: 6) {
                                Text("Документ, що посвідчує особу:")
                                    .font(.system(size: 15, weight: .regular, design: .default))
                                    .foregroundColor(.black)
                                
                                Text("Паспорт громадянина України")
                                    .font(.system(size: 15, weight: .regular, design: .default))
                                
                                Text(generatePassportNumber())
                                    .font(.system(size: 15, weight: .regular, design: .default))
                            }
                        }
                        .padding(16)
                        .background(Color.white.opacity(0.6))
                        .cornerRadius(12)
                        .padding(.horizontal, 20)
                        
                        // Address Card
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Місце проживання зазначене в банку:")
                                .font(.system(size: 15, weight: .regular, design: .default))
                            
                            Text("Україна, область Харківська, місто Харків, провулок Білостоцький, буд 47")
                                .font(.system(size: 15, weight: .regular, design: .default))
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
}

#Preview {
    DocumentFullInfoView(
        isPresented: .constant(true),
        user: User.mock
    )
}

