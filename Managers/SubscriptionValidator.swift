import Foundation
import SwiftUI
import Combine

class SubscriptionValidator: ObservableObject {
    private var timer: Timer?
    private var cancellables = Set<AnyCancellable>()
    private let checkInterval: TimeInterval = 300 // 5 minutes
    
    private weak var authManager: AuthManager?
    private let networkManager = NetworkManager.shared
    
    init(authManager: AuthManager) {
        self.authManager = authManager
    }
    
    // MARK: - Monitoring Control
    
    func startMonitoring() {
        print("🔍 Starting subscription monitoring...")
        
        // Initial check
        checkSubscriptionStatus()
        
        // Setup periodic timer
        timer = Timer.scheduledTimer(withTimeInterval: checkInterval, repeats: true) { [weak self] _ in
            self?.checkSubscriptionStatus()
        }
        
        // Ensure timer runs in common run loop modes
        RunLoop.current.add(timer!, forMode: .common)
    }
    
    func stopMonitoring() {
        print("⏸️ Stopping subscription monitoring...")
        timer?.invalidate()
        timer = nil
    }
    
    // MARK: - Subscription Validation
    
    func checkSubscriptionStatus() {
        guard let authManager = authManager else {
            print("⚠️ AuthManager is nil, stopping subscription check")
            return
        }
        
        guard authManager.isAuthenticated else {
            print("⚠️ Not authenticated, skipping subscription check")
            return
        }
        
        guard let userId = authManager.userId else {
            print("⚠️ No user ID, skipping subscription check")
            return
        }
        
        print("🔍 Checking subscription status for user \(userId)...")
        
        Task {
            // Try API check first
            if let apiStatus = await networkManager.checkSubscriptionStatus(userId: userId) {
                print("✅ API subscription check: \(apiStatus ? "active" : "expired")")
                
                await MainActor.run {
                    if !apiStatus {
                        // Subscription expired according to API
                        print("❌ Subscription expired - logging out user")
                        handleSubscriptionExpired()
                    } else {
                        // Update local state to match API if needed
                        if !authManager.subscriptionActive {
                            print("✅ Updating local subscription status to active")
                            authManager.subscriptionActive = true
                            UserDefaults.standard.set(true, forKey: "subscriptionActive")
                        }
                    }
                }
            } else {
                // API unavailable - check local state only
                print("⚠️ API unavailable, checking local subscription status")
                
                await MainActor.run {
                    if !authManager.subscriptionActive {
                        print("❌ Local subscription status is inactive - logging out user")
                        handleSubscriptionExpired()
                    } else {
                        print("ℹ️ Local subscription status is active, continuing...")
                    }
                }
            }
        }
    }
    
    // MARK: - Expiry Handling
    
    private func handleSubscriptionExpired() {
        print("🚪 Handling subscription expiry - performing logout")
        authManager?.logout()
    }
}
