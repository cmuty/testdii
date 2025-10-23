import SwiftUI

class GradientManager: ObservableObject {
    static let shared = GradientManager()
    
    @Published var rotation: Double = 0
    
    let colors: [Color] = [
        Color(hex: "6ea8ff"), // Синій
        Color(hex: "ffd966"), // Жовтий
        Color(hex: "ff99cc"), // Рожевий
        Color(hex: "c299ff")  // Бузковий
    ]
    
    private var timer: Timer?
    
    private init() {
        startAnimation()
    }
    
    func startAnimation() {
        timer?.invalidate()
        withAnimation(
            .linear(duration: 8)
            .repeatForever(autoreverses: false)
        ) {
            rotation = 360
        }
    }
}

struct AnimatedGradientBackground: View {
    @ObservedObject private var gradientManager = GradientManager.shared
    
    var body: some View {
        AngularGradient(
            gradient: Gradient(colors: gradientManager.colors),
            center: .center,
            angle: .degrees(gradientManager.rotation)
        )
        .ignoresSafeArea()
    }
}

