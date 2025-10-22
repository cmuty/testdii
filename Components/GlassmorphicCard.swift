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
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(Color.white.opacity(opacity))
                    .background(
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .fill(.ultraThinMaterial)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .stroke(Color.white.opacity(0.3), lineWidth: 1)
                    )
                    .shadow(color: .black.opacity(0.22), radius: 15, x: 0, y: 10)
            )
    }
}

