//
//  TranslationLanguage.swift
//  SystemTranslation
//
//  Created by JH on 12/17/24.
//

import Foundation

@available(macOS 15.0, iOS 18.0, *)
public enum TranslationLanguage: String, CaseIterable, Hashable, Codable {
    case arabic = "ar"
    case chineseSimplified = "zh-Hans"
    case chineseTraditional = "zh-Hant"
    case dutch = "nl"
    case englishUK = "en-GB"
    case englishUS = "en-US"
    case french = "fr"
    case german = "de"
    case hindi = "hi"
    case indonesian = "id"
    case italian = "it"
    case japanese = "ja"
    case korean = "ko"
    case polish = "pl"
    case portugueseBrazil = "pt-BR"
    case russian = "ru"
    case spanishSpain = "es-ES"
    case thai = "th"
    case turkish = "tr"
    case ukrainian = "uk"

    /// Returns a friendly name for the language to be displayed in the table view.
    public var friendlyName: String {
        switch self {
        case .arabic: return "Arabic"
        case .chineseSimplified: return "Chinese (Simplified)"
        case .chineseTraditional: return "Chinese (Traditional)"
        case .dutch: return "Dutch"
        case .englishUK: return "English (UK)"
        case .englishUS: return "English (US)"
        case .french: return "French"
        case .german: return "German"
        case .hindi: return "Hindi"
        case .indonesian: return "Indonesian"
        case .italian: return "Italian"
        case .japanese: return "Japanese"
        case .korean: return "Korean"
        case .polish: return "Polish"
        case .portugueseBrazil: return "Portuguese (Brazil)"
        case .russian: return "Russian"
        case .spanishSpain: return "Spanish (Spain)"
        case .thai: return "Thai"
        case .turkish: return "Turkish"
        case .ukrainian: return "Ukrainian"
        }
    }

    /// Returns the flag of the country in which the language is mostly used.
    public var flag: String {
        switch self {
        case .arabic: return "🇸🇦"
        case .chineseSimplified: return "🇨🇳"
        case .chineseTraditional: return "🇨🇳"
        case .dutch: return "🇳🇱"
        case .englishUK: return "🇬🇧"
        case .englishUS: return "🇺🇸"
        case .french: return "🇫🇷"
        case .german: return "🇩🇪"
        case .hindi: return "🇮🇳"
        case .indonesian: return "🇮🇩"
        case .italian: return "🇮🇹"
        case .japanese: return "🇯🇵"
        case .korean: return "🇰🇷"
        case .polish: return "🇷🇺"
        case .portugueseBrazil: return "🇧🇷"
        case .russian: return "🇷🇺"
        case .spanishSpain: return "🇪🇸"
        case .thai: return "🇹🇭"
        case .turkish: return "🇹🇷"
        case .ukrainian: return "🇺🇦"
        }
    }

    public var title: String {
        "\(flag) \(friendlyName)"
    }

    public var localeLanguage: Locale.Language {
        .init(identifier: rawValue)
    }
}

@available(macOS 15.0, iOS 18.0, *)
extension TranslationLanguage: Comparable {
    public static func < (lhs: TranslationLanguage, rhs: TranslationLanguage) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}

@available(macOS 15.0, iOS 18.0, *)
extension TranslationLanguage: Identifiable {
    public var id: Self { self }
}
