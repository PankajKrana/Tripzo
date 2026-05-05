//
//  HomeScreen.swift
//  Tripzo
//
//  Created by Pankaj Kumar Rana on 25/04/26.
//

import SwiftUI

struct HomeScreen: View {
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            
            topBar
            
            Text("Explore the\nBeautiful world!")
                .font(.system(size: 34, weight: .semibold, design: .serif))
                .minimumScaleFactor(0.8)
            
            dividerText
            
            cardCarousel
            
            Spacer()
        }
        .safeAreaPadding()
    }
}


extension HomeScreen {
    
    private var cardCarousel: some View {
        GeometryReader { geo in
            
            let cardWidth = geo.size.width * 0.75
            let spacing: CGFloat = 70
            
            ScrollView(.horizontal) {
                HStack(spacing: spacing) {
                    
                    ForEach(0..<10, id: \.self) { index in
                        DestinationCard()
                            .frame(width: cardWidth)
                    }
                }
                .padding(.horizontal, (geo.size.width - cardWidth) / 2)
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.viewAligned) // 🔥 SNAP EFFECT
            .scrollIndicators(.hidden)
        }
        .frame(height: 420)
    }
    
    
    private var topBar: some View {
            HStack {
                Capsule()
                    .fill(.gray.opacity(0.2))
                    .frame(width: 120, height: 44)
                    .overlay(alignment: .leading) {
                        Circle()
                            .fill(.blue)
                            .frame(width: 44, height: 44)
                    }
                
                Spacer()
                
                Button {
                    
                } label: {
                    Circle()
                        .fill(.gray.opacity(0.15))
                        .frame(width: 44, height: 44)
                        .overlay {
                            Image(systemName: "bell")
                        }
                }
                .accessibilityLabel("Notifications")
            }
        }
    
    
    private var dividerText: some View {
        HStack {
            Text("Best Destination")
                .font(.title3.bold())
            
            Spacer()
            
            Button("View all") {}
                .foregroundStyle(.blue)
        }
    }
}

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
    HomeScreen()
}
