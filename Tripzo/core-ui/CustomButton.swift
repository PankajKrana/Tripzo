//
//  CustomButton.swift
//  Tripzo
//

import SwiftUI

struct CustomButton: View {
    var title: String
    var backgroundColor: Color = .blue
    var action: () -> Void

    @Environment(\.isEnabled) private var isEnabled

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
        .opacity(isEnabled ? 1.0 : 0.6)
    }
}
