//
//  HomeScreen.swift
//  Tripzo
//
//  Created by Pankaj Kumar Rana on 25/04/26.
//

import SwiftUI

struct HomeScreen: View {
    @State private var showSearchSheet = false
    @State private var selectedFilter: String = "Popular"
    @State private var destinations = SampleDestinations.all

    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                gradient: Gradient(colors: [
                    TripzoColors.surface.opacity(0.3),
                    Color.white
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: TripzoSpacing.large) {
                    topBar
                        .slideAnimation(duration: 0.5)

                    // Hero Section
                    heroSection
                        .slideAnimation(duration: 0.6)

                    // Quick Search
                    quickSearchButton
                        .slideAnimation(duration: 0.7)

                    // Filter chips
                    filterChips
                        .slideAnimation(duration: 0.8)

                    // Trending destinations
                    VStack(alignment: .leading, spacing: TripzoSpacing.medium) {
                        HStack {
                            Text("Trending Now")
                                .font(.titleLarge)
                                .fontWeight(.semibold)

                            Spacer()

                            NavigationLink(destination: SearchScreen()) {
                                HStack(spacing: 4) {
                                    Text("See all")
                                        .font(.labelMedium)
                                    Image(systemName: "chevron.right")
                                        .font(.system(size: 12, weight: .semibold))
                                }
                                .foregroundStyle(TripzoColors.primary)
                            }
                        }

                        cardCarousel
                    }
                    .slideAnimation(duration: 0.9)

                    // Popular destinations
                    VStack(alignment: .leading, spacing: TripzoSpacing.medium) {
                        Text("Popular Destinations")
                            .font(.titleLarge)
                            .fontWeight(.semibold)

                        VStack(spacing: TripzoSpacing.medium) {
                            ForEach(destinations.prefix(3), id: \.id) { destination in
                                EnhancedDestinationCard(destination: destination)
                            }
                        }
                    }
                    .slideAnimation(duration: 1.0)

                    Spacer()
                        .frame(height: TripzoSpacing.large)
                }
                .padding(.horizontal, TripzoSpacing.medium)
                .padding(.vertical, TripzoSpacing.medium)
            }
        }
    }
}

extension HomeScreen {
    private var topBar: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("Welcome back! 👋")
                    .font(.labelMedium)
                    .foregroundStyle(TripzoColors.textSecondary)
                Text("Pankaj")
                    .font(.titleMedium)
                    .fontWeight(.semibold)
            }

            Spacer()

            Button(action: {}) {
                Image(systemName: "bell.badge")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(TripzoColors.primary)
                    .frame(width: 44, height: 44)
                    .background(TripzoColors.surface)
                    .clipShape(Circle())
            }
            .accessibilityLabel("Notifications")
        }
    }

    private var heroSection: some View {
        VStack(alignment: .leading, spacing: TripzoSpacing.small) {
            Text("Explore the Beautiful\nWorld")
                .font(.displaySmall)
                .lineLimit(2)

            Text("Discover amazing destinations, book your next adventure")
                .font(.bodyMedium)
                .foregroundStyle(TripzoColors.textSecondary)
        }
    }

    private var quickSearchButton: some View {
        Button(action: { showSearchSheet.toggle() }) {
            HStack(spacing: TripzoSpacing.medium) {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(TripzoColors.textSecondary)

                Text("Where to next?")
                    .foregroundStyle(TripzoColors.textSecondary)

                Spacer()

                Image(systemName: "slider.horizontal.3")
                    .foregroundStyle(TripzoColors.primary)
            }
            .frame(height: 48)
            .padding(.horizontal, TripzoSpacing.medium)
            .background(TripzoColors.surface)
            .clipShape(RoundedRectangle(cornerRadius: TripzoSpacing.cornerRadiusLarge))
            .overlay(
                RoundedRectangle(cornerRadius: TripzoSpacing.cornerRadiusLarge)
                    .stroke(TripzoColors.border, lineWidth: 1)
            )
        }
        .scaleButtonEffect()
        .sheet(isPresented: $showSearchSheet) {
            SearchScreen()
        }
    }

    private var filterChips: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: TripzoSpacing.small) {
                ForEach(["Popular", "Budget", "Luxury", "Adventure", "Relaxation"], id: \.self) { filter in
                    Button(action: { withAnimation(.easeInOut(duration: 0.2)) { selectedFilter = filter } }) {
                        Text(filter)
                            .font(.labelMedium)
                            .fontWeight(.semibold)
                            .foregroundStyle(selectedFilter == filter ? .white : TripzoColors.primary)
                            .padding(.horizontal, TripzoSpacing.medium)
                            .padding(.vertical, TripzoSpacing.small)
                            .background(selectedFilter == filter ? TripzoColors.primary : TripzoColors.surface)
                            .clipShape(Capsule())
                    }
                    .scaleButtonEffect()
                }
            }
            .padding(.horizontal, TripzoSpacing.medium)
        }
    }

    private var cardCarousel: some View {
        GeometryReader { geo in
            let cardWidth = geo.size.width * 0.85
            let spacing: CGFloat = TripzoSpacing.medium

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: spacing) {
                    ForEach(destinations.prefix(5), id: \.id) { destination in
                        NavigationLink(destination: DestinationDetailView(destination: destination)) {
                            EnhancedDestinationCard(destination: destination)
                                .frame(width: cardWidth)
                        }
                    }
                }
                .padding(.horizontal, TripzoSpacing.small)
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.viewAligned)
            .scrollIndicators(.hidden)
        }
        .frame(height: 400)
    }
}

#Preview {
    NavigationStack {
        HomeScreen()
            .environmentObject(AuthManager())
    }
}
