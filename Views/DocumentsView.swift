import SwiftUI

struct DocumentsView: View {
    let user = User.mock
    @State private var currentPage = 0
    @State private var dragOffset: CGFloat = 0
    
    var body: some View {
        ZStack {
            AnimatedGradientBackground()
            
            VStack(spacing: 12) {
                Spacer()
                
                VStack(spacing: 16) {
                    // Carousel з документами
                    GeometryReader { geometry in
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 20) {
                                // єДокумент
                                DocumentCard(user: user)
                                    .frame(width: geometry.size.width - 60)
                                    .scaleEffect(currentPage == 0 ? 1.0 : 0.88)
                                    .opacity(currentPage == 0 ? 1.0 : 0.7)
                                    .animation(.spring(response: 0.5, dampingFraction: 0.75), value: currentPage)
                                    .onTapGesture {
                                        withAnimation {
                                            currentPage = 0
                                        }
                                    }
                                
                                // Картка платника податків
                                TaxCard(user: user)
                                    .frame(width: geometry.size.width - 60)
                                    .scaleEffect(currentPage == 1 ? 1.0 : 0.88)
                                    .opacity(currentPage == 1 ? 1.0 : 0.7)
                                    .animation(.spring(response: 0.5, dampingFraction: 0.75), value: currentPage)
                                    .onTapGesture {
                                        withAnimation {
                                            currentPage = 1
                                        }
                                    }
                            }
                            .padding(.horizontal, 30)
                        }
                        .content.offset(x: -CGFloat(currentPage) * (geometry.size.width - 40))
                        .animation(.spring(response: 0.5, dampingFraction: 0.75), value: currentPage)
                        .gesture(
                            DragGesture()
                                .onEnded { value in
                                    let threshold = geometry.size.width / 3
                                    if value.translation.width < -threshold && currentPage < 1 {
                                        withAnimation {
                                            currentPage += 1
                                        }
                                    } else if value.translation.width > threshold && currentPage > 0 {
                                        withAnimation {
                                            currentPage -= 1
                                        }
                                    }
                                }
                        )
                    }
                    .frame(height: 550)
                    
                    // Page indicator (точки)
                    HStack(spacing: 8) {
                        ForEach(0..<2) { index in
                            Circle()
                                .fill(Color.white.opacity(index == currentPage ? 0.9 : 0.4))
                                .frame(width: 8, height: 8)
                                .animation(.spring(response: 0.4, dampingFraction: 0.75), value: currentPage)
                        }
                    }
                }
                
                Spacer()
            }
        }
    }
}

