//
//  LoadingViewController.swift
//  Jobbie
//
//  Created by Ilia Gutu on 28.01.2022.
//

import UIKit

final class LoadingViewController: UIViewController {

    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        return activityIndicator
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(white: 0, alpha: 0.6)

        activityIndicator.add(to: view).center()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        UI { [weak self] in  self?.activityIndicator.startAnimating() }
    }
}

