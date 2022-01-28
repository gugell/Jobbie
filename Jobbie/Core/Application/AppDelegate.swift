//
//  AppDelegate.swift
//  Classie
//
//  Created by Ilia Gutu on 15.01.2022.
//

import UIKit

@UIApplicationMain
class AppDelegate: PluggableApplicationDelegate {

    override var services: [ApplicationService] {
        return [
            ApplicationFlowService()
        ]
    }

    override init() {
        super.init()
        self.window = buildWindow()
    }

    func buildWindow() -> UIWindow {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = UINavigationController()
        return window
    }
}
