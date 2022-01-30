//
//  FuncCheck.swift
//  JobbieTests
//
//  Created by Ilia Gutu on 30.01.2022.
//

public class FuncCheck<T> {
    public private(set) var wasCalled = false
    public private(set) var value: T?
    public var wasNotCalled: Bool {
        return !wasCalled
    }

    public init() {}

    public func call(_ parameter: T) {
        value = parameter
        wasCalled = true
    }

    public func reset() {
        value = nil
        wasCalled = false
    }
}

public extension FuncCheck where T: Equatable {
    func wasCalled(with otherValue: T) -> Bool {
        return value == otherValue && wasCalled
    }
}

public final class ZeroArgumentsFuncCheck: FuncCheck<Void> {
    public func call() {
        super.call(())
    }
}
