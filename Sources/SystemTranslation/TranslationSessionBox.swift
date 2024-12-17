//
//  TranslationSessionBox.swift
//  SystemTranslation
//
//  Created by JH on 12/17/24.
//

import Foundation
import Translation

@available(macOS 15.0, iOS 18.0, *)
struct TranslationSessionBox {
    let session: TranslationSession

    private(set) var isInvalid: Bool = false

    init(session: TranslationSession) {
        self.session = session
    }

    mutating func invalidSession() {
        isInvalid = true
    }
}
