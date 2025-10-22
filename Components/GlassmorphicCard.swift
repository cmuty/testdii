import SwiftUI

struct GlassmorphicCard<Content: View>: View {
    let content: Content
    let cornerRadius: CGFloat
    let opacity: Double
    
    init(
        cornerRadius: CGFloat = 28,
        opacity: Double = 0.4,
        @ViewBuilder content: () -> Content
    ) {
        self.cornerRadius = cornerRadius
        self.opacity = opacity
        self.content = content()
    }
    
    var body: some View {
        content
            .background(
                ZStack {
                    // Основний glassmorphic фон
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(.ultraThinMaterial.opacity(0.6))
                    
                    // Білий напівпрозорий шар
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(Color.white.opacity(opacity))
                    
                    // Дзеркальний блиск (градієнт зверху)
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(
                            LinearGradient(
                                colors: [
                                    Color.white.opacity(0.4),
                                    Color.white.opacity(0.1),
                                    Color.clear
                                ],
                                startPoint: .top,
                                endPoint: .center
                            )
                        )
                }
                .overlay(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(
                            LinearGradient(
                                colors: [
                                    Color.white.opacity(0.6),
                                    Color.white.opacity(0.2)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 1.5
                        )
                )
                .shadow(color: .black.opacity(0.15), radius: 20, x: 0, y: 10)
                .shadow(color: .white.opacity(0.5), radius: 5, x: 0, y: -2)
            )
    }
}

