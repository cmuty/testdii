import SwiftUI

struct SignatureHistoryView: View {
    @Binding var isPresented: Bool
    @State private var signatures: [SignatureEntry] = []
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(hex: "C8E6F5"),
                        Color(hex: "E8F5FC")
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                if signatures.isEmpty {
                    VStack(spacing: 16) {
                        Image(systemName: "doc.text")
                            .font(.system(size: 64, weight: .regular, design: .default))
                            .foregroundColor(.gray.opacity(0.5))
                        
                        Text("Історія підписань порожня")
                            .font(.system(size: 18, weight: .regular, design: .default))
                            .foregroundColor(.gray)
                    }
                } else {
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(signatures.indices.reversed(), id: \.self) { index in
                                SignatureHistoryCard(signature: signatures[index])
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 8)
                        .padding(.bottom, 20)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Історія підписань")
                        .font(.system(size: 17, weight: .regular, design: .default))
                        .foregroundColor(.black)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isPresented = false
                    }) {
                        Text("Готово")
                            .font(.system(size: 17, weight: .regular, design: .default))
                            .foregroundColor(.black)
                    }
                }
            }
        }
        .onAppear {
            loadSignatures()
        }
    }
    
    func loadSignatures() {
        signatures = []
        if let history = UserDefaults.standard.array(forKey: "signatureHistory") as? [[String: Any]] {
            for entry in history {
                if let imageData = entry["image"] as? Data,
                   let dateString = entry["date"] as? String,
                   let uiImage = UIImage(data: imageData) {
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    
                    signatures.append(SignatureEntry(
                        image: uiImage,
                        date: dateFormatter.date(from: dateString) ?? Date()
                    ))
                }
            }
        }
        // Также добавляем текущую подпись, если она есть и истории пуста
        if signatures.isEmpty,
           let currentSignatureData = UserDefaults.standard.data(forKey: "userSignature"),
           let currentSignature = UIImage(data: currentSignatureData) {
            signatures.append(SignatureEntry(
                image: currentSignature,
                date: Date()
            ))
        }
        signatures.sort { $0.date > $1.date }
    }
}

struct SignatureEntry {
    let image: UIImage
    let date: Date
}

struct SignatureHistoryCard: View {
    let signature: SignatureEntry
    
    var body: some View {
        HStack(spacing: 16) {
            // Изображение подписи
            Image(uiImage: signature.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 120, height: 80)
                .background(Color.white.opacity(0.5))
                .cornerRadius(12)
                .padding(.vertical, 8)
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Підпис")
                    .font(.system(size: 18, weight: .regular, design: .default))
                    .foregroundColor(.black)
                
                Text(formatDate(signature.date))
                    .font(.system(size: 15, weight: .regular, design: .default))
                    .foregroundColor(.gray)
                
                Text(formatTime(signature.date))
                    .font(.system(size: 14, weight: .regular, design: .default))
                    .foregroundColor(.gray.opacity(0.8))
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.system(size: 14, weight: .regular, design: .default))
                .foregroundColor(.gray.opacity(0.4))
        }
        .padding(16)
        .background(Color.white.opacity(0.8))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 2)
    }
    
    func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        dateFormatter.locale = Locale(identifier: "uk_UA")
        return dateFormatter.string(from: date)
    }
    
    func formatTime(_ date: Date) -> String {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        timeFormatter.locale = Locale(identifier: "uk_UA")
        return timeFormatter.string(from: date)
    }
}

