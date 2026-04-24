//
//  SignupScreen.swift
//  Tripzo
//
//  Created by Pankaj Kumar Rana on 24/04/26.
//

import SwiftUI

struct SignupScreen: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var name: String = ""
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            VStack(spacing: 25) {
                
                
                Text("Sign up now")
                    .font(.custom("AveriaSerifLibre-BoldItalic", size: 30))
                    .multilineTextAlignment(.center)
                
                Text("Please fill the details to create account ")
                    .font(.system(size: 15))
                    .multilineTextAlignment(.center)
                
                UserName(placeholder: "Full Name", text: $name)
                
                EmailField(placeholder: "Email", text: $email)
                
                PasswordField(placeholder: "Password", text: $password)
                
                Button("Forgot password?") {
                    print("Forgot tapped")
                }
                .foregroundStyle(.blue)
                
                CustomButton(title: "Sign up") {
                    print("Sign in tapped")
                }
                
                HStack {
                    Text("Already have an account?")
                    Text("Sign up")
                        .foregroundStyle(.blue)
                }
                
                Divider()
                
                Text("Or Connect")
                
                HStack(spacing: 20) {
                    ForEach(0..<3) { _ in
                        Circle()
                            .stroke()
                            .frame(width: 60, height: 60)
                    }
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
    SignupScreen()
}
