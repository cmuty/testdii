import SwiftUI

struct AnimatedGradientBackground: View {
    @State private var phase: CGFloat = 0
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
        ZStack {
            MeshGradient(colors: currentColors)
                .ignoresSafeArea()
            
            LinearGradient(
                colors: currentColors,
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .hueRotation(.degrees(phase))
            .ignoresSafeArea()
            .opacity(0.5)
        }
        .onAppear {
            withAnimation(
                .linear(duration: 8)
                .repeatForever(autoreverses: false)
            ) {
                phase = 360
            }
            
            Timer.scheduledTimer(withTimeInterval: 6, repeats: true) { _ in
                withAnimation(.easeInOut(duration: 3)) {
                    colorIndex = (colorIndex + 1) % colorSets.count
                }
            }
        }
    }
    
    var currentColors: [Color] {
        colorSets[colorIndex]
    }
}

struct MeshGradient: View {
    let colors: [Color]
    @State private var offset1: CGFloat = 0
    @State private var offset2: CGFloat = 0
    
    var body: some View {
        ZStack {
            ForEach(0..<colors.count, id: \.self) { index in
                Circle()
                    .fill(colors[index])
                    .frame(width: 600, height: 600)
                    .offset(
                        x: offset1 * CGFloat(index % 2 == 0 ? 100 : -100),
                        y: offset2 * CGFloat(index % 3 == 0 ? 100 : -100)
                    )
                    .blur(radius: 100)
            }
        }
        .onAppear {
            withAnimation(
                .easeInOut(duration: 10)
                .repeatForever(autoreverses: true)
            ) {
                offset1 = 1
            }
            
            withAnimation(
                .easeInOut(duration: 12)
                .repeatForever(autoreverses: true)
            ) {
                offset2 = 1
            }
        }
    }
}

