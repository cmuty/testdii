import SwiftUI

struct AnimatedGradientBackground: View {
    @State private var startPoint: UnitPoint = .topLeading
    @State private var endPoint: UnitPoint = .bottomTrailing
    @State private var colorIndex = 0
    
    let colorSets: [[Color]] = [
        [
            Color(hex: "d4a5d4"),
            Color(hex: "f0e0c0"),
            Color(hex: "c0e0a0"),
            Color(hex: "a0d4f0"),
            Color(hex: "e0d0f0"),
            Color(hex: "f0c0d4")
        ],
        [
            Color(hex: "f0c0d4"),
            Color(hex: "c0e0f0"),
            Color(hex: "e0f0c0"),
            Color(hex: "d4a5d4"),
            Color(hex: "a0d4e0"),
            Color(hex: "f0e0c0")
        ],
        [
            Color(hex: "e0d0f0"),
            Color(hex: "a0e0d4"),
            Color(hex: "f0d4c0"),
            Color(hex: "c0a0f0"),
            Color(hex: "d4f0e0"),
            Color(hex: "f0a0c0")
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
            withAnimation(
                .easeInOut(duration: 5)
                .repeatForever(autoreverses: true)
            ) {
                startPoint = .bottomTrailing
                endPoint = .topLeading
            }
            
            Timer.scheduledTimer(withTimeInterval: 4, repeats: true) { _ in
                withAnimation(.easeInOut(duration: 2)) {
                    colorIndex = (colorIndex + 1) % colorSets.count
                }
            }
        }
    }
    
    var currentColors: [Color] {
        colorSets[colorIndex]
    }
}

