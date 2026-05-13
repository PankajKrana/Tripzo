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
    @State private var showError = false
    @EnvironmentObject private var authManager: AuthManager
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    TripzoColors.primary.opacity(0.05),
                    TripzoColors.surface
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            ScrollView {
                VStack(spacing: TripzoSpacing.large) {
                    header
                        .slideAnimation(duration: 0.3)
                    
                    form
                        .slideAnimation(duration: 0.4)
                    
                    actions
                        .slideAnimation(duration: 0.5)
                    
                    socialSection
                        .slideAnimation(duration: 0.6)

                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, TripzoSpacing.medium)
                .padding(.top, TripzoSpacing.large)
            }
            .scrollIndicators(.hidden)
            .navigationBarBackButtonHidden()
        }
        .alert("Sign In Failed", isPresented: $showError) {
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
        VStack(alignment: .leading, spacing: TripzoSpacing.small) {
            Text("Welcome Back")
                .font(.displaySmall)
                .fontWeight(.bold)
            
            Text("Sign in to continue planning your adventures")
                .font(.bodyMedium)
                .foregroundStyle(TripzoColors.textSecondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var form: some View {
        VStack(spacing: TripzoSpacing.medium) {
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Email")
                    .font(.labelMedium)
                    .fontWeight(.semibold)
                
                CustomTextField(
                    placeholder: "Enter your email",
                    text: $email
                )
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled(true)
                .keyboardType(.emailAddress)
                .onChange(of: email) { _, newValue in
                    email = newValue.lowercased()
                }
            }

            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("Password")
                        .font(.labelMedium)
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    Button(action: onShowForgotPassword) {
                        Text("Forgot?")
                            .font(.labelSmall)
                            .foregroundStyle(TripzoColors.primary)
                    }
                }
                
                CustomTextField(
                    placeholder: "Enter your password",
                    text: $password,
                    isSecure: true
                )
            }
        }
    }
    
    private var actions: some View {
        VStack(spacing: TripzoSpacing.medium) {
            ModernButton(
                title: isLoading ? "Signing In..." : "Sign In",
                systemImage: isLoading ? nil : "arrow.right",
                action: { Task { await handleSignIn() } },
                style: .primary,
                isLoading: isLoading,
                isEnabled: isFormValid
            )
            
            HStack(spacing: 4) {
                Text("Don't have an account?")
                    .font(.bodySmall)
                Button("Sign up") {
                    onShowSignup()
                }
                    .font(.bodySmall)
                    .fontWeight(.semibold)
                    .foregroundStyle(TripzoColors.primary)
            }
            .frame(maxWidth: .infinity)
        }
    }
    
    private var socialSection: some View {
        VStack(spacing: TripzoSpacing.medium) {
            
            HStack {
                Rectangle().frame(height: 1).opacity(0.2)
                Text("Or sign in with")
                    .font(.labelSmall)
                    .foregroundStyle(TripzoColors.textSecondary)
                Rectangle().frame(height: 1).opacity(0.2)
            }
            
            HStack(spacing: TripzoSpacing.medium) {
                
                SocialLoginButton(
                    iconName: "google_icon",
                    isSystemImage: false,
                    backgroundColor: Color(.systemBackground),
                    iconColor: nil,
                    label: "Continue with Google"
                ) {}
                
                SocialLoginButton(
                    iconName: "applelogo",
                    isSystemImage: true,
                    backgroundColor: .black,
                    iconColor: .white,
                    label: "Continue with Apple"
                ) {}
                
                SocialLoginButton(
                    iconName: "facebook_icon",
                    isSystemImage: false,
                    backgroundColor: Color(red: 24/255, green: 119/255, blue: 242/255),
                    iconColor: nil,
                    label: "Continue with Facebook"
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
            showError = true
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
