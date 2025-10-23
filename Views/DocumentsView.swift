import SwiftUI

struct DocumentsView: View {
    @EnvironmentObject var authManager: AuthManager
    @State private var currentPage = 0
    @State private var dragOffset: CGFloat = 0
    @State private var showMenu = false
    @State private var showFullInfo = false
    @State private var currentDocumentName = ""
    @State private var taxCardFlipped = false
    @State private var taxCardShowingQR = true
    
    // Создаём User из данных AuthManager
    private var user: User {
        User(from: authManager)
    }
    
    // Определяем тип документа по текущей странице
    private var currentDocumentType: DocumentType {
        switch currentPage {
        case 1: return .taxCard
        default: return .standard
        }
    }
    
    var body: some View {
        ZStack {
            AnimatedGradientBackground()
            
            VStack(spacing: 12) {
                Spacer()
                
                VStack(spacing: 16) {
                    // Carousel з документами
                    TabView(selection: $currentPage) {
                        // єДокумент
                        DocumentCard(user: user) {
                            currentDocumentName = "єДокумент"
                            withAnimation(.spring(response: 0.3)) {
                                showMenu = true
                            }
                        }
                        .padding(.horizontal, 30)
                        .scaleEffect(currentPage == 0 ? 1.0 : 0.88)
                        .opacity(currentPage == 0 ? 1.0 : 0.7)
                        .animation(.spring(response: 0.5, dampingFraction: 0.75), value: currentPage)
                        .tag(0)
                        
                        // Картка платника податків
                        TaxCard(
                            user: user,
                            onMenuTap: {
                                currentDocumentName = "Картка платника податків"
                                withAnimation(.spring(response: 0.3)) {
                                    showMenu = true
                                }
                            },
                            isFlipped: $taxCardFlipped,
                            showingQR: $taxCardShowingQR
                        )
                        .padding(.horizontal, 30)
                        .scaleEffect(currentPage == 1 ? 1.0 : 0.88)
                        .opacity(currentPage == 1 ? 1.0 : 0.7)
                        .animation(.spring(response: 0.5, dampingFraction: 0.75), value: currentPage)
                        .tag(1)
                        
                        // Паспорт громадянина України
                        PassportCard(user: user) {
                            currentDocumentName = "Паспорт громадянина України"
                            withAnimation(.spring(response: 0.3)) {
                                showMenu = true
                            }
                        }
                        .padding(.horizontal, 30)
                        .scaleEffect(currentPage == 2 ? 1.0 : 0.88)
                        .opacity(currentPage == 2 ? 1.0 : 0.7)
                        .animation(.spring(response: 0.5, dampingFraction: 0.75), value: currentPage)
                        .tag(2)
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    .frame(height: 550)
                    .blur(radius: showMenu ? 1 : 0)
                    
                    // Page indicator (точки)
                    HStack(spacing: 8) {
                        ForEach(0..<3) { index in
                            Circle()
                                .fill(Color.white.opacity(index == currentPage ? 0.9 : 0.4))
                                .frame(width: 8, height: 8)
                                .animation(.spring(response: 0.4, dampingFraction: 0.75), value: currentPage)
                        }
                    }
                    .blur(radius: showMenu ? 1 : 0)
                }
                
                Spacer()
            }
            
            // Menu overlay поверх всего
            DocumentMenuSheet(
                isPresented: $showMenu,
                documentName: currentDocumentName,
                documentType: currentDocumentType,
                onFullInfoTap: {
                    showFullInfo = true
                },
                onQRTap: {
                    taxCardShowingQR = true
                    withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                        taxCardFlipped = true
                    }
                },
                onBarcodeTap: {
                    taxCardShowingQR = false
                    withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                        taxCardFlipped = true
                    }
                }
            )
            .zIndex(100)
        }
        .sheet(isPresented: $showFullInfo) {
            DocumentFullInfoView(
                isPresented: $showFullInfo,
                user: user
            )
        }
    }
}

