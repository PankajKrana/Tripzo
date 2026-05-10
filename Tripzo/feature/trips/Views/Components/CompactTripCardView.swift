//
//  CompactTripCardView.swift
//  Tripzo
//

import SwiftUI

struct CompactTripCardView: View {
    let trip: Trip
    
    var body: some View {
        HStack(spacing: 12) {
            // Image
            Image(trip.image)
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80)
                .clipShape(.rect(cornerRadius: 8))
            
            // Content
            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 8) {
                    Text(trip.title)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .lineLimit(1)
                    
                    HStack(spacing: 2) {
                        Image(systemName: "star.fill")
                            .font(.system(size: 10))
                            .foregroundStyle(.orange)
                        Text(String(format: "%.1f", trip.rating))
                            .font(.caption2)
                    }
                }
                
                Text(trip.location)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
                
                HStack {
                    Text(trip.formattedDate)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    
                    Spacer()
                    
                    Text(trip.pricePerPerson)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundStyle(.blue)
                }
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.system(size: 12, weight: .semibold))
                .foregroundStyle(.gray)
        }
        .padding(12)
        .background(Color.white)
        .clipShape(.rect(cornerRadius: 10))
        .shadow(color: .black.opacity(0.05), radius: 6, x: 0, y: 2)
    }
}

#Preview {
    CompactTripCardView(trip: Trip.sampleTrips[0])
}
