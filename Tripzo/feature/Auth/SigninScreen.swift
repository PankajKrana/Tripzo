//
//  SigninScreen.swift
//  Tripzo
//
//  Created by Pankaj Kumar Rana on 24/04/26.
//

import SwiftUI

struct SigninScreen: View {
    
    @State private var email = ""
    @State private var password = ""
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
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
            .scrollIndicators(.hidden)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button { dismiss() } label: {
                        Image(systemName: "chevron.left")
                    }
                }
            }
        }
    }
}


extension SigninScreen {
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
                Button("Forgot password?") {}
                    .font(.footnote)
                    .foregroundStyle(.blue)
            }
            
            CustomButton(title: "Sign In") {
                print("Sign in tapped")
            }
            
            HStack(spacing: 4) {
                Text("Don't have an account?")
                Button("Sign up") {}
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

#Preview {
    SigninScreen()
}
