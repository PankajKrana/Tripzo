//
//  AppCoordinator.swift
//  Tripzo
//
//  Created by Codex on 01/05/26.
//

import SwiftUI

struct AppCoordinator: View {
    @EnvironmentObject private var authManager: AuthManager
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false

    var body: some View {
        Group {
            if authManager.isCheckingSession {
                ProgressView("Checking session...")
            } else if let configurationError = authManager.configurationError {
                Text(configurationError)
                    .multilineTextAlignment(.center)
                    .padding()
            } else if !hasCompletedOnboarding {
                OnboardingScreen {
                    hasCompletedOnboarding = true
                }
            } else if authManager.isAuthenticated {
                HomeFlowScreen()
            } else {
                AuthFlowScreen()
            }
        }
        .task {
            await authManager.restoreSession()
        }
    }
}

#Preview {
    AppCoordinator()
        .environmentObject(AuthManager())
}
