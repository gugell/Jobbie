//
//  Coordinator.swift
//  Jobbie
//
//  Created by Ilia Gutu on 29.01.2022.
//

public protocol Coordinator: AnyObject {
  func start()
  func start(with option: DeepLinkOption)
}
