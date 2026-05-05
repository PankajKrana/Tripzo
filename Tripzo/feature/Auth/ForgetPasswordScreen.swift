//
//  ForgetPasswordScreen.swift
//  Tripzo
//
//  Created by Pankaj Kumar Rana on 24/04/26.
//

import SwiftUI

struct ForgetPasswordScreen: View {
    let onBack: () -> Void
    
    @State private var email: String = ""
    
    var body: some View {
        ScrollView {
            VStack(spacing: 28) {
                
                Spacer(minLength: 40)
                
                header
                
                form
                
                actionButton
                
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 20)
        }
        .scrollIndicators(.hidden)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: onBack) {
                    Image(systemName: "chevron.left")
                }
            }
        }
    }
}


extension ForgetPasswordScreen {
    private var header: some View {
        VStack(spacing: 12) {
            
            Text("Forgot Password")
                .font(.system(size: 28, weight: .bold, design: .serif))
            
            Text("Enter your email to reset your password")
                .font(.subheadline)
                .foregroundStyle(.gray)
                .multilineTextAlignment(.center)
        }
    }
    
    private var form: some View {
        VStack(spacing: 16) {
            CustomTextField(
                placeholder: "Email",
                text: $email
            )
        }
    }
    
    
    private var actionButton: some View {
        CustomButton(title: "Reset Password") {
            Task {
                await handlePasswordReset()
            }
        }
    }
    
    private func handlePasswordReset() async {
        // TODO: Implement password reset functionality with Supabase
        print("Password reset requested for: \(email)")
    }
}
#Preview {
    ForgetPasswordScreen(onBack: {})
}
