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
                
                Button(action: {}) {
                    Image(systemName: "bell")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(.primary)
                        .frame(width: 44, height: 44)
                        .background(Circle().fill(.gray.opacity(0.15)))
                }
                .accessibilityLabel("Notifications")
            }
        }
    
    
    private var dividerText: some View {
        HStack {
            Text("Best Destination")
                .font(.title3.bold())
            
            Spacer()
            
            NavigationLink(destination: SearchScreen()) {
                Text("View all")
                    .foregroundStyle(.blue)
            }
        }
    }
}

#Preview {
    HomeScreen()
}
