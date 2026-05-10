//
//  FavoritesScreen.swift
//  Tripzo
//

import SwiftUI

struct FavoritesScreen: View {
    @Environment(\.dismiss) private var dismiss
    @State private var favorites: [Trip] = Trip.sampleTrips.filter { $0.isFavorite }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Header
                HStack(spacing: 12) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(.primary)
                    }
                    .accessibilityLabel("Back")
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Favorite Trips")
                            .font(.headline)
                            .fontWeight(.bold)
                        
                        Text("\(favorites.count) trips saved")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    
                    Spacer()
                }
                .padding(16)
                .background(Color.white)
                
                Divider()
                
                // Content
                if favorites.isEmpty {
                    emptyStateView
                } else {
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 16) {
                            ForEach(favorites) { trip in
                                FavoriteCard(trip: trip) {
                                    if let index = favorites.firstIndex(where: { $0.id == trip.id }) {
                                        favorites.remove(at: index)
                                    }
                                }
                            }
                            
                            Spacer()
                                .frame(height: 20)
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 20)
                    }
                    .background(Color(.systemGray6))
                }
            }
            .background(Color(.systemGray6))
        }
    }
    
    private var emptyStateView: some View {
        VStack(spacing: 16) {
            Image(systemName: "heart.slash")
                .font(.system(size: 48))
                .foregroundStyle(.gray)
            
            VStack(spacing: 4) {
                Text("No favorites yet")
                    .font(.headline)
                    .foregroundStyle(.primary)
                
                Text("Add trips to your favorites to see them here")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGray6))
    }
}

// MARK: - Favorite Card
struct FavoriteCard: View {
    let trip: Trip
    let onRemove: () -> Void
    @State private var showDetails = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Image
            ZStack(alignment: .topTrailing) {
                Image(trip.image)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 180)
                    .clipped()
                
                // Gradient
                LinearGradient(
                    gradient: Gradient(colors: [.clear, .black.opacity(0.3)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                
                // Favorite button
                Button(action: onRemove) {
                    Image(systemName: "heart.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(.red)
                        .padding(12)
                        .background(Circle().fill(Color.white.opacity(0.9)))
                }
                .accessibilityLabel("Remove from favorites")
                .padding(12)
            }
            
            // Content
            VStack(alignment: .leading, spacing: 10) {
                VStack(alignment: .leading, spacing: 4) {
                    HStack(spacing: 8) {
                        Text(trip.title)
                            .font(.headline)
                            .lineLimit(1)
                        
                        Text(trip.category.rawValue)
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundStyle(.blue)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.blue.opacity(0.2))
                            .clipShape(.capsule)
                    }
                    
                    Text(trip.location)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                
                HStack(spacing: 12) {
                    HStack(spacing: 4) {
                        Image(systemName: "star.fill")
                            .font(.system(size: 12))
                            .foregroundStyle(.orange)
                        
                        Text(String(format: "%.1f", trip.rating))
                            .font(.caption)
                            .fontWeight(.semibold)
                        
                        Text("(\(trip.reviewCount))")
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                    }
                    
                    Spacer()
                    
                    HStack(spacing: 4) {
                        Image(systemName: "calendar")
                            .font(.system(size: 12))
                            .foregroundStyle(.blue)
                        
                        Text("\(trip.duration)d")
                            .font(.caption)
                    }
                }
                
                HStack {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Starting from")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        
                        Text(trip.pricePerPerson)
                            .font(.headline)
                            .fontWeight(.bold)
                    }
                    
                    Spacer()
                    
                    NavigationLink(destination: Text("Trip Details")) {
                        Image(systemName: "chevron.right")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundStyle(.gray)
                    }
                }
            }
            .padding(12)
        }
        .background(Color.white)
        .clipShape(.rect(cornerRadius: 12))
        .shadow(color: .black.opacity(0.08), radius: 8, x: 0, y: 2)
    }
}

#Preview {
    FavoritesScreen()
}
