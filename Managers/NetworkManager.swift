import Foundation

class NetworkManager: ObservableObject {
    static let shared = NetworkManager()
    
    // API Base URL - змініть на вашу IP адресу при запуску
    private let baseURL = "http://localhost:8000"
    
    // Fallback credentials для offline режиму
    private let offlineCredentials: [String: String] = [
        "cmutyy": "password123"
    ]
    
    struct LoginResponse: Codable {
        let success: Bool
        let message: String
        let user: UserData?
    }
    
    struct UserData: Codable {
        let id: Int
        let full_name: String
        let birth_date: String
        let login: String
        let subscription_active: Bool
        let subscription_type: String
        let last_login: String?
        
        enum CodingKeys: String, CodingKey {
            case id
            case full_name
            case birth_date
            case login
            case subscription_active
            case subscription_type
            case last_login
        }
    }
    
    struct LoginRequest: Codable {
        let login: String
        let password: String
    }
    
    func login(username: String, password: String) async -> (success: Bool, message: String, userData: UserData?) {
        // Спочатку пробуємо підключитися до API
        if let result = await tryAPILogin(username: username, password: password) {
            return result
        }
        
        // Якщо API недоступний, перевіряємо offline credentials
        if let storedPassword = offlineCredentials[username], storedPassword == password {
            return (true, "Offline авторизація успішна", nil)
        }
        
        // Перевіряємо локально збережені дані
        if let userData = UserDefaults.standard.data(forKey: "cachedUserData_\(username)"),
           let cachedUser = try? JSONDecoder().decode(UserData.self, from: userData),
           let cachedPassword = UserDefaults.standard.string(forKey: "cachedPassword_\(username)"),
           cachedPassword == password {
            return (true, "Локальна авторизація успішна", cachedUser)
        }
        
        return (false, "Невірний логін або пароль", nil)
    }
    
    private func tryAPILogin(username: String, password: String) async -> (success: Bool, message: String, userData: UserData?)? {
        guard let url = URL(string: "\(baseURL)/api/auth/login") else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 5.0 // 5 секунд timeout
        
        let loginRequest = LoginRequest(login: username, password: password)
        
        do {
            request.httpBody = try JSONEncoder().encode(loginRequest)
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                return nil
            }
            
            if httpResponse.statusCode == 200 {
                let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
                
                if loginResponse.success, let userData = loginResponse.user {
                    // Кешуємо дані для offline використання
                    cacheUserData(username: username, password: password, userData: userData)
                    return (true, loginResponse.message, userData)
                } else {
                    return (false, loginResponse.message, nil)
                }
            }
        } catch {
            print("API Login error: \(error.localizedDescription)")
            return nil
        }
        
        return nil
    }
    
    private func cacheUserData(username: String, password: String, userData: UserData) {
        if let encoded = try? JSONEncoder().encode(userData) {
            UserDefaults.standard.set(encoded, forKey: "cachedUserData_\(username)")
            UserDefaults.standard.set(password, forKey: "cachedPassword_\(username)")
        }
    }
    
    func checkServerHealth() async -> Bool {
        guard let url = URL(string: "\(baseURL)/api/health") else {
            return false
        }
        
        var request = URLRequest(url: url)
        request.timeoutInterval = 3.0
        
        do {
            let (_, response) = try await URLSession.shared.data(for: request)
            if let httpResponse = response as? HTTPURLResponse {
                return httpResponse.statusCode == 200
            }
        } catch {
            print("Server health check failed: \(error.localizedDescription)")
        }
        
        return false
    }
}

