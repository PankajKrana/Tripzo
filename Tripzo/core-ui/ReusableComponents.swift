//
//  ReusableComponents.swift
//  Tripzo
//
//  Created by Pankaj Kumar Rana on 24/04/26.
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

struct CustomButton: View {
    
    var title: String
    var backgroundColor: Color = .blue
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .background(backgroundColor)
                .clipShape(RoundedRectangle(cornerRadius: 15))
        }
    }
}


struct SocialLoginButton: View {
    
    let iconName: String
    let isSystemImage: Bool
    let backgroundColor: Color
    let iconColor: Color?
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .fill(backgroundColor)
                    .frame(width: 52, height: 52)
                    .overlay(
                        Circle().stroke(Color.gray.opacity(0.2))
                    )
                
                if isSystemImage {
                    Image(systemName: iconName)
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(iconColor ?? .primary)
                } else {
                    Image(iconName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                }
            }
        }
    }
}
