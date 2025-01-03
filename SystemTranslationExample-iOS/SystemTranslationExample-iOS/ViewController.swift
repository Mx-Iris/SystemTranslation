//
//  ViewController.swift
//  SystemTranslationExample-iOS
//
//  Created by JH on 2024/12/17.
//

import UIKit
import SystemTranslation

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        Task {
            do {
                let result = try await TranslationService.shared.translate("Hello", source: .englishUK, target: .chineseSimplified)
                print(result)
            } catch {
                print(error)
            }
        }
    }
}
