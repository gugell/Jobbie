//
//  Presentable.swift
//  Classie
//
//  Created by Ilia Gutu on 15.01.2022.
//

import UIKit

public protocol Presentable: AnyObject {
    func toPresent() -> UIViewController?
}

extension UIViewController: Presentable {
    public func toPresent() -> UIViewController? {
        return self
    }
}
