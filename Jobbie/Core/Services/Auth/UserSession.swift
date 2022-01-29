//
//  UserSession.swift
//  Jobbie
//
//  Created by Ilia Gutu on 29.01.2022.
//

import Foundation

protocol UserSession: AnyObject {
    var accessToken: String? { get }
    func storeSession(_ session: User)
    func currentUser() -> User?
    func isLoggedIn() -> Bool
    func isTokenExpired() -> Bool
    func clearSession()
}

final class UserSessionManager: UserSession {
    private var currentSession: User?
    private var sessionDate: Date?

    var accessToken: String? {
        return currentUser()?.accessToken
    }

    func storeSession(_ session: User) {
        self.currentSession = session
        self.sessionDate = Date().addingTimeInterval(TimeInterval(session.expiry))
    }

    func currentUser() -> User? {
        return currentSession
    }

    func isLoggedIn() -> Bool {
        return currentSession != nil && !isTokenExpired()
    }

    func isTokenExpired() -> Bool {
        guard let sessionDate = sessionDate else { return true }
        return sessionDate <= Date()
    }

    func clearSession() {
        currentSession = nil
    }
}
