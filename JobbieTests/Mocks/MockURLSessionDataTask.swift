//
//  MockURLSessionDataTask.swift
//  JobbieTests
//
//  Created by Ilia Gutu on 28.01.2022.
//

import Foundation
@testable import Jobbie

final class MockURLSessionDataTask: Task {
    private (set) var resumeWasCalled = false
    private (set) var cancelWasCalled = false

    func resume() {
        resumeWasCalled = true
    }

    func cancel() {
        cancelWasCalled = true
    }
}
