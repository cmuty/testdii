import SwiftUI

struct AnimatedGradientBackground: View {
    @State private var startPoint: UnitPoint = .topLeading
    @State private var endPoint: UnitPoint = .bottomTrailing
    @State private var colorIndex = 0
    
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
    
    var body: some View {
        LinearGradient(
            colors: currentColors,
            startPoint: startPoint,
            endPoint: endPoint
        )
        .ignoresSafeArea()
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { _ in
                withAnimation(.easeInOut(duration: 2.5)) {
                    colorIndex = (colorIndex + 1) % colorSets.count
                }
            }
        }
    }
    
    var currentColors: [Color] {
        colorSets[colorIndex]
    }
}

