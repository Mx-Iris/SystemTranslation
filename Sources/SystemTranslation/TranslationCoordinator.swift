//
//  TranslationCoordinator.swift
//  SystemTranslation
//
//  Created by JH on 12/17/24.
//

import SwiftUI
import Foundation
import Translation

@available(macOS 15.0, iOS 18.0, *)
class TranslationCoordinator: ObservableObject {
    @Published
    var configuration: TranslationSession.Configuration?

    var session: TranslationSessionBox?

    var sessionDidChange: (TranslationSessionBox) -> Void = { _ in }
}
