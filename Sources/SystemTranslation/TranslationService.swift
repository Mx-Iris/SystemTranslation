#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit

public typealias NSUIViewController = NSViewController
#endif
#if canImport(UIKit)
import UIKit

public typealias NSUIViewController = UIViewController
#endif

import Foundation
import Translation

@available(macOS 15.0, iOS 18.0, *)
public final class TranslationService {
    public static let shared = TranslationService()

    private var headlessWindow: TranslationHeadlessWindowProtocol

    private var coordinatorByLanguagePairing: [TranslationLanguagePairing: TranslationCoordinator] = [:]

    private var sessionByLanguagePairing: [TranslationLanguagePairing: TranslationSessionBox] = [:]

    private init() {
        self.headlessWindow = TranslationHeadlessWindow.makeWindow()
        headlessWindow.show()
    }

    private func fetchSession(source: TranslationLanguage, target: TranslationLanguage, in viewController: NSUIViewController? = nil) async throws -> TranslationSessionBox {
        let languagePairing = TranslationLanguagePairing(source: source, target: target)
        if let session = sessionByLanguagePairing[languagePairing], !session.isInvalid {
            return session
        }
        let coordinator = if let coordinator = coordinatorByLanguagePairing[languagePairing] {
            coordinator
        } else {
            TranslationCoordinator()
        }
        coordinatorByLanguagePairing[languagePairing] = coordinator

        await MainActor.run {
            if let viewController {
                if let headlessViewController = headlessWindow.uninstallViewController(forLanguagePairing: languagePairing) {
                    viewController.view.addSubview(headlessViewController.view)
                    viewController.addChild(headlessViewController)
                } else {
                    let headlessViewController = TranslationHeadlessViewController(coordinator: coordinator)
                    headlessWindow.addViewController(headlessViewController, forLanguagePairing: languagePairing)
                    viewController.view.addSubview(headlessViewController.view)
                    viewController.addChild(headlessViewController)
                }
            } else {
                if !headlessWindow.isExist(forLanguagePairing: languagePairing) {
                    let headlessViewController = TranslationHeadlessViewController(coordinator: coordinator)
                    headlessWindow.addViewController(headlessViewController, forLanguagePairing: languagePairing)
                }

                if !headlessWindow.isInstalled(forLanguagePairing: languagePairing) {
                    headlessWindow.installViewController(forLanguagePairing: languagePairing)
                }
            }
        }
        coordinator.configuration = .init(sourceLanguage: source, targetLanguage: target)
        let session = try await withCheckedThrowingContinuation { continuation in
            if let session = coordinator.session {
                continuation.resume(returning: session)
            } else {
                coordinator.sessionDidChange = {
                    continuation.resume(returning: $0)
                }
            }
        }
        sessionByLanguagePairing[languagePairing] = session
        return session
    }

    public func translate(_ text: String, source: TranslationLanguage, target: TranslationLanguage) async throws -> String {
        let session = try await fetchSession(source: source, target: target)
        return try await session.session.translate(text).targetText
    }

    public func prepareTranslation(in viewController: NSUIViewController, source: TranslationLanguage, target: TranslationLanguage) async throws {
        let session = try await fetchSession(source: source, target: target, in: viewController)
        try await session.session.prepareTranslation()
    }
}
