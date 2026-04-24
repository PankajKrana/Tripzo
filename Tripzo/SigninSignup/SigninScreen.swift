//
//  SigninScreen.swift
//  Tripzo
//
//  Created by Pankaj Kumar Rana on 24/04/26.
//

import SwiftUI

struct SigninScreen: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 25) {
                
                
                Text("Sign in now")
                    .font(.custom("AveriaSerifLibre-BoldItalic", size: 30))
                    .multilineTextAlignment(.center)
                
                Text("Please sign in to continue our app")
                    .font(.system(size: 15))
                    .multilineTextAlignment(.center)
                
                EmailField(placeholder: "Email", text: $email)
                
                PasswordField(placeholder: "Password", text: $password)
                
                Button("Forgot password?") {
                    print("Forgot tapped")
                }
                .foregroundStyle(.blue)
                
                CustomButton(title: "Sign In") {
                    print("Sign in tapped")
                }
                
                HStack {
                    Text("Don't have an account?")
                    Text("Sign up")
                        .foregroundStyle(.blue)
                }
                
                Divider()
                
                Text("Or Connect")
                
                HStack(spacing: 20) {

                    // Google
                    SocialLoginButton(
                        iconName: "google_icon",
                        isSystemImage: false,
                        backgroundColor: Color(.systemBackground),
                        iconColor: nil
                    ) { }

                    // Apple (IMPORTANT FIX)
                    SocialLoginButton(
                        iconName: "applelogo",
                        isSystemImage: true,
                        backgroundColor: .black,
                        iconColor: .white
                    ) { }

                    // Facebook
                    SocialLoginButton(
                        iconName: "facebook_icon",
                        isSystemImage: false,
                        backgroundColor: Color(red: 24/255, green: 119/255, blue: 242/255),
                        iconColor: nil
                    ) { }
                }

            }
            .padding(.horizontal, 20)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                        
                    }
                    
                }
            }
        }
        
    }
}


#Preview {
    SigninScreen()
}
