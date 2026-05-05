//
//  CustomTextField.swift
//  Tripzo
//

import SwiftUI

struct CustomTextField: View {
    var placeholder: String
    @Binding var text: String

    var isSecure: Bool = false
    @State private var showPassword = false

    var body: some View {
        HStack {
            if isSecure {
                Group {
                    if showPassword {
                        TextField(placeholder, text: $text)
                    } else {
                        SecureField(placeholder, text: $text)
                    }
                }

                Button {
                    showPassword.toggle()
                } label: {
                    Image(systemName: showPassword ? "eye.slash" : "eye")
                }
                .accessibilityLabel(showPassword ? "Hide password" : "Show password")
            } else {
                TextField(placeholder, text: $text)
            }
        }
        .padding()
        .frame(height: 56)
        .background(Color.gray.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}
