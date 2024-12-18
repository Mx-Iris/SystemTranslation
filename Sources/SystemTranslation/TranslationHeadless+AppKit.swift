#if canImport(AppKit) && !targetEnvironment(macCatalyst)

import AppKit
import SwiftUI

@available(macOS 15.0, *)
final class TranslationHeadlessWindow: NSWindow, TranslationHeadlessWindowProtocol {
    func show() {
        makeKeyAndOrderFront(nil)
    }
    
    static func makeWindow() -> Self {
        .init()
    }
    
    class ContentViewController: NSViewController {
        override func loadView() {
            view = NSView()
        }
    }
    
    var viewControllerByLanguagePairing: [TranslationLanguagePairing: TranslationHeadlessViewControllerProtocol] = [:]
    
    init() {
        super.init(contentRect: .zero, styleMask: [], backing: .buffered, defer: false)
        contentViewController = ContentViewController()
    }
}

@available(macOS 15.0, *)
class TranslationHeadlessViewController: NSHostingController<TranslationHeadlessSwiftUIView>, TranslationHeadlessViewControllerProtocol {
    let coordinator: TranslationCoordinator

    init(coordinator: TranslationCoordinator) {
        self.coordinator = coordinator
        super.init(rootView: .init(coordinator: coordinator))
    }

    override func viewWillDisappear() {
        super.viewWillDisappear()
        coordinator.session?.invalidSession()
        coordinator.session = nil
    }
    
    @available(*, unavailable)
    @MainActor @preconcurrency dynamic required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
#endif
