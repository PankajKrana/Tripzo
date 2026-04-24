//
//  ForgetPasswordScreen.swift
//  Tripzo
//
//  Created by Pankaj Kumar Rana on 24/04/26.
//

import SwiftUI

struct ForgetPasswordScreen: View {
    @State private var email: String = ""
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack {
            VStack(spacing: 25) {

                Text("Forget Password")
                    .font(.custom("AveriaSerifLibre-BoldItalic", size: 30))
                    .multilineTextAlignment(.center)
                
                Text("Enter your email to reset the password")
                
                EmailField(placeholder: "Email", text: $email)
                
                
                CustomButton(title: "Reset Password") {
                    // TODO: Action for the reset password
                }
                
                Spacer()
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
    ForgetPasswordScreen()
}
