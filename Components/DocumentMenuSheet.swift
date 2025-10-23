import SwiftUI

struct DocumentMenuSheet: View {
    @Binding var isPresented: Bool
    let documentName: String
    
    var body: some View {
        ZStack {
            // Blur background
            if isPresented {
                BlurView(style: .systemUltraThinMaterialDark)
                    .ignoresSafeArea()
                    .transition(.opacity)
                    .onTapGesture {
                        withAnimation(.spring(response: 0.3)) {
                            isPresented = false
                        }
                    }
                
                VStack {
                    Spacer()
                    
                    // Menu container
                    VStack(spacing: 0) {
                        // Menu items
                        VStack(spacing: 0) {
                            DocumentMenuItem(
                                icon: "doc.text",
                                title: "Повна інформація"
                            ) {
                                print("Повна інформація")
                                isPresented = false
                            }
                            
                            Divider()
                                .padding(.leading, 60)
                            
                            DocumentMenuItem(
                                icon: "qrcode",
                                title: "Код для перевірки"
                            ) {
                                print("Код для перевірки")
                                isPresented = false
                            }
                            
                            Divider()
                                .padding(.leading, 60)
                            
                            DocumentMenuItem(
                                icon: "arrow.up.arrow.down",
                                title: "Змінити порядок документів"
                            ) {
                                print("Змінити порядок документів")
                                isPresented = false
                            }
                            
                            Divider()
                                .padding(.leading, 60)
                            
                            DocumentMenuItem(
                                icon: "star",
                                title: "Оцінити документ"
                            ) {
                                print("Оцінити документ")
                                isPresented = false
                            }
                            
                            Divider()
                                .padding(.leading, 60)
                            
                            DocumentMenuItem(
                                icon: "questionmark.circle",
                                title: "Питання та відповіді"
                            ) {
                                print("Питання та відповіді")
                                isPresented = false
                            }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.white)
                        )
                        .padding(.horizontal, 20)
                        
                        // Close button
                        Button(action: {
                            withAnimation(.spring(response: 0.3)) {
                                isPresented = false
                            }
                        }) {
                            Text("Закрити")
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity)
                                .frame(height: 56)
                                .background(
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(Color.white)
                                )
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 12)
                        .padding(.bottom, 34)
                    }
                }
                .transition(.move(edge: .bottom))
            }
        }
        .animation(.spring(response: 0.3, dampingFraction: 0.8), value: isPresented)
    }
}

struct DocumentMenuItem: View {
    let icon: String
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                Image(systemName: icon)
                    .font(.system(size: 22))
                    .foregroundColor(.black)
                    .frame(width: 28)
                
                Text(title)
                    .font(.system(size: 17, weight: .regular))
                    .foregroundColor(.black)
                
                Spacer()
            }
            .padding(.horizontal, 20)
            .frame(height: 56)
            .contentShape(Rectangle())
        }
    }
}

// MARK: - Blur View (UIKit wrapper)
struct BlurView: UIViewRepresentable {
    let style: UIBlurEffect.Style
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: style))
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}

#Preview {
    ZStack {
        Color.gray.ignoresSafeArea()
        
        DocumentMenuSheet(
            isPresented: .constant(true),
            documentName: "Паспорт"
        )
    }
}

