//
//  SigninScreen.swift
//  Tripzo
//
//  Created by Pankaj Kumar Rana on 24/04/26.
//

import SwiftUI

struct SigninScreen: View {
    let onShowSignup: () -> Void
    let onShowForgotPassword: () -> Void

    @State private var email = ""
    @State private var password = ""
    @State private var isLoading = false
    @State private var errorMessage = ""
    @EnvironmentObject private var authManager: AuthManager
    
    var body: some View {
        ScrollView {
            VStack(spacing: 28) {
                
                header
                
                form
                
                actions
                
                socialSection
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 20)
            .padding(.top, 10)
        }
        .navigationBarBackButtonHidden()
        .scrollIndicators(.hidden)
        .alert("Sign In Failed", isPresented: .constant(!errorMessage.isEmpty)) {
            Button("OK") {
                errorMessage = ""
            }
        } message: {
            Text(errorMessage)
        }
    }
}


extension SigninScreen {
    private var isFormValid: Bool {
        do {
            try authManager.validate(email: email)
            try authManager.validate(password: password)
            return true
        } catch {
            return false
        }
    }

    private var header: some View {
        VStack(spacing: 10) {
            Text("Sign in now")
                .font(.system(size: 30, weight: .bold, design: .serif))
            
            Text("Please sign in to continue our app")
                .font(.subheadline)
                .foregroundStyle(.gray)
        }
    }
    
    private var form: some View {
        VStack(spacing: 16) {
            
            CustomTextField(
                placeholder: "Email",
                text: $email
            )
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled(true)
            .keyboardType(.emailAddress)
            .onChange(of: email) { _, newValue in
                email = newValue.lowercased()
            }
            
            CustomTextField(
                placeholder: "Password",
                text: $password,
                isSecure: true
            )
        }
    }
    
    
    private var actions: some View {
        VStack(spacing: 16) {
            
            HStack {
                Spacer()
                Button("Forgot password?") {
                    onShowForgotPassword()
                }
                    .font(.footnote)
                    .foregroundStyle(.blue)
            }
            
            CustomButton(title: isLoading ? "Signing In..." : "Sign In") {
                Task { await handleSignIn() }
            }
            .disabled(isLoading || !isFormValid)
            
            HStack(spacing: 4) {
                Text("Don't have an account?")
                Button("Sign up") {
                    onShowSignup()
                }
                    .foregroundStyle(.blue)
            }
            .font(.footnote)
        }
    }
    
    private var socialSection: some View {
        VStack(spacing: 16) {
            
            HStack {
                Rectangle().frame(height: 1).opacity(0.2)
                Text("Or Connect")
                    .font(.footnote)
                    .foregroundStyle(.gray)
                Rectangle().frame(height: 1).opacity(0.2)
            }
            
            HStack(spacing: 20) {
                
                SocialLoginButton(
                    iconName: "google_icon",
                    isSystemImage: false,
                    backgroundColor: Color(.systemBackground),
                    iconColor: nil
                ) {}
                
                SocialLoginButton(
                    iconName: "applelogo",
                    isSystemImage: true,
                    backgroundColor: .black,
                    iconColor: .white
                ) {}
                
                SocialLoginButton(
                    iconName: "facebook_icon",
                    isSystemImage: false,
                    backgroundColor: Color(red: 24/255, green: 119/255, blue: 242/255),
                    iconColor: nil
                ) {}
            }
        }
    }
    
}

private extension SigninScreen {
    func handleSignIn() async {
        errorMessage = ""
        isLoading = true
        defer { isLoading = false }

        do {
            try await authManager.signIn(
                email: email.trimmingCharacters(in: .whitespacesAndNewlines),
                password: password
            )
        } catch {
            errorMessage = friendlyErrorMessage(from: error)
        }
    }

    func friendlyErrorMessage(from error: Error) -> String {
        let raw = error.localizedDescription.lowercased()
        if raw.contains("invalid login credentials") {
            return "Invalid email or password. Please try again."
        }
        return error.localizedDescription
    }
}

#Preview {
    SigninScreen(onShowSignup: {}, onShowForgotPassword: {})
        .environmentObject(AuthManager())
}
