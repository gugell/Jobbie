//
//  Types.swift
//  Jobbie
//
//  Created by Ilia Gutu on 29.01.2022.
//

import UIKit

typealias Action<T, U> = (T) -> U
typealias EmptyAction = () -> Void

extension ColorAsset {
    func callAsFunction() -> Color {
        return color
    }

    func callAsFunction(alpha: CGFloat) -> Color {
        return color.withAlphaComponent(alpha)
    }
}

 extension ImageAsset {
    func callAsFunction() -> Image {
        return image
    }
 }

func UI(_ closure: @escaping () -> Void) {
    DispatchQueue.main.async {
        closure()
    }
}
