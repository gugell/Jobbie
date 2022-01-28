//
//  AuthViewController.swift
//  Jobbie
//
//  Created by Ilia Gutu on 28.01.2022.
//

import UIKit

/// Modules view input
protocol AuthModuleViewInput: Presentable, HUDPresentable { }

/// Modules view output
protocol AuthModuleViewOutput: AnyObject {
  /// Notifies that view is ready
  func viewDidLoad()
}

final class AuthViewController: UIViewController {

    var output: AuthModuleViewOutput!

    override func viewDidLoad() {
        super.viewDidLoad()

        output.viewDidLoad()
    }
}

extension AuthViewController: AuthModuleViewInput { }
