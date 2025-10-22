import SwiftUI

struct DocumentsView: View {
    let user = User.mock
    @State private var currentPage = 0
    
    var body: some View {
        ZStack {
            AnimatedGradientBackground()
            
            VStack(spacing: 24) {
                Spacer()
                
                // Carousel з документами
                TabView(selection: $currentPage) {
                    // єДокумент
                    DocumentCard(user: user)
                        .padding(.horizontal, 40)
                        .tag(0)
                    
                    // Картка платника податків
                    TaxCard(user: user)
                        .padding(.horizontal, 40)
                        .tag(1)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .frame(height: 600)
                
                // Page indicator
                HStack(spacing: 8) {
                    ForEach(0..<2) { index in
                        Capsule()
                            .fill(Color.white.opacity(index == currentPage ? 0.9 : 0.4))
                            .frame(width: index == currentPage ? 32 : 8, height: 8)
                            .animation(.spring(), value: currentPage)
                    }
                }
                .padding(.bottom, 24)
                
                Spacer()
            }
        }
    }
}

