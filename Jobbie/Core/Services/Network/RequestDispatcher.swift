//
//  RequestDispatcher.swift
//  Jobbie
//
//  Created by Ilia Gutu on 28.01.2022.
//

import Foundation
import Foundation

typealias Response<T> = Result<T, Failure>
typealias Completion<T> = (Response<T>) -> Void

protocol RequestDispatcher {
    func dataTask(with request: URLRequest, completion: @escaping Completion<Data>) -> Task
    func dataTask(with request: Request, completion: @escaping Completion<Data>) -> Task?
}

final class NetworkRequestDispatcher: RequestDispatcher {
    private let session: NetworkSession

    init(session: NetworkSession) {
        self.session = session
    }

    func dataTask(with request: URLRequest, completion: @escaping Completion<Data>) -> Task {
        return session.executeTask(with: request) { [weak self] data, response, error in
            self?.handle(data, response: response, error: error, completion: completion)
        }
    }

    func dataTask(with request: Request, completion: @escaping Completion<Data>) -> Task? {
        do {
            let request = try request.asUrlRequest()
            return session.executeTask(with: request) { [weak self] data, response, error in
                self?.handle(data, response: response, error: error, completion: completion)
            }
        } catch {
            completion(.failure(.underlying(error)))
            return nil
        }
    }
}

private extension NetworkRequestDispatcher {
    func handle<T>(_ value: T?, response: URLResponse?, error: Error?, completion: @escaping Completion<T>) {
        switch (value, response, error) {
        case (.some(let value), .some(let response), _):
            if let httpResponse = response as? HTTPURLResponse {
                do {
                    try httpResponse.checkSuccessfulStatusCodes()
                    completion(.success(value))
                } catch {
                    completion(.failure(Failure(error: error)))
                }
            } else {
                completion(.failure(.nonHTTPResponse))
            }
        case (.none, .none, .some(let error)):
            completion(.failure(Failure.underlying(error)))
        default:
            completion(.failure(.badResponse))
        }
    }
}

private extension HTTPURLResponse {
    func filter<R: RangeExpression>(statusCodes: R) throws where R.Bound == Int {
        guard statusCodes.contains(statusCode) else {
            throw Failure.badStatusCode(statusCode)
        }
    }

    func checkSuccessfulStatusCodes() throws {
        return try filter(statusCodes: 200...299)
    }
}


//- username : "ios.challenge@zenjob.com"
//- accessToken : "eyJraWQiOiJxZXV2M0xBUzRtQVFkN1l6TGdzNUtXVzY2djkzbndheS0yMDE5LTAzLTEzIiwiYWxnIjoiUlMyNTYifQ.eyJzdWIiOiI1NjA3MThlYy02Y2NhLTRlODItYWMyNC03ZWZjMDY4NGNiNDEiLCJyb2xlcyI6WyJFTVBMT1lFRV9VU0VSIl0sImlzcyI6InplbmpvYi1jb3JlIiwidHlwIjoiYWNjZXNzX3Rva2VuIiwidmVyc2lvbiI6InYyIiwiYXV0aG9yaXRpZXMiOltdLCJhdWQiOiJ6ZW5qb2ItYXBpIiwibmJmIjoxNjQzMzg3NDM3LCJyZWFsbSI6IkVNUExPWUVFIiwiZGV0YWlscyI6eyJmaXJzdF9uYW1lIjoiaU9TIiwibGFzdF9uYW1lIjoiQ2hhbGxlbmdlIiwiZW1haWwiOiJpb3MuY2hhbGxlbmdlQHplbmpvYi5jb20ifSwiZXhwIjoxNjQzMzg4MDM3LCJpYXQiOjE2NDMzODc0MzcsImp0aSI6IjBjNDA2NjFlLTZkMzMtNGEzZi1hYzY2LTlhNDM0MWVmNTY2OCIsInVzZXJfaGFzaF9rZXkiOiJnazdLYk93WUIxWkJ5NFFHX0g0a3JBIn0.xy7SHQ3C36_1zJKI4MoyOdqPO2CCslbJA_WNXuOKL8T8Lox__opsnhe-Af0mvl0sRncxT9G4x0yclOXtrE56_9Om6-boooZQwf78XJK-euaeYSg7Ec_kXkBBC--uh1vHhiYHa2_n0egwePBgcipQEdQuxIcoEs4SUFLXOUtgCL5ugP1RAURnvWxWgCe6eeJ5c4WBXxkCASedKoeVS0V7Xhmcxv6wzyUpmUCA69ziFcWSNz8UHeEOtnS6y8QY0odFYV3RPjgw0gmunJbh6_GjH2VBjwnWoQP-Y_8dTXK_C9L1mdJ3ZPZElwLwsDIOibZltQLFJZKQjRe5biW7JzY3VQYA3FCQZjX9YvF3-nQOQejhdbyxcNQi-Z17WXtK4VaUrKqmjL6o3YmSaYtFR1A6byKeYnGD-78KbAItDFfKDbhTdEKGRzmmSVPQHy6_TTNZBITA6v5i2QlwmSe98Hu3-ahC-tnxIcYSu0qCDLXdvIHmO6hFpflwIgZN9O8a92OMghKY-4soXuOoO_4xPU5ObxySSLPBFBV6C8rGrMyVTmvxktAKAEo_cD3aqKsWpc6VqG4soFyI85tBVc7vYOjynkRjz7W1sHK9sdugT1pYiQP8j-EgewJAdRtXwlyN6Eq5SSDfXHfQ5kvADCuuUp-ZfTvaLJM4CnKhqGXEg4Sbhw4"
//- refreshToken : "eyJraWQiOiJxZXV2M0xBUzRtQVFkN1l6TGdzNUtXVzY2djkzbndheS0yMDE5LTAzLTEzIiwiYWxnIjoiUlMyNTYifQ.eyJzdWIiOiI1NjA3MThlYy02Y2NhLTRlODItYWMyNC03ZWZjMDY4NGNiNDEiLCJhdWQiOiJ6ZW5qb2ItYXBpIiwibmJmIjoxNjQzMzg3NDM3LCJhdGkiOiJCZWFyZXIiLCJpc3MiOiJ6ZW5qb2ItY29yZSIsInJlYWxtIjoiRU1QTE9ZRUUiLCJ0eXAiOiJyZWZyZXNoX3Rva2VuIiwiaWF0IjoxNjQzMzg3NDM3LCJ2ZXJzaW9uIjoidjIiLCJqdGkiOiIzYTA3MWMwNS1mOTIzLTQwNDYtYjA3ZC04MTBiMjEwYWQxNTQiLCJ1c2VyX2hhc2hfa2V5IjoiZ2s3S2JPd1lCMVpCeTRRR19INGtyQSJ9.SFAnhnZEMOgTB0DtGGqDBz4379wc9CJnHjMb9qa7nCDCR9TuggXoMpCE7T3pFRPkcCsmt4OqM-9BuIRXE8vHMfOeOcEbRxFRrB1GcoO4aDAXKYUQV830MxjmIHdEMPlMII5Ts_23K4u79V5NtoueDajqzlxFsNc1y-FMKfThJ42DmnRWcDPYEz7u_IMzjF9RzdL5l1TcvJ08jQb7cy2EZi_yLtRoxUrFEYKsAqR3wry42kDYWfLu7SqdpwhV83MZjn3Kbc09CdHu-WJeXs8at_PzHsbXVM8M6l5k1ATrXx_cuMumhSnErpoftZCSl89V3mlYJu6sF3iVo7Dx9hma3U0IsSK96OAMHTjysMeZ3aCCu1erwc5bDXYcXxL3cq3yQZD2lPzmcXexLEgCW8EU0fmnKH8e0qrKiUA6tEh8SXUJB7I3U3A154SysiA0lo1ksKVvEgfqaqCZ1kIF6QCyENoVLFue2BPs8v68jV6Zxhf4Dj8TNrR0c2b5XdUccjfsbvx8PVm9pkIWrIVJeCAcCjEjLklWazm0Q44-yBhgX8vhsfjMKdb6EVZsleAzIgzzNWWDUM2DOMkxFHl_NsRS2IzHqsE7QOY5Nu7L2VNI4zK8Ob4YUAfgUTchitjeh8gT-HWTVAthJCJWV3Xr-eF_QHHcEmA0myvLI57cqqb8tMY"
//- expiry : 598
