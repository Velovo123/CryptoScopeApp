//
//  NavigationExtension.swift
//  CryptoScope
//
//  Created by Anatolii Semenchuk on 16.04.2026.
//

import UIKit

extension UINavigationController {
    open override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.isEnabled = false
    }
}
