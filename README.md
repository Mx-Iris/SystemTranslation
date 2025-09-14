# SystemTranslation

> [!NOTE]  
>
> As of iOS 26 / macOS 26, Apple's Translation framework now provides public initialization methods for `TranslationSession`. This library is now primarily maintained for backward compatibility with earlier OS versions.
>
> **For new projects targeting iOS 26+ / macOS 26+**, we recommend using Apple's native Translation framework directly instead of this library.
>
> **For existing projects or those supporting older OS versions**, this library will continue to work and receive maintenance updates.

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
