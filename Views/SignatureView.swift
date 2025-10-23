import SwiftUI

struct SignatureView: View {
    @EnvironmentObject var authManager: AuthManager
    @State private var paths: [Path] = []
    @State private var currentPath = Path()
    
    var body: some View {
        ZStack {
            AnimatedGradientBackground()
            
            VStack(spacing: 24) {
                Spacer()
                
                Text("Створіть свій підпис")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.black)
                
                // Canvas для малювання
                ZStack {
                    RoundedRectangle(cornerRadius: 24)
                        .fill(Color.white.opacity(0.9))
                        .frame(height: 200)
                    
                    Canvas { context, size in
                        for path in paths {
                            context.stroke(
                                path,
                                with: .color(.black),
                                lineWidth: 3
                            )
                        }
                        context.stroke(
                            currentPath,
                            with: .color(.black),
                            lineWidth: 3
                        )
                    }
                    .frame(height: 200)
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { value in
                                let point = value.location
                                if currentPath.isEmpty {
                                    currentPath.move(to: point)
                                } else {
                                    currentPath.addLine(to: point)
                                }
                            }
                            .onEnded { _ in
                                paths.append(currentPath)
                                currentPath = Path()
                            }
                    )
                }
                .padding(.horizontal, 24)
                
                // Кнопки
                VStack(spacing: 16) {
                    Button(action: {
                        paths.removeAll()
                        currentPath = Path()
                    }) {
                        Text("Спробувати ще раз")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color.white.opacity(0.7))
                                    .background(.ultraThinMaterial)
                            )
                    }
                    
                    Button(action: {
                        saveSignature()
                        authManager.completeSignature()
                    }) {
                        Text("Продовжити")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .background(Color.black)
                            .cornerRadius(16)
                    }
                    .disabled(paths.isEmpty)
                    .opacity(paths.isEmpty ? 0.5 : 1)
                }
                .padding(.horizontal, 24)
                
                Spacer()
            }
        }
    }
    
    func saveSignature() {
        let size = CGSize(width: 300, height: 200)
        let renderer = UIGraphicsImageRenderer(size: size)
        
        let image = renderer.image { ctx in
            // Прозрачный фон
            UIColor.clear.setFill()
            ctx.fill(CGRect(origin: .zero, size: size))
            
            // Рисуем пути
            UIColor.black.setStroke()
            for path in paths {
                let bezierPath = UIBezierPath(cgPath: path.cgPath)
                bezierPath.lineWidth = 3
                bezierPath.stroke()
            }
        }
        
        if let pngData = image.pngData() {
            UserDefaults.standard.set(pngData, forKey: "userSignature")
        }
    }
}

