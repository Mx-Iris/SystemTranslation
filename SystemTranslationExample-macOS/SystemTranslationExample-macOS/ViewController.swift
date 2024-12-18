//
//  ViewController.swift
//  SystemTranslationExample-macOS
//
//  Created by JH on 12/17/24.
//

import Cocoa
import SystemTranslation
import SystemTranslationUI

class ViewController: NSViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        
//        Task {
//            do {
//                try await TranslationService.shared.prepareTranslation(in: self, source: .japanese, target: .french)
//                let result = try await TranslationService.shared.translate("こんにちは", source: .japanese, target: .french)
//                print(result)
//            } catch {
//                print(error)
//            }
//        }
    }

    override func viewDidAppear() {
        super.viewDidAppear()
        let viewController = TranslationDownloadViewController()
        viewController.preferredContentSize = .init(width: 800, height: 500)
        presentAsSheet(viewController)
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
}
