//
//  TranslationLanguagePackage.swift
//  SystemTranslation
//
//  Created by JH on 2024/12/18.
//

import Foundation

@available(macOS 15.0, *)
public struct TranslationLanguageDownloadStatus: Hashable {
    public let language: TranslationLanguage
    public internal(set) var isDownloaded: Bool
}
