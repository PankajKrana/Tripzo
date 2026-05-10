//
//  TripCardView.swift
//  Tripzo
//

import SwiftUI

struct TripCardView: View {
    let trip: Trip
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Image
            ZStack(alignment: .topTrailing) {
                Image(trip.image)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 180)
                    .clipped()
                
                // Gradient overlay
                LinearGradient(
                    gradient: Gradient(colors: [.clear, .black.opacity(0.3)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                
                // Rating badge
                HStack(spacing: 4) {
                    Image(systemName: "star.fill")
                        .font(.system(size: 12))
                    Text(String(format: "%.1f", trip.rating))
                        .font(.caption)
                        .fontWeight(.semibold)
                }
                .foregroundStyle(.white)
                .padding(8)
                .background(Color.black.opacity(0.6))
                .clipShape(.rect(cornerRadius: 8))
                .padding(12)
            }
            
            // Content
            VStack(alignment: .leading, spacing: 10) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(trip.title)
                        .font(.headline)
                        .lineLimit(1)
                    
                    Text(trip.location)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                
                HStack(spacing: 16) {
                    HStack(spacing: 4) {
                        Image(systemName: "calendar")
                        Text("\(trip.duration) Days")
                    }
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    
                    HStack(spacing: 4) {
                        Image(systemName: "person.2")
                        Text("\(trip.travelers) Travelers")
                    }
                    .font(.caption)
                    .foregroundStyle(.secondary)
                }
                
                HStack {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("From")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        Text(trip.pricePerPerson)
                            .font(.headline)
                            .fontWeight(.bold)
                    }
                    
                    Spacer()
                    
                    Button(action: {}) {
                        Text("Book Now")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .frame(height: 38)
                            .frame(maxWidth: .infinity)
                            .background(.blue)
                            .clipShape(.rect(cornerRadius: 8))
                    }
                    .accessibilityLabel("Book \(trip.title)")
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
    TripCardView(trip: Trip.sampleTrips[0])
}
