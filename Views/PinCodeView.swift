import SwiftUI
import CryptoKit

// Менеджер для хранения и проверки пинкода
class PinCodeManager: ObservableObject {
    static let shared = PinCodeManager()
    
    private let userDefaults = UserDefaults.standard
    private let pinCodeKey = "userPinCode"
    private let incorrectAttemptsKey = "incorrectPinCodeAttempts"
    private let maxAttempts = 3
    
    private init() {}
    
    // Сохраняет хеш пинкода
    func savePinCode(_ pinCode: [Int]) {
        let pinString = pinCode.map { String($0) }.joined()
        if let data = pinString.data(using: .utf8) {
            let hash = SHA256.hash(data: data)
            let hashString = hash.compactMap { String(format: "%02x", $0) }.joined()
            userDefaults.set(hashString, forKey: pinCodeKey)
            userDefaults.set(0, forKey: incorrectAttemptsKey)
        }
    }
    
    // Проверяет пинкод
    func checkPinCode(_ pinCode: [Int]) -> Bool {
        let pinString = pinCode.map { String($0) }.joined()
        guard let data = pinString.data(using: .utf8) else { return false }
        let hash = SHA256.hash(data: data)
        let hashString = hash.compactMap { String(format: "%02x", $0) }.joined()
        
        if let savedHash = userDefaults.string(forKey: pinCodeKey),
           savedHash == hashString {
            // Сбрасываем счетчик попыток при успешном вводе
            userDefaults.set(0, forKey: incorrectAttemptsKey)
            return true
        }
        
        // Увеличиваем счетчик неправильных попыток
        let attempts = userDefaults.integer(forKey: incorrectAttemptsKey) + 1
        userDefaults.set(attempts, forKey: incorrectAttemptsKey)
        
        return false
    }
    
    // Проверяет, установлен ли пинкод
    func hasPinCode() -> Bool {
        return userDefaults.string(forKey: pinCodeKey) != nil
    }
    
    // Получает количество неправильных попыток
    func getIncorrectAttempts() -> Int {
        return userDefaults.integer(forKey: incorrectAttemptsKey)
    }
    
    // Удаляет пинкод
    func removePinCode() {
        userDefaults.removeObject(forKey: pinCodeKey)
        userDefaults.removeObject(forKey: incorrectAttemptsKey)
    }
}

// Экран создания пинкода
struct CreatePinCodeView: View {
    @EnvironmentObject var authManager: AuthManager
    @StateObject private var pinCodeManager = PinCodeManager.shared
    @State private var pinCode: [Int] = []
    @State private var confirmPinCode: [Int] = []
    @State private var isConfirming = false
    @State private var showError = false
    @State private var errorMessage = ""
    
    let onComplete: () -> Void
    
    var body: some View {
        ZStack {
            AnimatedGradientBackground()
            
            VStack(spacing: 40) {
                Spacer()
                
                // Заголовок
                VStack(spacing: 8) {
                    Text(isConfirming ? "Повторіть PIN-код" : "Створіть PIN-код")
                        .font(.system(size: 28, weight: .regular, design: .default))
                        .foregroundColor(.black)
                    
                    Text(isConfirming ? "Введіть PIN-код ще раз для підтвердження" : "Введіть 4-значний PIN-код для захисту вашого пристрою")
                        .font(.system(size: 16, weight: .regular, design: .default))
                        .foregroundColor(.black.opacity(0.6))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
                }
                
                // Индикаторы пинкода
                HStack(spacing: 16) {
                    ForEach(0..<4) { index in
                        Circle()
                            .fill(index < (isConfirming ? confirmPinCode.count : pinCode.count) ? Color.black : Color.black.opacity(0.2))
                            .frame(width: 16, height: 16)
                    }
                }
                
                // Клавиатура
                VStack(spacing: 20) {
                    ForEach(0..<3) { row in
                        HStack(spacing: 20) {
                            ForEach(1..<4) { col in
                                let number = row * 3 + col
                                PinCodeButton(number: number) {
                                    handleNumberTap(number)
                                }
                            }
                        }
                    }
                    
                    // Последний ряд: 0 и удаление
                    HStack(spacing: 20) {
                        Spacer()
                            .frame(width: 80)
                        
                        PinCodeButton(number: 0) {
                            handleNumberTap(0)
                        }
                        
                        Button(action: {
                            handleDelete()
                        }) {
                            Image(systemName: "delete.left")
                                .font(.system(size: 24, weight: .regular))
                                .foregroundColor(.black)
                                .frame(width: 80, height: 80)
                                .background(
                                    Circle()
                                        .fill(Color.white.opacity(0.3))
                                        .background(.ultraThinMaterial)
                                )
                        }
                    }
                }
                .padding(.horizontal, 40)
                
                Spacer()
            }
            .padding(.vertical, 40)
        }
        .alert("Помилка", isPresented: $showError) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(errorMessage)
        }
    }
    
    private func handleNumberTap(_ number: Int) {
        if isConfirming {
            if confirmPinCode.count < 4 {
                confirmPinCode.append(number)
                
                if confirmPinCode.count == 4 {
                    if confirmPinCode == pinCode {
                        // Пинкоды совпадают, сохраняем
                        pinCodeManager.savePinCode(pinCode)
                        onComplete()
                    } else {
                        // Пинкоды не совпадают
                        errorMessage = "PIN-коди не співпадають. Спробуйте ще раз."
                        showError = true
                        confirmPinCode = []
                        isConfirming = false
                        pinCode = []
                    }
                }
            }
        } else {
            if pinCode.count < 4 {
                pinCode.append(number)
                
                if pinCode.count == 4 {
                    // Переходим к подтверждению
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        isConfirming = true
                    }
                }
            }
        }
    }
    
    private func handleDelete() {
        if isConfirming {
            if !confirmPinCode.isEmpty {
                confirmPinCode.removeLast()
            }
        } else {
            if !pinCode.isEmpty {
                pinCode.removeLast()
            }
        }
    }
}

// Экран ввода пинкода
struct EnterPinCodeView: View {
    @EnvironmentObject var authManager: AuthManager
    @StateObject private var pinCodeManager = PinCodeManager.shared
    @State private var pinCode: [Int] = []
    @State private var showError = false
    @State private var errorMessage = ""
    @State private var incorrectAttempts = 0
    @State private var showForgotPinAlert = false
    
    private let maxAttempts = 3
    
    let onSuccess: () -> Void
    
    var body: some View {
        ZStack {
            AnimatedGradientBackground()
            
            VStack(spacing: 40) {
                Spacer()
                
                // Заголовок
                VStack(spacing: 8) {
                    Text("Введіть PIN-код")
                        .font(.system(size: 28, weight: .regular, design: .default))
                        .foregroundColor(.black)
                    
                    if incorrectAttempts > 0 {
                        Text("Невірний PIN-код. Залишилось спроб: \(maxAttempts - incorrectAttempts)")
                            .font(.system(size: 14, weight: .regular, design: .default))
                            .foregroundColor(.red)
                    } else {
                        Text("Введіть 4-значний PIN-код")
                            .font(.system(size: 16, weight: .regular, design: .default))
                            .foregroundColor(.black.opacity(0.6))
                    }
                }
                
                // Индикаторы пинкода
                HStack(spacing: 16) {
                    ForEach(0..<4) { index in
                        Circle()
                            .fill(index < pinCode.count ? Color.black : Color.black.opacity(0.2))
                            .frame(width: 16, height: 16)
                    }
                }
                
                // Кнопка "Забули PIN-код?"
                Button(action: {
                    showForgotPinAlert = true
                }) {
                    Text("Забули PIN-код?")
                        .font(.system(size: 16, weight: .regular, design: .default))
                        .foregroundColor(.black.opacity(0.6))
                }
                .padding(.top, 20)
                
                // Клавиатура
                VStack(spacing: 20) {
                    ForEach(0..<3) { row in
                        HStack(spacing: 20) {
                            ForEach(1..<4) { col in
                                let number = row * 3 + col
                                PinCodeButton(number: number) {
                                    handleNumberTap(number)
                                }
                            }
                        }
                    }
                    
                    // Последний ряд: 0 и удаление
                    HStack(spacing: 20) {
                        Spacer()
                            .frame(width: 80)
                        
                        PinCodeButton(number: 0) {
                            handleNumberTap(0)
                        }
                        
                        Button(action: {
                            handleDelete()
                        }) {
                            Image(systemName: "delete.left")
                                .font(.system(size: 24, weight: .regular))
                                .foregroundColor(.black)
                                .frame(width: 80, height: 80)
                                .background(
                                    Circle()
                                        .fill(Color.white.opacity(0.3))
                                        .background(.ultraThinMaterial)
                                )
                        }
                    }
                }
                .padding(.horizontal, 40)
                
                Spacer()
            }
            .padding(.vertical, 40)
        }
        .alert("Помилка", isPresented: $showError) {
            Button("OK", role: .cancel) {
                pinCode = []
            }
        } message: {
            Text(errorMessage)
        }
        .alert("Забули PIN-код?", isPresented: $showForgotPinAlert) {
            Button("Вийти", role: .destructive) {
                pinCodeManager.removePinCode()
                authManager.logout()
            }
            Button("Скасувати", role: .cancel) { }
        } message: {
            Text("Якщо ви забули PIN-код, вам потрібно вийти з акаунту та увійти знову.")
        }
        .onAppear {
            incorrectAttempts = pinCodeManager.getIncorrectAttempts()
        }
    }
    
    private func handleNumberTap(_ number: Int) {
        if pinCode.count < 4 {
            pinCode.append(number)
            
            if pinCode.count == 4 {
                if pinCodeManager.checkPinCode(pinCode) {
                    // Пинкод правильный
                    incorrectAttempts = 0
                    onSuccess()
                } else {
                    // Пинкод неправильный
                    incorrectAttempts = pinCodeManager.getIncorrectAttempts()
                    
                    if incorrectAttempts >= maxAttempts {
                        errorMessage = "Ви вичерпали всі спроби. Будь ласка, вийдіть з акаунту та увійдіть знову."
                        showError = true
                        pinCodeManager.removePinCode()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            authManager.logout()
                        }
                    } else {
                        errorMessage = "Невірний PIN-код. Спробуйте ще раз."
                        showError = true
                        pinCode = []
                    }
                }
            }
        }
    }
    
    private func handleDelete() {
        if !pinCode.isEmpty {
            pinCode.removeLast()
        }
    }
}

// Кнопка для пинкода
struct PinCodeButton: View {
    let number: Int
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text("\(number)")
                .font(.system(size: 28, weight: .regular, design: .default))
                .foregroundColor(.black)
                .frame(width: 80, height: 80)
                .background(
                    Circle()
                        .fill(Color.white.opacity(0.3))
                        .background(.ultraThinMaterial)
                )
        }
    }
}

