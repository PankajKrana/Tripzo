//
//  SearchScreen.swift
//  Tripzo
//

import SwiftUI

struct SearchScreen: View {
    @Environment(\.dismiss) private var dismiss
    @State private var searchText = ""
    @State private var selectedCategory: Trip.TripCategory?
    @State private var priceRange: ClosedRange<Double> = 0...100000
    @State private var minRating: Double = 0
    @State private var durationRange: ClosedRange<Int> = 1...14
    @State private var showFilters = false
    
    private let trips = Trip.sampleTrips
    
    var filteredTrips: [Trip] {
        trips.filter { trip in
            let matchesSearch = searchText.isEmpty || 
                trip.title.localizedCaseInsensitiveContains(searchText) ||
                trip.destination.localizedCaseInsensitiveContains(searchText)
            
            let matchesCategory = selectedCategory == nil || trip.category == selectedCategory
            let matchesPrice = trip.price >= priceRange.lowerBound && trip.price <= priceRange.upperBound
            let matchesRating = trip.rating >= minRating
            let matchesDuration = trip.duration >= durationRange.lowerBound && trip.duration <= durationRange.upperBound
            
            return matchesSearch && matchesCategory && matchesPrice && matchesRating && matchesDuration
        }
    }
    
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
                    
                    TextField("Search trips...", text: $searchText)
                        .textFieldStyle(.roundedBorder)
                    
                    Button(action: { showFilters.toggle() }) {
                        Image(systemName: "slider.horizontal.3")
                            .font(.system(size: 16))
                            .foregroundStyle(.blue)
                    }
                    .accessibilityLabel("Filter options")
                }
                .padding(16)
                .background(Color.white)
                
                // Category Filter
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        Button(action: { selectedCategory = nil }) {
                            Text("All")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(selectedCategory == nil ? Color.blue : Color(.systemGray5))
                                .foregroundStyle(selectedCategory == nil ? .white : .primary)
                                .clipShape(.capsule)
                        }
                        
                        ForEach(Trip.TripCategory.allCases, id: \.self) { category in
                            Button(action: { selectedCategory = category }) {
                                Text(category.rawValue)
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 8)
                                    .background(selectedCategory == category ? Color.blue : Color(.systemGray5))
                                    .foregroundStyle(selectedCategory == category ? .white : .primary)
                                    .clipShape(.capsule)
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                }
                .padding(.vertical, 12)
                .background(Color.white)
                
                Divider()
                
                // Results
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 16) {
                        if filteredTrips.isEmpty {
                            emptyStateView
                        } else {
                            ForEach(filteredTrips) { trip in
                                SearchResultCard(trip: trip)
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
            .background(Color(.systemGray6))
            .sheet(isPresented: $showFilters) {
                FilterSheet(
                    priceRange: $priceRange,
                    minRating: $minRating,
                    durationRange: $durationRange
                )
            }
        }
    }
    
    private var emptyStateView: some View {
        VStack(spacing: 16) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 48))
                .foregroundStyle(.gray)
            
            VStack(spacing: 4) {
                Text("No trips found")
                    .font(.headline)
                    .foregroundStyle(.primary)
                
                Text("Try adjusting your filters or search terms")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(32)
        .background(Color.white)
        .clipShape(.rect(cornerRadius: 16))
    }
}

// MARK: - Search Result Card
struct SearchResultCard: View {
    let trip: Trip
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Image with category badge
            ZStack(alignment: .topLeading) {
                Image(trip.image)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 150)
                    .clipped()
                
                // Category badge
                Text(trip.category.rawValue)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(Color.blue)
                    .clipShape(.capsule)
                    .padding(12)
            }
            
            // Info
            VStack(alignment: .leading, spacing: 8) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(trip.title)
                        .font(.headline)
                        .lineLimit(1)
                    
                    Text(trip.location)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
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
                        
                        Text("\(trip.duration) days")
                            .font(.caption)
                    }
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
                        Text("View Details")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.blue)
                    }
                }
            }
            .padding(12)
        }
        .background(Color.white)
        .clipShape(.rect(cornerRadius: 12))
        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
    }
}

// MARK: - Filter Sheet
struct FilterSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var priceRange: ClosedRange<Double>
    @Binding var minRating: Double
    @Binding var durationRange: ClosedRange<Int>
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // Price Filter
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text("Price Range")
                            .font(.headline)
                        
                        Spacer()
                        
                        Text("₹\(Int(priceRange.lowerBound)) - ₹\(Int(priceRange.upperBound))")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.blue)
                    }
                    
                    VStack(spacing: 8) {
                        Slider(value: Binding(
                            get: { priceRange.lowerBound },
                            set: { priceRange = $0...priceRange.upperBound }
                        ), in: 0...100000)
                        
                        Slider(value: Binding(
                            get: { priceRange.upperBound },
                            set: { priceRange = priceRange.lowerBound...$0 }
                        ), in: 0...100000)
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .clipShape(.rect(cornerRadius: 12))
                
                // Rating Filter
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text("Minimum Rating")
                            .font(.headline)
                        
                        Spacer()
                        
                        HStack(spacing: 4) {
                            Image(systemName: "star.fill")
                                .font(.system(size: 12))
                                .foregroundStyle(.orange)
                            
                            Text(String(format: "%.1f", minRating))
                                .font(.subheadline)
                                .fontWeight(.semibold)
                        }
                    }
                    
                    Slider(value: $minRating, in: 0...5, step: 0.1)
                }
                .padding()
                .background(Color(.systemGray6))
                .clipShape(.rect(cornerRadius: 12))
                
                // Duration Filter
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text("Duration (Days)")
                            .font(.headline)
                        
                        Spacer()
                        
                        Text("\(durationRange.lowerBound) - \(durationRange.upperBound)")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.blue)
                    }
                    
                    VStack(spacing: 8) {
                        Slider(value: Binding(
                            get: { Double(durationRange.lowerBound) },
                            set: { durationRange = Int($0)...durationRange.upperBound }
                        ), in: 1...14, step: 1)
                        
                        Slider(value: Binding(
                            get: { Double(durationRange.upperBound) },
                            set: { durationRange = durationRange.lowerBound...Int($0) }
                        ), in: 1...14, step: 1)
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .clipShape(.rect(cornerRadius: 12))
                
                Spacer()
                
                Button(action: { dismiss() }) {
                    Text("Apply Filters")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(.blue)
                        .clipShape(.rect(cornerRadius: 12))
                }
            }
            .padding(20)
            .navigationTitle("Filters")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") { dismiss() }
                }
            }
        }
    }
}

#Preview {
    SearchScreen()
}
