//
//  HUDPresentable.swift
//  Jobbie
//
//  Created by Ilia Gutu on 29.01.2022.
//

import UIKit

protocol HUDPresentable {
    func showHUD()
    func hideHUD()
}

extension HUDPresentable where Self: UIViewController {
    func showHUD() {
        addSpinnerController()
    }

    func hideHUD() {
        hideSpinnerController()
    }

    private func addSpinnerController() {
        if children.first(where: { $0 is LoadingViewController }) != nil { return }
        let child = LoadingViewController()
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }

    private func hideSpinnerController() {
        guard let child = children.first(where: { $0 is LoadingViewController }) else { return }
        child.willMove(toParent: nil)
        child.view.removeFromSuperview()
        child.removeFromParent()
    }
}
