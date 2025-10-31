import SwiftUI
import CoreImage.CIFilterBuiltins

struct BirthCertificateFullInfoView: View {
    @Binding var isPresented: Bool
    let user: User
    @State private var currentTime: String = ""
    
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
                                Text("Актовий зазпис про")
                                    .font(.system(size: 28, weight: .regular, design: .default))
                                Text("моє народження")
                                    .font(.system(size: 28, weight: .regular, design: .default))
                            }
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 8)
                        
                        // Подзаголовок
                        HStack {
                            Text("Свидоцтва про народження")
                                .font(.system(size: 20, weight: .regular, design: .default))
                                .foregroundColor(.black.opacity(0.7))
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                        
                        // Бегущая строка
                        BirthCertificateMarqueeTextInfo(currentTime: currentTime)
                            .padding(.bottom, 8)
                        
                        // ФИО Card
                        VStack(alignment: .leading, spacing: 16) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(user.lastName)
                                    .font(.system(size: 22, weight: .regular, design: .default))
                                Text(user.firstName)
                                    .font(.system(size: 22, weight: .regular, design: .default))
                                Text(user.patronymic)
                                    .font(.system(size: 22, weight: .regular, design: .default))
                            }
                            .foregroundColor(.black)
                        }
                        .padding(20)
                        .background(Color.white.opacity(0.6))
                        .cornerRadius(12)
                        .padding(.horizontal, 20)
                        
                        // Дата народження
                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                VStack(alignment: .leading, spacing: 2) {
                                    Text("Дата народження:")
                                        .font(.system(size: 16, weight: .regular, design: .default))
                                    Text("Date of birth")
                                        .font(.system(size: 14, weight: .regular, design: .default))
                                        .foregroundColor(.gray)
                                }
                                
                                Spacer()
                                
                                Text(user.birthDate)
                                    .font(.system(size: 16, weight: .regular, design: .default))
                            }
                            
                            Divider()
                                .padding(.vertical, 4)
                            
                            // Місце народження
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Місце народження:")
                                    .font(.system(size: 16, weight: .regular, design: .default))
                                Text("Place of birth")
                                    .font(.system(size: 14, weight: .regular, design: .default))
                                    .foregroundColor(.gray)
                                Text(user.birthPlace)
                                    .font(.system(size: 15, weight: .regular, design: .default))
                                    .foregroundColor(.black.opacity(0.8))
                                    .padding(.top, 4)
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
        .onAppear {
            updateTime()
        }
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
    let currentTime: String
    
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
    BirthCertificateFullInfoView(
        isPresented: .constant(true),
        user: User.mock
    )
}

