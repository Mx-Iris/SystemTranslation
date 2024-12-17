#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit
public typealias NSUIViewController = NSViewController
#endif
#if canImport(UIKit)
import UIKit
public typealias NSUIViewController = UIViewController
#endif
import SwiftUI
import Combine
import Foundation
import Translation

@available(macOS 15.0, iOS 18.0, *)
public enum TranslationLanguage: String, CaseIterable, Hashable, Codable {
    case afrikaans = "af"
    case albanian = "sq"
    case amharic = "am"
    case arabic = "ar"
    case armenian = "hy"
    case bambara = "bm"
    case bengali = "bn"
    case bislama = "bi"
    case bulgarian = "bg"
    case burmeseMyanmar = "my"
    case catalan = "ca"
    case cebuano = "ceb"
    case chewa = "ny"
    case chineseHongKong = "zh-HK"
    case chinesePRC = "zh-CN"
    case chineseSimplified = "zh-Hans"
    case chineseSimplifiedPRC = "zh-Hans-CN"
    case chineseTaiwan = "zh-TW"
    case chineseTraditional = "zh-Hant"
    case chineseTraditionalHongKong = "zh-Hant-HK"
    case chineseTraditionalTaiwan = "zh-Hant-TW"
    case chuukese = "chk"
    case croatian = "hr"
    case czech = "cs"
    case danish = "da"
    case dutch = "nl"
    case efik = "efi"
    case english = "en"
    case englishAustralia = "en-AU"
    case englishCanada = "en-CA"
    case englishIndia = "en-IN"
    case englishUK = "en-GB"
    case englishUS = "en-US"
    case estonian = "et"
    case fanti = "fat"
    case fijian = "fj"
    case filipino = "fil"
    case finnish = "fi"
    case fon
    case french = "fr"
    case frenchCanada = "fr-CA"
    case frenchFrance = "fr-FR"
    case georgian = "ka"
    case german = "de"
    case greek = "el"
    case guarani = "gn"
    case haitianCreole = "ht"
    case hebrew = "he"
    case hiligaynon = "hil"
    case hindi = "hi"
    case hindiFiji = "hif"
    case hmong = "hmn"
    case hungarian = "hu"
    case iban = "iba"
    case icelandic = "is"
    case igbo = "ig"
    case iloko = "ilo"
    case indonesian = "id"
    case italian = "it"
    case japanese = "ja"
    case kamba = "kam"
    case kannada = "kn"
    case karenSgaw = "ksw"
    case kazakh = "kk"
    case kekchí = "kek"
    case khmer = "km"
    case kinyarwanda = "rw"
    case kiribatiGilbertese = "gil"
    case korean = "ko"
    case kosraean = "kos"
    case kurdishCentral = "ckb"
    case lao = "lo"
    case latvian = "lv"
    case lingala = "ln"
    case lithuanian = "lt"
    case macedonian = "mk"
    case malagasy = "mg"
    case malay = "ms"
    case malayalam = "ml"
    case maltese = "mt"
    case marshallese = "mh"
    case mongolian = "mn"
    case navajo = "nv"
    case nepali = "ne"
    case nivaclé = "cag"
    case norwegian = "no"
    case norwegianBokmal = "nb"
    case palauan = "pau"
    case persianFarsi = "fa"
    case pohnpeian = "pon"
    case polish = "pl"
    case portuguese = "pt"
    case portugueseBrazil = "pt-BR"
    case portuguesePortugal = "pt-PT"
    case romanian = "ro"
    case russian = "ru"
    case samoan = "sm"
    case serbian = "sr"
    case shona = "sn"
    case sinhala = "si"
    case slovak = "sk"
    case slovenian = "sl"
    case sothoSouthern = "st"
    case spanish = "es"
    case spanishLatinAmerica = "es-419"
    case spanishMexico = "es-MX"
    case spanishSpain = "es-ES"
    case spanishUS = "es-US"
    case swahili = "sw"
    case swati = "ss"
    case swedish = "sv"
    case tagalog = "tl"
    case tahitian = "ty"
    case tamil = "ta"
    case telugu = "te"
    case thai = "th"
    case tokPisin = "tpi"
    case tongan = "to"
    case tshiluba = "lua"
    case tswana = "tn"
    case turkish = "tr"
    case twi = "tw"
    case ukrainian = "uk"
    case urdu = "ur"
    case vietnamese = "vi"
    case welsh = "cy"
    case xhosa = "xh"
    case yapese = "yap"
    case yoruba = "yo"
    case zulu = "zu"

    /// Returns a friendly name for the language to be displayed in the table view.
    public var friendlyName: String {
        switch self {
        case .afrikaans: return "Afrikaans"
        case .albanian: return "Albanian"
        case .amharic: return "Amharic"
        case .arabic: return "Arabic"
        case .armenian: return "Armenian"
        case .bambara: return "Bambara"
        case .bengali: return "Bengali"
        case .bislama: return "Bislama"
        case .bulgarian: return "Bulgarian"
        case .burmeseMyanmar: return "Burmese (Myanmar)"
        case .catalan: return "Catalan"
        case .cebuano: return "Cebuano"
        case .chewa: return "Chewa"
        case .chineseHongKong: return "Chinese (Hong Kong)"
        case .chinesePRC: return "Chinese (PRC)"
        case .chineseSimplified: return "Chinese (Simplified)"
        case .chineseSimplifiedPRC: return "Chinese (Simplified, China)"
        case .chineseTaiwan: return "Chinese (Taiwan)"
        case .chineseTraditional: return "Chinese (Traditional)"
        case .chineseTraditionalHongKong: return "Chinese (Traditional, Hong Kong)"
        case .chineseTraditionalTaiwan: return "Chinese (Traditional, Taiwan)"
        case .chuukese: return "Chuukese"
        case .croatian: return "Croatian"
        case .czech: return "Czech"
        case .danish: return "Danish"
        case .dutch: return "Dutch"
        case .efik: return "Efik"
        case .english: return "English"
        case .englishAustralia: return "English (Australia)"
        case .englishCanada: return "English (Canada)"
        case .englishIndia: return "English (India)"
        case .englishUK: return "English (UK)"
        case .englishUS: return "English (US)"
        case .estonian: return "Estonian"
        case .fanti: return "Fanti"
        case .fijian: return "Fijian"
        case .filipino: return "Filipino"
        case .finnish: return "Finnish"
        case .fon: return "Fon"
        case .french: return "French"
        case .frenchCanada: return "French (Canada)"
        case .frenchFrance: return "French (France)"
        case .georgian: return "Georgian"
        case .german: return "German"
        case .greek: return "Greek"
        case .guarani: return "Guarani"
        case .haitianCreole: return "Haitian Creole"
        case .hebrew: return "Hebrew"
        case .hiligaynon: return "Hiligaynon"
        case .hindi: return "Hindi"
        case .hindiFiji: return "Hindi (Fiji)"
        case .hmong: return "Hmong"
        case .hungarian: return "Hungarian"
        case .iban: return "Iban"
        case .icelandic: return "Icelandic"
        case .igbo: return "Igbo"
        case .iloko: return "Iloko"
        case .indonesian: return "Indonesian"
        case .italian: return "Italian"
        case .japanese: return "Japanese"
        case .kamba: return "Kamba"
        case .kannada: return "Kannada"
        case .karenSgaw: return "Karen (S’gaw)"
        case .kazakh: return "Kazakh"
        case .kekchí: return "Kekchí"
        case .khmer: return "Khmer"
        case .kinyarwanda: return "Kinyarwanda"
        case .kiribatiGilbertese: return "Kiribati (Gilbertese)"
        case .korean: return "Korean"
        case .kosraean: return "Kosraean"
        case .kurdishCentral: return "Kurdish (Central)"
        case .lao: return "Lao"
        case .latvian: return "Latvian"
        case .lingala: return "Lingala"
        case .lithuanian: return "Lithuanian"
        case .macedonian: return "Macedonian"
        case .malagasy: return "Malagasy"
        case .malay: return "Malay"
        case .malayalam: return "Malayalam"
        case .maltese: return "Maltese"
        case .marshallese: return "Marshallese"
        case .mongolian: return "Mongolian"
        case .navajo: return "Navajo"
        case .nepali: return "Nepali"
        case .nivaclé: return "Nivaclé"
        case .norwegian: return "Norwegian"
        case .norwegianBokmal: return "Norwegian Bokmål"
        case .palauan: return "Palauan"
        case .persianFarsi: return "Persian (Farsi)"
        case .pohnpeian: return "Pohnpeian"
        case .polish: return "Polish"
        case .portuguese: return "Portuguese"
        case .portugueseBrazil: return "Portuguese (Brazil)"
        case .portuguesePortugal: return "Portuguese (Portugal)"
        case .romanian: return "Romanian"
        case .russian: return "Russian"
        case .samoan: return "Samoan"
        case .serbian: return "Serbian"
        case .shona: return "Shona"
        case .sinhala: return "Sinhala"
        case .slovak: return "Slovak"
        case .slovenian: return "Slovenian"
        case .sothoSouthern: return "Sotho (Southern)"
        case .spanish: return "Spanish"
        case .spanishLatinAmerica: return "Spanish (Latin America)"
        case .spanishMexico: return "Spanish (Mexico)"
        case .spanishSpain: return "Spanish (Spain)"
        case .spanishUS: return "Spanish (US)"
        case .swahili: return "Swahili"
        case .swati: return "Swati"
        case .swedish: return "Swedish"
        case .tagalog: return "Tagalog"
        case .tahitian: return "Tahitian"
        case .tamil: return "Tamil"
        case .telugu: return "Telugu"
        case .thai: return "Thai"
        case .tokPisin: return "Tok Pisin"
        case .tongan: return "Tongan"
        case .tshiluba: return "Tshiluba"
        case .tswana: return "Tswana"
        case .turkish: return "Turkish"
        case .twi: return "Twi"
        case .ukrainian: return "Ukrainian"
        case .urdu: return "Urdu"
        case .vietnamese: return "Vietnamese"
        case .welsh: return "Welsh"
        case .xhosa: return "Xhosa"
        case .yapese: return "Yapese"
        case .yoruba: return "Yoruba"
        case .zulu: return "Zulu"
        }
    }

    /// Returns the flag of the country in which the language is mostly used.
    public var flag: String {
        switch self {
        case .afrikaans: return "🇿🇦"
        case .albanian: return "🇦🇱"
        case .amharic: return "🇪🇹"
        case .arabic: return "🇸🇦"
        case .armenian: return "🇦🇲"
        case .bambara: return "🇲🇱"
        case .bengali: return "🇮🇳"
        case .bislama: return "🇻🇺"
        case .bulgarian: return "🇧🇬"
        case .burmeseMyanmar: return "🇲🇲"
        case .catalan: return "🇪🇸"
        case .cebuano: return "🇵🇭"
        case .chewa: return "🇲🇼"
        case .chineseHongKong: return "🇭🇰"
        case .chinesePRC: return "🇨🇳"
        case .chineseSimplified: return "🇨🇳"
        case .chineseSimplifiedPRC: return "🇨🇳"
        case .chineseTaiwan: return "🇨🇳"
        case .chineseTraditional: return "🇨🇳"
        case .chineseTraditionalHongKong: return "🇭🇰"
        case .chineseTraditionalTaiwan: return "🇨🇳"
        case .chuukese: return "🇫🇲"
        case .croatian: return "🇭🇷"
        case .czech: return "🇨🇿"
        case .danish: return "🇩🇰"
        case .dutch: return "🇳🇱"
        case .efik: return "🇳🇬"
        case .english: return "🇺🇸"
        case .englishAustralia: return "🇦🇺"
        case .englishCanada: return "🇨🇦"
        case .englishIndia: return "🇮🇳"
        case .englishUK: return "🇬🇧"
        case .englishUS: return "🇺🇸"
        case .estonian: return "🇪🇪"
        case .fanti: return "🇬🇭"
        case .fijian: return "🇫🇯"
        case .filipino: return "🇵🇭"
        case .finnish: return "🇫🇮"
        case .fon: return "🇧🇯"
        case .french: return "🇫🇷"
        case .frenchCanada: return "🇨🇦"
        case .frenchFrance: return "🇫🇷"
        case .georgian: return "🇬🇪"
        case .german: return "🇩🇪"
        case .greek: return "🇬🇷"
        case .guarani: return "🇵🇾"
        case .haitianCreole: return "🇭🇹"
        case .hebrew: return "🇮🇱"
        case .hiligaynon: return "🇵🇭"
        case .hindi: return "🇮🇳"
        case .hindiFiji: return "🇫🇯"
        case .hmong: return "🇨🇳"
        case .hungarian: return "🇭🇺"
        case .iban: return "🇧🇳"
        case .icelandic: return "🇮🇸"
        case .igbo: return "🇳🇬"
        case .iloko: return "🇵🇭"
        case .indonesian: return "🇮🇩"
        case .italian: return "🇮🇹"
        case .japanese: return "🇯🇵"
        case .kamba: return "🇰🇪"
        case .kannada: return "🇮🇳"
        case .karenSgaw: return "🇲🇲"
        case .kazakh: return "🇰🇿"
        case .kekchí: return "🇬🇹"
        case .khmer: return "🇰🇭"
        case .kinyarwanda: return "🇷🇼"
        case .kiribatiGilbertese: return "🇰🇮"
        case .korean: return "🇰🇷"
        case .kosraean: return "🇫🇲"
        case .kurdishCentral: return "🇮🇶"
        case .lao: return "🇱🇦"
        case .latvian: return "🇱🇻"
        case .lingala: return "🇨🇩"
        case .lithuanian: return "🇱🇹"
        case .macedonian: return "🇲🇰"
        case .malagasy: return "🇲🇬"
        case .malay: return "🇲🇾"
        case .malayalam: return "🇮🇳"
        case .maltese: return "🇲🇹"
        case .marshallese: return "🇲🇭"
        case .mongolian: return "🇲🇳"
        case .navajo: return "🇺🇸"
        case .nepali: return "🇳🇵"
        case .nivaclé: return "🇵🇾"
        case .norwegian: return "🇳🇴"
        case .norwegianBokmal: return "🇳🇴"
        case .palauan: return "🇵🇼"
        case .persianFarsi: return "🇮🇷"
        case .pohnpeian: return "🇫🇲"
        case .polish: return "🇷🇺"
        case .portuguese: return "🇵🇹"
        case .portugueseBrazil: return "🇧🇷"
        case .portuguesePortugal: return "🇵🇹"
        case .romanian: return "🇷🇴"
        case .russian: return "🇷🇺"
        case .samoan: return "🇼🇸"
        case .serbian: return "🇷🇸"
        case .shona: return "🇿🇼"
        case .sinhala: return "🇱🇰"
        case .slovak: return "🇸🇰"
        case .slovenian: return "🇸🇮"
        case .sothoSouthern: return "🇱🇸"
        case .spanish: return "🇪🇸"
        case .spanishLatinAmerica: return "🇨🇴"
        case .spanishMexico: return "🇲🇽"
        case .spanishSpain: return "🇪🇸"
        case .spanishUS: return "🇺🇸"
        case .swahili: return "🇹🇿"
        case .swati: return "🇵🇰"
        case .swedish: return "🇸🇪"
        case .tagalog: return "🇵🇭"
        case .tahitian: return "🇵🇫"
        case .tamil: return "🇮🇳"
        case .telugu: return "🇮🇳"
        case .thai: return "🇹🇭"
        case .tokPisin: return "🇵🇬"
        case .tongan: return "🇹🇴"
        case .tshiluba: return "🇨🇩"
        case .tswana: return "🇧🇼"
        case .turkish: return "🇹🇷"
        case .twi: return "🇬🇭"
        case .ukrainian: return "🇺🇦"
        case .urdu: return "🇵🇰"
        case .vietnamese: return "🇻🇳"
        case .welsh: return "🏴󠁧󠁢󠁷󠁬󠁳󠁿"
        case .xhosa: return "🇿🇦"
        case .yapese: return "🇫🇲"
        case .yoruba: return "🇳🇬"
        case .zulu: return "🇿🇦"
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

@available(macOS 15.0, iOS 18.0, *)
struct TranslationLanguagePair: Hashable {
    let source: TranslationLanguage
    let target: TranslationLanguage
    init(source: TranslationLanguage, target: TranslationLanguage) {
        self.source = source
        self.target = target
    }
}

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

@available(macOS 15.0, iOS 18.0, *)
public final class TranslationService {
    public static let shared = TranslationService()

    private var headlessWindow: TranslationHeadlessWindow

    private var coordinatorByLanguagePair: [TranslationLanguagePair: TranslationCoordinator] = [:]

    private var sessionByLanguagePair: [TranslationLanguagePair: TranslationSessionBox] = [:]

    private init() {
        #if canImport(AppKit) && !targetEnvironment(macCatalyst)
        headlessWindow = .init()
        headlessWindow.makeKeyAndOrderFront(nil)
        #endif

        #if canImport(UIKit)
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            headlessWindow = .init(windowScene: windowScene)
        } else {
            headlessWindow = .init(frame: UIScreen.main.bounds)
        }
        headlessWindow.makeKeyAndVisible()
        #endif
    }

    private func fetchSession(source: TranslationLanguage, target: TranslationLanguage, in viewController: NSUIViewController? = nil) async throws -> TranslationSessionBox {
        let languagePair = TranslationLanguagePair(source: source, target: target)
        if let session = sessionByLanguagePair[languagePair], !session.isInvalid {
            return session
        }
        let coordinator = if let coordinator = coordinatorByLanguagePair[languagePair] {
            coordinator
        } else {
            TranslationCoordinator()
        }
        coordinatorByLanguagePair[languagePair] = coordinator
        
        await MainActor.run {

            if let viewController {
                if let headlessViewController = headlessWindow.uninstallViewController(forLanguagePair: languagePair) {
                    viewController.view.addSubview(headlessViewController.view)
                    viewController.addChild(headlessViewController)
                } else {
                    let headlessViewController = TranslationHeadlessViewController(coordinator: coordinator)
                    headlessWindow.addViewController(headlessViewController, forLanguagePair: languagePair)
                    viewController.view.addSubview(headlessViewController.view)
                    viewController.addChild(headlessViewController)
                }
            } else {
                if !headlessWindow.isExist(forLanguagePair: languagePair) {
                    let headlessViewController = TranslationHeadlessViewController(coordinator: coordinator)
                    headlessWindow.addViewController(headlessViewController, forLanguagePair: languagePair)
                }
                
                if !headlessWindow.isInstalled(forLanguagePair: languagePair) {
                    headlessWindow.installViewController(forLanguagePair: languagePair)
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
        sessionByLanguagePair[languagePair] = session
        return session
    }

    public func translate(_ text: String, source: TranslationLanguage, target: TranslationLanguage) async throws -> String {
        let session = try await fetchSession(source: source, target: target)
        return try await session.session.translate(text).targetText
    }

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
    public func prepareTranslation(in viewController: NSUIViewController, source: TranslationLanguage, target: TranslationLanguage) async throws {
        let session = try await fetchSession(source: source, target: target, in: viewController)
        try await session.session.prepareTranslation()
    }
#endif
    
#if canImport(UIKit)
    public func prepareTranslation(source: TranslationLanguage, target: TranslationLanguage) async throws {
        let session = try await fetchSession(source: source, target: target)
        try await session.session.prepareTranslation()
    }
#endif
}

@available(macOS 15.0, iOS 18.0, *)
extension TranslationSession.Configuration {
    init(sourceLanguage: TranslationLanguage, targetLanguage: TranslationLanguage) {
        self.init(source: sourceLanguage.localeLanguage, target: targetLanguage.localeLanguage)
    }
}

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
@available(macOS 15.0, *)
class TranslationHeadlessWindow: NSWindow {
    
    class ContentViewController: NSViewController {
        override func loadView() {
            view = NSView()
        }
    }
    
    var viewControllerByLanguagePair: [TranslationLanguagePair: TranslationHeadlessViewController] = [:]
    
    init() {
        super.init(contentRect: .zero, styleMask: [], backing: .buffered, defer: false)
        contentViewController = ContentViewController()
    }

    func addViewController(_ viewController: TranslationHeadlessViewController, forLanguagePair: TranslationLanguagePair) {
        contentViewController?.view.addSubview(viewController.view)
        contentViewController?.addChild(viewController)
        viewControllerByLanguagePair[forLanguagePair] = viewController
    }

    func installViewController(forLanguagePair: TranslationLanguagePair) {
        guard let viewController = viewControllerByLanguagePair[forLanguagePair] else { return }
        contentViewController?.view.addSubview(viewController.view)
    }

    func uninstallViewController(forLanguagePair: TranslationLanguagePair) -> TranslationHeadlessViewController? {
        let viewController = viewControllerByLanguagePair[forLanguagePair]
        viewController?.view.removeFromSuperview()
        viewController?.removeFromParent()
        return viewController
    }
}

@available(macOS 15.0, *)
class TranslationHeadlessViewController: NSHostingController<TranslationHeadlessSwiftUIView> {
    let coordinator: TranslationCoordinator

    init(coordinator: TranslationCoordinator) {
        self.coordinator = coordinator
        super.init(rootView: .init(coordinator: coordinator))
    }

    override func viewWillDisappear() {
        super.viewWillDisappear()
        coordinator.session?.invalidSession()
    }
    
    @available(*, unavailable)
    @MainActor @preconcurrency dynamic required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
#endif

#if canImport(UIKit)
@available(iOS 18.0, *)
class TranslationHeadlessWindow: UIWindow {
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
    
    var viewControllerByLanguagePair: [TranslationLanguagePair: TranslationHeadlessViewController] = [:]

    func addViewController(_ viewController: TranslationHeadlessViewController, forLanguagePair: TranslationLanguagePair) {
        viewControllerByLanguagePair[forLanguagePair] = viewController
    }

    func isExist(forLanguagePair: TranslationLanguagePair) -> Bool {
        viewControllerByLanguagePair[forLanguagePair] != nil
    }
    
    func isInstalled(forLanguagePair: TranslationLanguagePair) -> Bool {
        guard let viewController = viewControllerByLanguagePair[forLanguagePair] else { return false }
        return viewController.parent != nil && viewController.view.superview != nil
    }
    
    func installViewController(forLanguagePair: TranslationLanguagePair) -> Bool {
        guard let viewController = viewControllerByLanguagePair[forLanguagePair] else { return false }
        rootViewController?.view.addSubview(viewController.view)
        rootViewController?.addChild(viewController)
        return true
    }

    func uninstallViewController(forLanguagePair: TranslationLanguagePair) -> TranslationHeadlessViewController? {
        let viewController = viewControllerByLanguagePair[forLanguagePair]
        viewController?.view.removeFromSuperview()
        viewController?.removeFromParent()
        return viewController
    }
}

@available(iOS 18.0, *)
class TranslationHeadlessViewController: UIHostingController<TranslationHeadlessSwiftUIView> {
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

@available(macOS 15.0, iOS 18.0, *)
class TranslationCoordinator: ObservableObject {
    @Published
    var configuration: TranslationSession.Configuration?

    var session: TranslationSessionBox?

    var sessionDidChange: (TranslationSessionBox) -> Void = { _ in }
}

@available(macOS 15.0, iOS 18.0, *)
struct TranslationHeadlessSwiftUIView: View {
    @ObservedObject
    var coordinator: TranslationCoordinator

    var body: some View {
        EmptyView()
            .translationTask(coordinator.configuration) { session in
                let session = TranslationSessionBox(session: session)
                coordinator.session = session
                coordinator.sessionDidChange(session)
            }
    }
}
