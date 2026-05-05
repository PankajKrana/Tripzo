//
//  AuthManager.swift
//  Tripzo
//
//  Created by Codex on 01/05/26.
//

import Foundation
import Combine
import Supabase

@MainActor
final class AuthManager: ObservableObject {

    @Published private(set) var isAuthenticated = false
    @Published private(set) var isCheckingSession = true
    @Published private(set) var configurationError: String?

    private let client: SupabaseClient?

    init() {
        let config = Self.loadConfiguration()
        configurationError = config.error
        client = config.client
    }

    func restoreSession() async {
        defer { isCheckingSession = false }
        guard let client else { return }

        do {
            _ = try await client.auth.session
            isAuthenticated = true
        } catch {
            isAuthenticated = false
        }
    }

    func signIn(email: String, password: String) async throws {
        guard let client else {
            throw AuthManagerError.notConfigured(configurationError ?? "Supabase is not configured.")
        }

        try validate(email: email)
        try validate(password: password)

        try await client.auth.signIn(
            email: email,
            password: password
        )
        isAuthenticated = true
    }

    func signUp(name: String, email: String, password: String) async throws -> Bool {
        guard let client else {
            throw AuthManagerError.notConfigured(configurationError ?? "Supabase is not configured.")
        }

        try validate(email: email)
        try validate(password: password)

        let response = try await client.auth.signUp(
            email: email,
            password: password,
            data: [
                "name": .string(name)
            ]
        )

        let hasSession = response.session != nil
        isAuthenticated = hasSession
        return hasSession
    }

    func signOut() async throws {
        guard let client else { return }
        try await client.auth.signOut()
        isAuthenticated = false
    }

    func validate(email: String) throws {
        let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedEmail.isEmpty else {
            throw AuthManagerError.invalidEmail("Email address is required.")
        }

        let emailRegex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        let isValid = trimmedEmail.range(of: emailRegex, options: .regularExpression) != nil
        guard isValid else {
            throw AuthManagerError.invalidEmail("Please enter a valid email address.")
        }
    }

    func validate(password: String) throws {
        let trimmedPassword = password.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedPassword.isEmpty else {
            throw AuthManagerError.invalidPassword("Password is required.")
        }

        guard trimmedPassword.count >= 8 else {
            throw AuthManagerError.invalidPassword("Password must be at least 8 characters.")
        }

        let hasNumber = trimmedPassword.rangeOfCharacter(from: .decimalDigits) != nil
        guard hasNumber else {
            throw AuthManagerError.invalidPassword("Password must contain at least one number.")
        }
    }
}

private extension AuthManager {
    static func loadConfiguration() -> (client: SupabaseClient?, error: String?) {
        guard
            let rawURL = Bundle.main.object(forInfoDictionaryKey: "SUPABASE_URL") as? String,
            let rawKey = Bundle.main.object(forInfoDictionaryKey: "SUPABASE_ANON_KEY") as? String
        else {
            return (nil, "Missing SUPABASE_URL or SUPABASE_ANON_KEY in Info.plist.")
        }

        guard let url = URL(string: rawURL), !rawURL.isEmpty, !rawKey.isEmpty else {
            return (nil, "Invalid Supabase credentials in Info.plist.")
        }

        let client = SupabaseClient(
            supabaseURL: url,
            supabaseKey: rawKey,
            options: .init(
                auth: .init(
                    emitLocalSessionAsInitialSession: true
                )
            )
        )
        return (client, nil)
    }
}

enum AuthManagerError: LocalizedError {
    case notConfigured(String)
    case invalidEmail(String)
    case invalidPassword(String)

    var errorDescription: String? {
        switch self {
        case .notConfigured(let message):
            return message
        case .invalidEmail(let message):
            return message
        case .invalidPassword(let message):
            return message
        }
    }
}
