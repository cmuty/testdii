import SwiftUI

struct AnimatedGradientBackground: View {
    @State private var animateGradient = false
    
    let colors: [Color] = [
        Color(hex: "d4a5d4"),
        Color(hex: "f0e0c0"),
        Color(hex: "c0e0a0"),
        Color(hex: "e0d0f0")
    ]
    
    var body: some View {
        LinearGradient(
            colors: colors,
            startPoint: animateGradient ? .topLeading : .bottomLeading,
            endPoint: animateGradient ? .bottomTrailing : .topTrailing
        )
        .ignoresSafeArea()
        .onAppear {
            withAnimation(
                .linear(duration: 15)
                .repeatForever(autoreverses: true)
            ) {
                animateGradient.toggle()
            }
        }
    }
}

