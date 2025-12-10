import Foundation
import SwiftUI

// Прямая копия из ios-diia-main - EnterPinCodeModuleContext+Extension.swift
// Адаптировано для работы без библиотеки DiiaAuthorizationPinCode

#if canImport(DiiaAuthorizationPinCode)
import DiiaAuthorizationPinCode
import DiiaMVPModule

extension EnterPinCodeModuleContext {
    static func create(flow: EnterPinCodeFlow, completionHandler: @escaping (Result<String, Error>) -> Void) -> EnterPinCodeModuleContext {
        let delegate: EnterPinCodeDelegate
        switch flow {
        case .auth:
            delegate = EnterPinCodeAuthDelegate(completionHandler: completionHandler)
        case .diiaId:
            delegate = EnterPinCodeDefaultDelegate(completionHandler: completionHandler)
        }
        
        // Используем PinCodeStorage адаптированный для UserDefaults
        let storage = PinCodeStorageAdapter()
        return EnterPinCodeModuleContext(storage: storage, enterPinCodeDelegate: delegate)
    }
}

final class EnterPinCodeDefaultDelegate: EnterPinCodeDelegate {
    init(completionHandler: @escaping (Result<String, Error>) -> Void) {
    }
    
    func onForgotPincode(in view: BaseView) {}
    func didAllAttemptsExhausted(in view: BaseView) {}
    func checkPincode(_ pincode: [Int]) -> Bool {
        return false
    }
    func didCorrectPincodeEntered(pincode: String) {}
}

// Адаптер для PinCodeStorageProtocol используя UserDefaults
struct PinCodeStorageAdapter: PinCodeStorageProtocol {
    private let userDefaults = UserDefaults.standard
    
    func getIsBiometryEnabled() -> Bool? {
        return userDefaults.bool(forKey: "isBiometryEnabled") ? true : nil
    }
    
    func getIncorrectPincodeAttemptsCount(flow: EnterPinCodeFlow) -> Int? {
        switch flow {
        case .auth:
            let count = userDefaults.integer(forKey: "incorrectPinCodeAttempts")
            return count > 0 ? count : nil
        case .diiaId:
            return nil
        }
    }
    
    func saveIncorrectPincodeAttemptsCount(_ value: Int, flow: EnterPinCodeFlow) {
        switch flow {
        case .auth:
            userDefaults.set(value, forKey: "incorrectPinCodeAttempts")
        case .diiaId:
            break
        }
    }
}

#endif

