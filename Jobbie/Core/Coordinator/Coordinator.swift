//
//  Coordinator.swift
//  Classie
//
//  Created by Ilia Gutu on 15.01.2022.
//

public protocol Coordinator: AnyObject {
  func start()
  func start(with option: DeepLinkOption)
}
