//
//  TranslationLanguagePairing.swift
//  SystemTranslation
//
//  Created by JH on 12/17/24.
//

import Foundation
import Translation

@available(macOS 15.0, iOS 18.0, *)
struct TranslationLanguagePairing: Hashable {
    let source: TranslationLanguage
    let target: TranslationLanguage
    init(source: TranslationLanguage, target: TranslationLanguage) {
        self.source = source
        self.target = target
    }
}

@available(macOS 15.0, iOS 18.0, *)
extension TranslationSession.Configuration {
    init(sourceLanguage: TranslationLanguage, targetLanguage: TranslationLanguage) {
        self.init(source: sourceLanguage.localeLanguage, target: targetLanguage.localeLanguage)
    }
}
