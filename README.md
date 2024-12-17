# SystemTranslation

Apple's Translation framework binds `TranslationSession` with SwiftUI's `View`, It doesn't have an init method for initialization, a `session` must be started using the `translationTask` of its `View`.

This library decouples these dependencies. It achieves this by displaying a transparent, non-interactive window to host a View for translation, enabling translation without SwiftUI or a user interface.

## Requirements

AppKit or UIKit
macOS 15 or later.
iOS 18 or later.
Swift 5.10 or later.

## Usage

Use the TranslationService singleton for translation, 

```swift
func translate(_ text: String, source: TranslationLanguage, target: TranslationLanguage) async throws -> String.
```

Since some languages may not be downloaded, please have the user download them before translation. 

```swift
func prepareTranslation(in viewController: NSUIViewController, source: TranslationLanguage, target: TranslationLanguage) async throws
```
