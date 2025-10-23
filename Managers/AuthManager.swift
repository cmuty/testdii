import SwiftUI
import Combine

class AuthManager: ObservableObject {
    @Published var isAuthenticated: Bool = false
    @Published var hasSeenWelcome: Bool = false
    @Published var userName: String = ""
    @Published var hasSignature: Bool = false
    @Published var userFullName: String = ""
    @Published var userBirthDate: String = ""
    @Published var userId: Int?
    @Published var subscriptionActive: Bool = false
    @Published var subscriptionType: String = ""
    
    private let userDefaults = UserDefaults.standard
    
    init() {
        loadAuthState()
    }
    
    private func loadAuthState() {
        isAuthenticated = userDefaults.bool(forKey: "isAuthenticated")
        hasSeenWelcome = userDefaults.bool(forKey: "hasSeenWelcome")
        userName = userDefaults.string(forKey: "userName") ?? ""
        hasSignature = userDefaults.data(forKey: "userSignature") != nil
        userFullName = userDefaults.string(forKey: "userFullName") ?? ""
        userBirthDate = userDefaults.string(forKey: "userBirthDate") ?? ""
        userId = userDefaults.object(forKey: "userId") as? Int
        subscriptionActive = userDefaults.bool(forKey: "subscriptionActive")
        subscriptionType = userDefaults.string(forKey: "subscriptionType") ?? ""
    }
    
    func login(username: String, password: String) {
        guard !username.isEmpty && !password.isEmpty else { return }
        
        userName = username
        isAuthenticated = true
        
        userDefaults.set(true, forKey: "isAuthenticated")
        userDefaults.set(username, forKey: "userName")
        userDefaults.set(Date(), forKey: "lastLoginDate")
        
        // Сохраняем дату первого входа только если её ещё нет
        if userDefaults.object(forKey: "firstLoginDate") == nil {
            userDefaults.set(Date(), forKey: "firstLoginDate")
        }
    }
    
    func updateUserData(fullName: String, birthDate: String, userId: Int, subscriptionActive: Bool, subscriptionType: String) {
        self.userFullName = fullName
        self.userBirthDate = birthDate
        self.userId = userId
        self.subscriptionActive = subscriptionActive
        self.subscriptionType = subscriptionType
        
        userDefaults.set(fullName, forKey: "userFullName")
        userDefaults.set(birthDate, forKey: "userBirthDate")
        userDefaults.set(userId, forKey: "userId")
        userDefaults.set(subscriptionActive, forKey: "subscriptionActive")
        userDefaults.set(subscriptionType, forKey: "subscriptionType")
    }
    
    func logout() {
        isAuthenticated = false
        userName = ""
        userFullName = ""
        userBirthDate = ""
        userId = nil
        subscriptionActive = false
        subscriptionType = ""
        
        userDefaults.set(false, forKey: "isAuthenticated")
        userDefaults.removeObject(forKey: "userName")
        userDefaults.removeObject(forKey: "userFullName")
        userDefaults.removeObject(forKey: "userBirthDate")
        userDefaults.removeObject(forKey: "userId")
        userDefaults.removeObject(forKey: "subscriptionActive")
        userDefaults.removeObject(forKey: "subscriptionType")
    }
    
    func markWelcomeSeen() {
        hasSeenWelcome = true
        userDefaults.set(true, forKey: "hasSeenWelcome")
    }
    
    func completeSignature() {
        hasSignature = true
    }
}

