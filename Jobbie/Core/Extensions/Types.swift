//
//  Types.swift
//  Classie
//
//  Created by Ilia Gutu on 15.01.2022.
//

import Foundation

typealias Action<T, U> = (T) -> U
typealias EmptyAction = () -> Void

extension ColorAsset {
    func callAsFunction() -> Color {
        return color
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
