import SwiftUI

// Градиент из ios-diia-main проекта, адаптированный для SwiftUI
class GradientManager: ObservableObject {
    static let shared = GradientManager()
    
    @Published var colorIndex = 0
    
    // Те же цвета что и в AnimatedGradientBackgroundView из ios-diia-main
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
        // Используем тот же интервал что и в ios-diia-main (3.0 секунды)
        timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            // Используем ту же длительность анимации (2.5 секунды)
            withAnimation(.easeInOut(duration: 2.5)) {
                self.colorIndex = (self.colorIndex + 1) % self.colorSets.count
            }
        }
        if let timer = timer {
            RunLoop.current.add(timer, forMode: .common)
        }
    }
    
    var currentColors: [Color] {
        colorSets[colorIndex]
    }
    
    deinit {
        timer?.invalidate()
    }
}

struct AnimatedGradientBackground: View {
    @ObservedObject private var gradientManager = GradientManager.shared
    
    var body: some View {
        // Используем те же точки начала и конца что и в ios-diia-main
        // startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 1, y: 1)
        LinearGradient(
            colors: gradientManager.currentColors,
            startPoint: .topLeading,  // (0, 0)
            endPoint: .bottomTrailing // (1, 1)
        )
        .ignoresSafeArea()
    }
}

