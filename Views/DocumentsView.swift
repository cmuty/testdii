import SwiftUI

struct DocumentsView: View {
    let user = User.mock
    @State private var currentPage = 0
    
    var body: some View {
        ZStack {
            AnimatedGradientBackground()
            
            VStack(spacing: 24) {
                Spacer()
                
                DocumentCard(user: user)
                    .padding(.horizontal, 24)
                
                // Page indicator
                HStack(spacing: 8) {
                    ForEach(0..<5) { index in
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

