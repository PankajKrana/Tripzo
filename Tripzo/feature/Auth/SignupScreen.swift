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
    @State private var infoMessage = ""
    
    @EnvironmentObject private var authManager: AuthManager
    
    var body: some View {
        ScrollView {
            VStack(spacing: 28) {
                
                header
                
                form
                
                actions
                
                socialSection
                
                Spacer(minLength: 20)
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 20)
            .padding(.top, 10)
        }
        .navigationBarBackButtonHidden()
        .scrollIndicators(.hidden)
        .alert("Sign Up Failed", isPresented: .constant(!errorMessage.isEmpty)) {
            Button("OK") {
                errorMessage = ""
            }
        } message: {
            Text(errorMessage)
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: onBackToSignIn) {
                    Image(systemName: "chevron.left")
                }
            }
        }
    }
    
    var isValid: Bool {
        !name.isEmpty &&
        email.contains("@") &&
        password.count >= 6
    }
}


extension SignupScreen {
    private var header: some View {
        VStack(spacing: 10) {
            
            Text("Create Account")
                .font(.system(size: 30, weight: .bold, design: .serif))
            
            Text("Fill your details to get started")
                .font(.subheadline)
                .foregroundStyle(.gray)
        }
    }
    
    private var form: some View {
        VStack(spacing: 16) {
            
            CustomTextField(
                placeholder: "Full Name",
                text: $name
            )
            
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
            
            CustomButton(title: "Sign Up") {
                Task { await handleSignUp() }
            }
            .disabled(!isValid || isLoading)
            
            HStack(spacing: 4) {
                Text("Already have an account?")
                
                Button("Sign in") {
                    onBackToSignIn()
                }
                .foregroundStyle(.blue)
            }
            .font(.footnote)

            if !infoMessage.isEmpty {
                Text(infoMessage)
                    .font(.footnote)
                    .foregroundStyle(.green)
                    .multilineTextAlignment(.center)
            }
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
            }
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
    SignupScreen(onBackToSignIn: {})
        .environmentObject(AuthManager())
}
