import SwiftUI
import Combine

class AuthManager: ObservableObject {
    @Published var isAuthenticated: Bool = false
    @Published var hasSeenWelcome: Bool = false
    @Published var userName: String = ""
    
    private let userDefaults = UserDefaults.standard
    
    init() {
        loadAuthState()
    }
    
    private func loadAuthState() {
        isAuthenticated = userDefaults.bool(forKey: "isAuthenticated")
        hasSeenWelcome = userDefaults.bool(forKey: "hasSeenWelcome")
        userName = userDefaults.string(forKey: "userName") ?? ""
    }
    
    func login(username: String, password: String) {
        guard !username.isEmpty && !password.isEmpty else { return }
        
        userName = username
        isAuthenticated = true
        
        userDefaults.set(true, forKey: "isAuthenticated")
        userDefaults.set(username, forKey: "userName")
    }
    
    func logout() {
        isAuthenticated = false
        userName = ""
        userDefaults.set(false, forKey: "isAuthenticated")
    }
    
    func markWelcomeSeen() {
        hasSeenWelcome = true
        userDefaults.set(true, forKey: "hasSeenWelcome")
    }
}

