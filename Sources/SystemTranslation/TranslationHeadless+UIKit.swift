#if canImport(UIKit)

import UIKit
import SwiftUI

@available(iOS 18.0, *)
final class TranslationHeadlessWindow: UIWindow, TranslationHeadlessWindowProtocol {
    
    static func makeWindow() -> Self {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            return .init(windowScene: windowScene)
        } else {
            return .init(frame: UIScreen.main.bounds)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    override init(windowScene: UIWindowScene) {
        super.init(windowScene: windowScene)
        commonInit()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    class ContentViewController: UIViewController {
        override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
            super.init(nibName: nil, bundle: nil)
            view.isUserInteractionEnabled = false
            view.backgroundColor = .clear
            view.isOpaque = false
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
    func commonInit() {
        rootViewController = ContentViewController()
        backgroundColor = .clear
        isUserInteractionEnabled = false
        isOpaque = false
    }
    
    var viewControllerByLanguagePairing: [TranslationLanguagePairing: TranslationHeadlessViewControllerProtocol] = [:]

    var contentViewController: NSUIViewController? { rootViewController }
    
    func show() {
        makeKeyAndVisible()
    }
}

@available(iOS 18.0, *)
class TranslationHeadlessViewController: UIHostingController<TranslationHeadlessSwiftUIView>, TranslationHeadlessViewControllerProtocol {
    let coordinator: TranslationCoordinator
    init(coordinator: TranslationCoordinator) {
        self.coordinator = coordinator
        super.init(rootView: .init(coordinator: coordinator))
    }

    @available(*, unavailable)
    @MainActor @preconcurrency dynamic required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        coordinator.session?.invalidSession()
    }
}

#endif
