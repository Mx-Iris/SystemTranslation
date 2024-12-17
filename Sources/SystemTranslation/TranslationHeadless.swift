import Foundation

@available(macOS 15.0, iOS 18.0, *)
protocol TranslationHeadlessViewControllerProtocol: NSUIViewController {}

@available(macOS 15.0, iOS 18.0, *)
protocol TranslationHeadlessWindowProtocol: AnyObject {
    ///    associatedtype ViewController: TranslationHeadlessViewControllerProtocol
    typealias ViewController = TranslationHeadlessViewControllerProtocol
    var contentViewController: NSUIViewController? { get }
    var viewControllerByLanguagePairing: [TranslationLanguagePairing: ViewController] { get set }
    static func makeWindow() -> Self
    func show()
}

@available(macOS 15.0, iOS 18.0, *)
extension TranslationHeadlessWindowProtocol {
    func addViewController(_ viewController: ViewController, forLanguagePairing languagePairing: TranslationLanguagePairing) {
        viewControllerByLanguagePairing[languagePairing] = viewController
    }

    func isExist(forLanguagePairing languagePairing: TranslationLanguagePairing) -> Bool {
        viewControllerByLanguagePairing[languagePairing] != nil
    }

    func isInstalled(forLanguagePairing languagePairing: TranslationLanguagePairing) -> Bool {
        guard let viewController = viewControllerByLanguagePairing[languagePairing] else { return false }
        return viewController.parent != nil && viewController.view.superview != nil
    }

    @discardableResult
    func installViewController(forLanguagePairing languagePairing: TranslationLanguagePairing) -> Bool {
        guard let viewController = viewControllerByLanguagePairing[languagePairing] else { return false }
        contentViewController?.view.addSubview(viewController.view)
        contentViewController?.addChild(viewController)
        return true
    }

    func uninstallViewController(forLanguagePairing languagePairing: TranslationLanguagePairing) -> ViewController? {
        let viewController = viewControllerByLanguagePairing[languagePairing]
        viewController?.view.removeFromSuperview()
        viewController?.removeFromParent()
        return viewController
    }
}
