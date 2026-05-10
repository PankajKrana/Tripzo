//
//  DestinationCard.swift
//  Tripzo
//

import SwiftUI

struct DestinationCard: View {
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            // Background Image
            Image("onbording1")
                .resizable()
                .scaledToFill()
                .frame(height: 400)
                .clipped()
            
            // Gradient overlay (premium look)
            LinearGradient(
                colors: [.clear, .black.opacity(0.7)],
                startPoint: .top,
                endPoint: .bottom
            )
            
            // Content
            VStack(alignment: .leading, spacing: 10) {
                
                Spacer()
                
                Text("Sachin Kumar")
                    .font(.headline)
                    .foregroundStyle(.white)
                
                HStack {
                    Text("📍 Lucknow, India")
                        .font(.subheadline)
                        .foregroundStyle(.white.opacity(0.9))
                    
                    Spacer()
                    
                    Text("⭐ 4.6")
                        .foregroundStyle(.white)
                }
                
                avatarStack
            }
            .padding()
        }
        .clipShape(RoundedRectangle(cornerRadius: 30))
        .shadow(color: .black.opacity(0.2), radius: 10, y: 8)
    }
    
    
    private var avatarStack: some View {
        
        let size: CGFloat = 28
        
        return ZStack(alignment: .leading) {
            ForEach(0..<4) { index in
                Image(systemName: "person.fill") // replace with real images
                    .resizable()
                    .scaledToFill()
                    .frame(width: size, height: size)
                    .background(Color.gray.opacity(0.3))
                    .clipShape(Circle())
                    .overlay(
                        Circle().stroke(.white, lineWidth: 2)
                    )
                    .offset(x: CGFloat(index) * (size * 0.6))
            }
        }
        .frame(width: size + (size * 0.6 * 3), height: size)
    }
}

#Preview {
    DestinationCard()
}
