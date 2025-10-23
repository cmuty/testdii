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
                    TabView(selection: $currentPage) {
                        // єДокумент
                        DocumentCard(user: user)
                            .padding(.horizontal, 20)
                            .scaleEffect(currentPage == 0 ? 1.0 : 0.88)
                            .opacity(currentPage == 0 ? 1.0 : 0.7)
                            .animation(.spring(response: 0.5, dampingFraction: 0.75), value: currentPage)
                            .tag(0)
                        
                        // Картка платника податків
                        TaxCard(user: user)
                            .padding(.horizontal, 20)
                            .scaleEffect(currentPage == 1 ? 1.0 : 0.88)
                            .opacity(currentPage == 1 ? 1.0 : 0.7)
                            .animation(.spring(response: 0.5, dampingFraction: 0.75), value: currentPage)
                            .tag(1)
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    .frame(height: 550)
                    .padding(.horizontal, -10)
                    
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

