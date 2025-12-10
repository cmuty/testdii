import SwiftUI
import UIKit

// Обертки для оригинальных модулей пинкода из ios-diia-main
// Если библиотека DiiaAuthorizationPinCode доступна - используем оригинальные модули
// Если нет - используем SwiftUI версию

#if canImport(DiiaAuthorizationPinCode)
import DiiaAuthorizationPinCode
import DiiaMVPModule

// SwiftUI обертка для EnterPinCodeModule (прямая копия логики из ios-diia-main)
struct EnterPinCodeModuleWrapper: UIViewControllerRepresentable {
    let onSuccess: () -> Void
    
    func makeUIViewController(context: Context) -> UIViewController {
        let completion: (Result<String, Error>) -> Void = { result in
            guard case .success = result else { return }
            onSuccess()
        }
        
        // Прямая копия из AppRouter.swift - используем EnterPinCodeModuleContext.create
        let moduleContext = EnterPinCodeModuleContext.create(flow: .auth, completionHandler: completion)
        let module = EnterPinCodeModule(
            context: moduleContext,
            flow: .auth,
            viewModel: .auth
        )
        return module.viewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // No updates needed
    }
}

// SwiftUI обертка для CreatePinCodeModule (прямая копия логики из ios-diia-main)
struct CreatePinCodeModuleWrapper: UIViewControllerRepresentable {
    let onComplete: () -> Void
    
    func makeUIViewController(context: Context) -> UIViewController {
        // Прямая копия из AppRouter.swift - preparePinCodeModule
        let viewModel = PinCodeViewModel(
            pinCodeLength: 4, // AppConstants.App.defaultPinCodeLength
            createDetails: "Введіть 4-значний PIN-код для захисту вашого пристрою",
            repeatDetails: "Введіть PIN-код ще раз для підтвердження",
            authFlow: .login,
            completionHandler: { (pincode, view) in
                // Сохраняем пинкод
                PinCodeManager.shared.savePinCode(pincode)
                onComplete()
            }
        )
        
        let module = CreatePinCodeModule(viewModel: viewModel)
        return module.viewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // No updates needed
    }
}

#else
// Если библиотека не доступна - используем SwiftUI версию
typealias EnterPinCodeModuleWrapper = EnterPinCodeView
typealias CreatePinCodeModuleWrapper = CreatePinCodeView
#endif

