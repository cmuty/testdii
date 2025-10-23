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
            Color(UIColor.systemGroupedBackground)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    // Header
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Меню")
                            .font(.system(size: 34, weight: .bold, design: .default))
                            .foregroundColor(.black)
                        
                        Text("Версія Дії: 4.23.0.2195")
                            .font(.system(size: 15, weight: .regular, design: .default))
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    .padding(.bottom, 24)
                    
                    // Повідомлення
                    MenuButton(icon: "envelope", title: "Повідомлення") {
                        print("Повідомлення")
                    }
                    .background(Color.white)
                    .cornerRadius(12)
                    .padding(.horizontal, 16)
                    
                    // Spacer
                    Color.clear.frame(height: 16)
                    
                    // Дія.Підпис section
                    VStack(spacing: 0) {
                        MenuButton(icon: "key.fill", title: "Дія.Підпис") {
                            print("Дія.Підпис")
                        }
                        
                        Divider()
                            .padding(.leading, 60)
                        
                        MenuButton(icon: "doc.text", title: "Історія підписань") {
                            print("Історія підписань")
                        }
                    }
                    .background(Color.white)
                    .cornerRadius(12)
                    .padding(.horizontal, 16)
                    
                    // Spacer
                    Color.clear.frame(height: 16)
                    
                    // Налаштування section
                    VStack(spacing: 0) {
                        MenuButton(icon: "gearshape", title: "Налаштування") {
                            print("Налаштування")
                        }
                        
                        Divider()
                            .padding(.leading, 60)
                        
                        MenuButton(icon: "arrow.clockwise", title: "Оновити застосунок") {
                            print("Оновити застосунок")
                        }
                        
                        Divider()
                            .padding(.leading, 60)
                        
                        MenuButton(icon: "iphone", title: "Підключені пристрої") {
                            print("Підключені пристрої")
                        }
                    }
                    .background(Color.white)
                    .cornerRadius(12)
                    .padding(.horizontal, 16)
                    
                    // Spacer
                    Color.clear.frame(height: 16)
                    
                    // Служба підтримки section
                    VStack(spacing: 0) {
                        MenuButton(icon: "message", title: "Служба підтримки") {
                            print("Служба підтримки")
                        }
                        
                        Divider()
                            .padding(.leading, 60)
                        
                        MenuButton(icon: "doc.on.doc", title: "Копіювати номер пристрою") {
                            print("Копіювати номер пристрою")
                        }
                        
                        Divider()
                            .padding(.leading, 60)
                        
                        MenuButton(icon: "questionmark.circle", title: "Питання та відповіді") {
                            print("Питання та відповіді")
                        }
                    }
                    .background(Color.white)
                    .cornerRadius(12)
                    .padding(.horizontal, 16)
                    
                    // Spacer
                    Color.clear.frame(height: 32)
                    
                    // Вийти button
                    Button(action: {
                        authManager.logout()
                    }) {
                        Text("Вийти")
                            .font(.system(size: 17, weight: .semibold, design: .default))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 54)
                            .background(Color.black)
                            .cornerRadius(12)
                    }
                    .padding(.horizontal, 16)
                    
                    // Privacy notice
                    Button(action: {
                        print("Повідомлення про обробку персональних даних")
                    }) {
                        Text("Повідомлення про обробку персональних даних")
                            .font(.system(size: 13, weight: .regular, design: .default))
                            .foregroundColor(.black)
                            .underline()
                    }
                    .padding(.top, 16)
                    .padding(.bottom, 40)
                    .frame(maxWidth: .infinity)
                }
            }
        }
    }
}

// Menu button component
struct MenuButton: View {
    let icon: String
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                Image(systemName: icon)
                    .font(.system(size: 22))
                    .foregroundColor(.black)
                    .frame(width: 28)
                
                Text(title)
                    .font(.system(size: 17, weight: .regular, design: .default))
                    .foregroundColor(.black)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.gray.opacity(0.4))
            }
            .padding(.horizontal, 20)
            .frame(height: 56)
            .contentShape(Rectangle())
        }
    }
}

