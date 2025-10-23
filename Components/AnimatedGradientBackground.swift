import SwiftUI

class GradientManager: ObservableObject {
    static let shared = GradientManager()
    
    @Published var colorIndex = 0
    
    let colorSets: [[Color]] = [
        [
            Color(hex: "6ea8ff"), // Синій
            Color(hex: "ffd966"), // Жовтий
            Color(hex: "ff99cc")  // Рожевий
        ],
        [
            Color(hex: "ffd966"), // Жовтий
            Color(hex: "ff99cc"), // Рожевий
            Color(hex: "c299ff")  // Бузковий
        ],
        [
            Color(hex: "ff99cc"), // Рожевий
            Color(hex: "c299ff"), // Бузковий
            Color(hex: "6ea8ff")  // Синій
        ],
        [
            Color(hex: "c299ff"), // Бузковий
            Color(hex: "6ea8ff"), // Синій
            Color(hex: "ffd966")  // Жовтий
        ]
    ]
    
    private var timer: Timer?
    
    private init() {
        startAnimation()
    }
    
    func startAnimation() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            withAnimation(.easeInOut(duration: 2.5)) {
                self.colorIndex = (self.colorIndex + 1) % self.colorSets.count
            }
        }
    }
    
    var currentColors: [Color] {
        colorSets[colorIndex]
    }
}

struct AnimatedGradientBackground: View {
    @StateObject private var gradientManager = GradientManager.shared
    
    var body: some View {
        LinearGradient(
            colors: gradientManager.currentColors,
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
    }
}

