//
//  SocialLoginButton.swift
//  Tripzo
//

import SwiftUI

struct SocialLoginButton: View {
    let iconName: String
    let isSystemImage: Bool
    let backgroundColor: Color
    let iconColor: Color?
    let label: String
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
                        .foregroundStyle(iconColor ?? .primary)
                } else {
                    Image(iconName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                }
            }
        }
        .accessibilityLabel(label)
    }
}
