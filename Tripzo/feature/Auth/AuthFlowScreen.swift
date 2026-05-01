//
//  AuthFlowScreen.swift
//  Tripzo
//
//  Created by Codex on 01/05/26.
//

import SwiftUI

struct AuthFlowScreen: View {
    @State private var path: [Route] = []

    var body: some View {
        NavigationStack(path: $path) {
            SigninScreen(
                onShowSignup: { path.append(.signup) },
                onShowForgotPassword: { path.append(.forgotPassword) }
            )
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .signup:
                    SignupScreen(onBackToSignIn: { path.removeLast() })
                case .forgotPassword:
                    ForgetPasswordScreen(onBack: { path.removeLast() })
                }
            }
        }
    }
}

private extension AuthFlowScreen {
    enum Route: Hashable {
        case signup
        case forgotPassword
    }
}

#Preview {
    AuthFlowScreen()
        .environmentObject(AuthManager())
}
