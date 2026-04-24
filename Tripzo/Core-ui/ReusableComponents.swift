//
//  ReusableComponents.swift
//  Tripzo
//
//  Created by Pankaj Kumar Rana on 24/04/26.
//

import SwiftUI

struct UserName: View {
    var placeholder: String
    @Binding var text: String
    
    var body: some View {
        TextField(placeholder, text: $text)
            .padding()
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .background(Color.gray.opacity(0.11))
            .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

struct EmailField: View {
    var placeholder: String
    @Binding var text: String
    
    var body: some View {
        TextField(placeholder, text: $text)
            .padding()
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .background(Color.gray.opacity(0.11))
            .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}


struct PasswordField: View {
    var placeholder: String
    @Binding var text: String
    
    var body: some View {
        SecureField(placeholder, text: $text)
            .padding()
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .background(Color.gray.opacity(0.11))
            .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}


struct CustomButton: View {
    var title: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .background(Color.blue)
                .clipShape(RoundedRectangle(cornerRadius: 15))
        }
    }
}
