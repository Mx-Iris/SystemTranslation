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
    @MainActor
    public static let shared = TranslationService()

    private let languageAvailability = LanguageAvailability()

    private var headlessWindow: TranslationHeadlessWindowProtocol
    
    private var coordinatorByLanguagePairing: [TranslationLanguagePairing: TranslationCoordinator] = [:]

    @MainActor
    private init() {
        self.headlessWindow = TranslationHeadlessWindow.makeWindow()
        headlessWindow.show()
    }

    private func fetchSession(source: TranslationLanguage, target: TranslationLanguage?, in viewController: NSUIViewController? = nil) async throws -> TranslationSessionBox {
        let languagePairing = TranslationLanguagePairing(source: source, target: target)

        let coordinator = if let coordinator = coordinatorByLanguagePairing[languagePairing] {
            coordinator
        } else {
            TranslationCoordinator()
        }

        if let session = coordinator.session, !session.isInvalid {
            print(coordinator.session?.session, coordinator.session?.isInvalid)
            return session
        }

        await MainActor.run {
            coordinatorByLanguagePairing[languagePairing] = coordinator
            if let viewController {
                headlessWindow.uninstallViewController(forLanguagePairing: languagePairing)
                let headlessViewController = TranslationHeadlessViewController(coordinator: coordinator)
                headlessWindow.addViewController(headlessViewController, forLanguagePairing: languagePairing)
                viewController.view.addSubview(headlessViewController.view)
                viewController.addChild(headlessViewController)
            } else {
                if !headlessWindow.isExist(forLanguagePairing: languagePairing) {
                    let headlessViewController = TranslationHeadlessViewController(coordinator: coordinator)
                    headlessWindow.addViewController(headlessViewController, forLanguagePairing: languagePairing)
                }

                if !headlessWindow.isInstalled(forLanguagePairing: languagePairing) {
                    headlessWindow.installViewController(forLanguagePairing: languagePairing)
                }
            }
            coordinator.configuration = nil
            coordinator.configuration = .init(languagePairing: languagePairing)
        }
        let session = try await withCheckedThrowingContinuation { continuation in
            if let session = coordinator.session, !session.isInvalid {
                continuation.resume(returning: session)
            } else {
                coordinator.sessionDidChange = {
                    continuation.resume(returning: $0)
                }
            }
        }
        return session
    }

    public func translate(_ text: String, source: TranslationLanguage, target: TranslationLanguage?) async throws -> String {
        let session = try await fetchSession(source: source, target: target)
        return try await session.session.translate(text).targetText
    }

    public func prepareTranslation(in viewController: NSUIViewController, source: TranslationLanguage, target: TranslationLanguage?) async throws {
        let session = try await fetchSession(source: source, target: target, in: viewController)
        try await session.session.prepareTranslation()
        await MainActor.run {
            let languagePairing = TranslationLanguagePairing(source: source, target: target)
            headlessWindow.uninstallViewController(forLanguagePairing: languagePairing)
        }
    }

    public var languageDownloadStatuses: [TranslationLanguageDownloadStatus] {
        get async {
            await withTaskGroup(of: TranslationLanguageDownloadStatus.self) { group in
                for language in TranslationLanguage.allCases {
                    group.addTask {
                        let status = await self.languageAvailability.status(from: language.localeLanguage, to: nil)
                        let isDownloaded: Bool
                        switch status {
                        case .installed:
                            isDownloaded = true
                        default:
                            isDownloaded = false
                        }
                        return TranslationLanguageDownloadStatus(language: language, isDownloaded: isDownloaded)
                    }
                }
                var results: [TranslationLanguageDownloadStatus] = []
                for await result in group {
                    results.append(result)
                }
                results.sort(using: SortDescriptor(\.language.friendlyName, order: .forward))
                return results
            }
        }
    }
}
