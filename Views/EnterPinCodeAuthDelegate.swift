import Foundation
import SwiftUI

#if canImport(DiiaAuthorizationPinCode)
import DiiaAuthorizationPinCode
import DiiaMVPModule
import DiiaUIComponents

// Прямая копия из ios-diia-main - EnterPinCodeAuthDelegate
final class EnterPinCodeAuthDelegate: EnterPinCodeDelegate {
    // MARK: - Private properties
    private let completionHandler: (Result<String, Error>) -> Void
    private let pinCodeManager = PinCodeManager.shared

    // MARK: - Initialization
    init(completionHandler: @escaping (Result<String, Error>) -> Void) {
        self.completionHandler = completionHandler
    }
    
    // MARK: - EnterPinCodeDelegate
    func checkPincode(_ pincode: [Int]) -> Bool {
        return pinCodeManager.checkPinCode(pincode)
    }
    
    func onForgotPincode(in view: BaseView) {
        // В оригинале показывается алерт через CustomAlertModule
        // Для SwiftUI используем упрощенную версию
        let actions = [
            AlertAction(
                title: "Авторизуватися",
                type: .destructive,
                callback: {
                    // Logout будет обработан в SwiftUI
                }
            ),
            AlertAction(
                title: "Скасувати",
                type: .normal,
                callback: {}
            )
        ]
        // В оригинале: let module = CustomAlertModule(...)
        // Для SwiftUI это будет обработано через alert
    }
    
    func didAllAttemptsExhausted(in view: BaseView) {
        pinCodeManager.removePinCode()
        // В оригинале показывается алерт
    }
    
    func didCorrectPincodeEntered(pincode: String) {
        completionHandler(.success(pincode))
    }
}

#else
// Fallback версия без библиотеки
final class EnterPinCodeAuthDelegate {
    private let completionHandler: (Result<String, Error>) -> Void
    private let pinCodeManager = PinCodeManager.shared

    init(completionHandler: @escaping (Result<String, Error>) -> Void) {
        self.completionHandler = completionHandler
    }
    
    func checkPincode(_ pincode: [Int]) -> Bool {
        return pinCodeManager.checkPinCode(pincode)
    }
    
    func didCorrectPincodeEntered(pincode: String) {
        completionHandler(.success(pincode))
    }
}
#endif

