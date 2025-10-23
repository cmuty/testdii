import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            // Стрічка
            HomeView()
                .tabItem {
                    Image(systemName: "doc.text.image")
                    Text("Стрічка")
                }
                .tag(0)
            
            // Документи
            DocumentsView()
                .tabItem {
                    Image(systemName: "doc.plaintext")
                    Text("Документи")
                }
                .tag(1)
            
            // Сервіси
            ServicesView()
                .tabItem {
                    Image(systemName: "bolt.fill")
                    Text("Сервіси")
                }
                .tag(2)
            
            // Меню
            MenuView()
                .tabItem {
                    Image(systemName: "person.circle")
                    Text("Меню")
                }
                .tag(3)
        }
        .accentColor(.black)
        .onAppear {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor.black
            
            // Збільшуємо висоту TabBar
            UITabBar.appearance().frame.size.height = 100
            
            // Цвет невыбранных иконок
            appearance.stackedLayoutAppearance.normal.iconColor = UIColor.white.withAlphaComponent(0.5)
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
                .foregroundColor: UIColor.white.withAlphaComponent(0.5)
            ]
            
            // Цвет выбранных иконок
            appearance.stackedLayoutAppearance.selected.iconColor = UIColor.white
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
                .foregroundColor: UIColor.white
            ]
            
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}

// ServicesView moved to separate file

struct MenuView: View {
    @EnvironmentObject var authManager: AuthManager
    
    var body: some View {
        ZStack {
            AnimatedGradientBackground()
            
            VStack(spacing: 20) {
                Spacer()
                
                Text("Меню")
                    .font(.largeTitle)
                    .bold()
                
                Text(authManager.userName)
                    .font(.title2)
                
                Button("Вийти") {
                    authManager.logout()
                }
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .background(Color.red)
                .cornerRadius(12)
                
                Spacer()
            }
        }
    }
}

