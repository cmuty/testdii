import SwiftUI

struct AnimatedGradientBackground: View {
    @State private var rotation: Double = 0
    
    let colors: [Color] = [
        Color(hex: "d4a5d4"),
        Color(hex: "f0e0c0"),
        Color(hex: "c0e0a0"),
        Color(hex: "e0d0f0"),
        Color(hex: "d4a5d4")
    ]
    
    var body: some View {
        AngularGradient(
            gradient: Gradient(colors: colors),
            center: .center,
            angle: .degrees(rotation)
        )
        .ignoresSafeArea()
        .onAppear {
            withAnimation(
                .linear(duration: 20)
                .repeatForever(autoreverses: false)
            ) {
                rotation = 360
            }
        }
    }
}

