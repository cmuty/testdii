import SwiftUI

struct AuthView: View {
    @EnvironmentObject var authManager: AuthManager
    @StateObject private var networkManager = NetworkManager.shared
    @State private var username = ""
    @State private var password = ""
    @State private var showPassword = false
    @State private var isLoading = false
    @State private var showError = false
    @State private var errorMessage = ""
    @State private var isServerOnline = false
    
    var body: some View {
        ZStack {
            AnimatedGradientBackground()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Text("Вітаємо в Дія 👋")
                        .font(.system(size: 30, weight: .regular, design: .default))
                        .padding(.top, 64)
                    
                    // Логін
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Логін")
                            .font(.system(size: 18, weight: .regular, design: .default))
                        
                        TextField("Ваш логін", text: $username)
                            .font(.system(size: 16, weight: .regular, design: .default))
                            .padding()
                            .frame(height: 56)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color.white.opacity(0.7))
                                    .background(.ultraThinMaterial)
                            )
                            .autocapitalization(.none)
                    }
                    
                    // Пароль
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Пароль")
                            .font(.system(size: 18, weight: .regular, design: .default))
                        
                        HStack {
                            if showPassword {
                                TextField("Ваш пароль", text: $password)
                            } else {
                                SecureField("Ваш пароль", text: $password)
                            }
                            
                            Button(action: { showPassword.toggle() }) {
                                Image(systemName: showPassword ? "eye.slash" : "eye")
                                    .foregroundColor(.gray)
                            }
                        }
                        .font(.system(size: 16, weight: .regular, design: .default))
                        .padding()
                        .frame(height: 56)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.white.opacity(0.7))
                                .background(.ultraThinMaterial)
                        )
                        
                        Button(action: {
                            if let url = URL(string: "https://t.me/diiatest24bot") {
                                UIApplication.shared.open(url)
                            }
                        }) {
                            Text("Забули пароль?")
                                .font(.system(size: 14, weight: .regular, design: .default))
                                .foregroundColor(.black)
                        }
                    }
                    
                    // Server status
                    HStack {
                        Circle()
                            .fill(isServerOnline ? Color.green : Color.orange)
                            .frame(width: 8, height: 8)
                        Text(isServerOnline ? "Сервер підключено" : "Offline режим")
                            .font(.system(size: 12, weight: .regular, design: .default))
                            .foregroundColor(.black.opacity(0.6))
                    }
                    .padding(.bottom, 4)
                    
                    // Кнопка входа
                    Button(action: {
                        Task {
                            await performLogin()
                        }
                    }) {
                        if isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .background(Color.black.opacity(0.7))
                            .cornerRadius(16)
                        } else {
                            Text("Увійти")
                                .font(.system(size: 18, weight: .regular, design: .default))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 56)
                                .background(Color.black)
                                .cornerRadius(16)
                        }
                    }
                    .disabled(isLoading || username.isEmpty || password.isEmpty)
                    .opacity((isLoading || username.isEmpty || password.isEmpty) ? 0.5 : 1)
                    .padding(.top, 16)
                    
                    Spacer(minLength: 100)
                    
                    // Регистрация
                    VStack(spacing: 16) {
                        VStack(spacing: 4) {
                            Text("Не зареєстровані?")
                                .font(.system(size: 16, weight: .regular, design: .default))
                            Text("Реєстрація доступна в нашому боті")
                                .font(.system(size: 14, weight: .regular, design: .default))
                                .foregroundColor(.gray)
                        }
                        
                        Button(action: {
                            if let url = URL(string: "https://t.me/maijediiabot") {
                                UIApplication.shared.open(url)
                            }
                        }) {
                            HStack {
                                Text("Перейти до бота")
                                    .font(.system(size: 16, weight: .regular, design: .default))
                                Image(systemName: "arrow.right")
                            }
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color.white.opacity(0.7))
                                    .background(.ultraThinMaterial)
                            )
                        }
                    }
                    .padding(.bottom, 32)
            }
            .padding(.horizontal, 24)
            .alert("Помилка", isPresented: $showError) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(errorMessage)
            }
            .task {
                // Перевіряємо статус сервера при завантаженні
                isServerOnline = await networkManager.checkServerHealth()
            }
        }
        }
    }
    
    private func performLogin() async {
        isLoading = true
        
        let result = await networkManager.login(username: username, password: password)
        
        await MainActor.run {
            isLoading = false
            
            if result.success {
                // Спочатку виконуємо login
                authManager.login(username: username, password: password)
                
                // Потім зберігаємо додаткові дані користувача якщо є
                if let userData = result.userData {
                    authManager.updateUserData(
                        fullName: userData.full_name,
                        birthDate: userData.birth_date,
                        userId: userData.id,
                        subscriptionActive: userData.subscription_active,
                        subscriptionType: userData.subscription_type,
                        registeredAt: userData.registered_at
                    )
                    
                    // Завантажуємо фото користувача
                    Task {
                        if let photoData = await networkManager.downloadUserPhoto(userId: userData.id) {
                            await MainActor.run {
                                UserDefaults.standard.set(photoData, forKey: "userPhoto")
                            }
                        }
                    }
                }
                
            } else {
                errorMessage = result.message
                showError = true
            }
        }
    }
}
