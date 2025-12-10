import UIKit
import SwiftUI

// Прямая копия из ios-diia-main
// Если Lottie не подключена, используем fallback
#if canImport(Lottie)
import Lottie
#endif

// Прямая копия из ios-diia-main
protocol SplashScreenView: AnyObject {
    func configureView()
}

final class SplashScreenViewController: UIViewController {
    
    // MARK: - Properties
    var presenter: SplashScreenAction!
    
    // MARK: - Outlet
    private weak var titleLabel: UILabel!
    #if canImport(Lottie)
    private weak var animationView: LottieAnimationView!
    #else
    private weak var animationView: UIView!
    #endif
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        initialSetup()
        presenter?.configureView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        #if canImport(Lottie)
        if let lottieView = animationView as? LottieAnimationView {
            lottieView.play()
        }
        #else
        // Простая анимация для fallback
        animationView?.alpha = 0
        UIView.animate(withDuration: 0.5) {
            self.animationView?.alpha = 1
        }
        #endif
        
        onMainQueueAfter(time: LocalConstants.animationDuration) { [weak self] in
            self?.presenter?.didFinishAnimations()
        }
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        view.backgroundColor = .white
        
        // Background image
        let backgroundImageView = UIImageView()
        backgroundImageView.image = UIImage(named: "light_background")
        backgroundImageView.contentMode = .scaleToFill
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backgroundImageView)
        
        // Title label
        let titleLabel = UILabel()
        titleLabel.text = "Привіт"
        titleLabel.font = UIFont.systemFont(ofSize: 40, weight: .regular)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        self.titleLabel = titleLabel
        
        // Animation view (Lottie или fallback)
        #if canImport(Lottie)
        let animationView = LottieAnimationView()
        // Прямая копия из ios-diia-main - используем splash_cropped.json
        if let animationPath = Bundle.main.path(forResource: "splash_cropped", ofType: "json", inDirectory: "Resources/Animations") {
            animationView.animation = LottieAnimation.filepath(animationPath)
        } else if let animationPath = Bundle.main.path(forResource: "splash_cropped", ofType: "json") {
            animationView.animation = LottieAnimation.filepath(animationPath)
        } else {
            animationView.animationName = "splash_cropped"
        }
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .playOnce
        animationView.backgroundBehavior = .pauseAndRestore
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        self.animationView = animationView
        #else
        // Fallback: используем иконку Дія если Lottie не доступна
        let animationView = UIImageView()
        animationView.image = UIImage(named: "DiiaIcon")
        animationView.contentMode = .scaleAspectFit
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        self.animationView = animationView
        #endif
        
        // Constraints
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -80),
            
            animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            animationView.heightAnchor.constraint(equalToConstant: 128),
            animationView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32)
        ])
    }
    
    private func initialSetup() {
        titleLabel?.font = UIFont.systemFont(ofSize: 40, weight: .regular)
        titleLabel?.text = "Привіт"
        #if canImport(Lottie)
        if let lottieView = animationView as? LottieAnimationView {
            lottieView.loopMode = .playOnce
            lottieView.backgroundBehavior = .pauseAndRestore
        }
        #endif
    }
}

// MARK: - View logic
extension SplashScreenViewController: SplashScreenView {
    func configureView() {
        // Configure view if needed
    }
}

extension SplashScreenViewController {
    private enum LocalConstants {
        static let animationDuration: Double = 3
    }
}

// Helper function
func onMainQueueAfter(time: Double, execute: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + time, execute: execute)
}

// Protocol for presenter
protocol SplashScreenAction: AnyObject {
    func configureView()
    func didFinishAnimations()
}

// Presenter - прямая копия из ios-diia-main
final class SplashScreenPresenter: SplashScreenAction {
    weak var view: SplashScreenView?
    
    private let onFinish: () -> Void
    
    init(view: SplashScreenView, onFinish: @escaping () -> Void) {
        self.view = view
        self.onFinish = onFinish
    }
    
    func configureView() {
        view?.configureView()
    }
    
    func didFinishAnimations() {
        onFinish()
    }
}

// SwiftUI wrapper
struct SplashScreenViewWrapper: UIViewControllerRepresentable {
    let onFinish: () -> Void
    
    func makeUIViewController(context: Context) -> SplashScreenViewController {
        let viewController = SplashScreenViewController()
        let presenter = SplashScreenPresenter(view: viewController, onFinish: onFinish)
        viewController.presenter = presenter
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: SplashScreenViewController, context: Context) {
        // No updates needed
    }
}

