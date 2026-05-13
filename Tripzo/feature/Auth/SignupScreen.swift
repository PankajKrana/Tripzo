//
//  SignupScreen.swift
//  Tripzo
//
//  Created by Pankaj Kumar Rana on 24/04/26.
//

import SwiftUI

struct SignupScreen: View {
    let onBackToSignIn: () -> Void
    
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var isLoading = false
    @State private var errorMessage = ""
    @State private var showError = false
    @State private var infoMessage = ""
    @State private var showInfo = false
    
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
                    
                    Spacer(minLength: TripzoSpacing.large)
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, TripzoSpacing.medium)
                .padding(.top, TripzoSpacing.medium)
            }
            .navigationBarBackButtonHidden()
            .scrollIndicators(.hidden)

            // Back button overlay
            VStack {
                HStack {
                    Button(action: onBackToSignIn) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(TripzoColors.primary)
                            .frame(width: 44, height: 44)
                    }
                    Spacer()
                }
                .padding(TripzoSpacing.medium)

                Spacer()
            }
        }
        .alert("Sign Up Failed", isPresented: $showError) {
            Button("OK") {
                errorMessage = ""
            }
        } message: {
            Text(errorMessage)
        }
        .alert("Success", isPresented: $showInfo) {
            Button("OK") {
                infoMessage = ""
            }
        } message: {
            Text(infoMessage)
        }
    }
    
    var isValid: Bool {
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedName.isEmpty else { return false }

        do {
            try authManager.validate(email: email)
            try authManager.validate(password: password)
            return true
        } catch {
            return false
        }
    }
}


extension SignupScreen {
    private var header: some View {
        VStack(alignment: .leading, spacing: TripzoSpacing.small) {
            Text("Create Account")
                .font(.displaySmall)
                .fontWeight(.bold)
            
            Text("Start planning your dream adventures today")
                .font(.bodyMedium)
                .foregroundStyle(TripzoColors.textSecondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var form: some View {
        VStack(spacing: TripzoSpacing.medium) {
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Full Name")
                    .font(.labelMedium)
                    .fontWeight(.semibold)
                
                CustomTextField(
                    placeholder: "Enter your full name",
                    text: $name
                )
            }
            
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
                Text("Password")
                    .font(.labelMedium)
                    .fontWeight(.semibold)
                
                CustomTextField(
                    placeholder: "Create a strong password",
                    text: $password,
                    isSecure: true
                )
            }
        }
    }
    
    private var actions: some View {
        VStack(spacing: TripzoSpacing.medium) {
            
            ModernButton(
                title: isLoading ? "Creating Account..." : "Sign Up",
                systemImage: isLoading ? nil : "checkmark",
                action: { Task { await handleSignUp() } },
                style: .primary,
                isLoading: isLoading,
                isEnabled: isValid
            )
            
            HStack(spacing: 4) {
                Text("Already have an account?")
                    .font(.bodySmall)
                
                Button("Sign in") {
                    onBackToSignIn()
                }
                    .font(.bodySmall)
                    .fontWeight(.semibold)
                    .foregroundStyle(TripzoColors.primary)
            }
            .frame(maxWidth: .infinity)

            if !infoMessage.isEmpty {
                HStack(spacing: TripzoSpacing.small) {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundStyle(TripzoColors.success)
                    Text(infoMessage)
                        .font(.bodySmall)
                }
                .padding(TripzoSpacing.small)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(TripzoColors.success.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: TripzoSpacing.cornerRadiusMedium))
                .transition(.slide.combined(with: .opacity))
            }
        }
    }
    
    private var socialSection: some View {
        VStack(spacing: TripzoSpacing.medium) {
            
            HStack {
                Rectangle().frame(height: 1).opacity(0.2)
                Text("Or sign up with")
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

private extension SignupScreen {
    func handleSignUp() async {
        errorMessage = ""
        infoMessage = ""
        isLoading = true
        defer { isLoading = false }

        do {
            let signedInImmediately = try await authManager.signUp(
                name: name.trimmingCharacters(in: .whitespacesAndNewlines),
                email: email.trimmingCharacters(in: .whitespacesAndNewlines),
                password: password
            )

            if !signedInImmediately {
                infoMessage = "Account created. Check your email to verify, then sign in."
                showInfo = true
            }
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
    SignupScreen(onBackToSignIn: {})
        .environmentObject(AuthManager())
}
