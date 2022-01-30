//
//  StubRequestDispatcher.swift
//  Jobbie
//
//  Created by Ilia Gutu on 29.01.2022.
//

import Foundation

public enum StubSessionFailure: Error, Equatable {
    case invalidMockFile
    case unknown
}

final class StubRequestDispatcher: RequestDispatcher {

    var stubResponse: Response<Data> = .failure(.badResponse)

    func dataTask(with request: URLRequest, completion: @escaping Completion<Data>) -> SessionTask {
        return EmptyTask()
    }

    func dataTask(with request: Request, completion: @escaping Completion<Data>) -> SessionTask? {

        guard let fileName = request.fileName,
              let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            completion(stubResponse)
            return nil
        }

        do {
            completion(.success(try Data(contentsOf: url)))
        } catch {
            completion(.failure(.underlying(StubSessionFailure.invalidMockFile)))
        }
        return EmptyTask()
    }
}

private class EmptyTask: SessionTask {
    func resume() { }
    func cancel() { }
}
