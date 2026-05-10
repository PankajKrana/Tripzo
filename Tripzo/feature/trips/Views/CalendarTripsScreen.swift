//
//  CalendarTripsScreen.swift
//  Tripzo
//
//  Created by Pankaj Kumar Rana on 10/05/26.
//

import SwiftUI

struct CalendarTripsScreen: View {
    @StateObject private var viewModel = TripsViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Header
                headerView
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 20) {
                        // Horizontal Date Selector
                        dateCarouselView
                            .padding(.horizontal, 16)
                            .padding(.vertical, 20)
                        
                        // Trips for Selected Date
                        if !viewModel.tripsForSelectedDate.isEmpty {
                            VStack(alignment: .leading, spacing: 12) {
                                Text("Trips on \(formatDateHeader(viewModel.selectedDate))")
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                    .padding(.horizontal, 16)
                                
                                VStack(spacing: 12) {
                                    ForEach(viewModel.tripsForSelectedDate) { trip in
                                        TripCardView(trip: trip)
                                            .padding(.horizontal, 16)
                                    }
                                }
                            }
                        } else {
                            emptyStateView
                                .padding(.horizontal, 16)
                        }
                        
                        // Upcoming Trips Section
                        if !viewModel.upcomingTrips.isEmpty {
                            VStack(alignment: .leading, spacing: 12) {
                                Text("Upcoming Trips")
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                    .padding(.horizontal, 16)
                                
                                VStack(spacing: 12) {
                                    ForEach(viewModel.upcomingTrips.prefix(3)) { trip in
                                        CompactTripCardView(trip: trip)
                                            .padding(.horizontal, 16)
                                    }
                                }
                            }
                        }
                        
                        Spacer()
                            .frame(height: 20)
                    }
                }
            }
            .background(Color(.systemGray6))
            .navigationBarBackButtonHidden(true)
        }
    }
    
    private var headerView: some View {
        VStack(spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("My Trips")
                        .font(.system(size: 28, weight: .bold))
                    Text("Plan your next adventure")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                
                Spacer()
                
                Button(action: {}) {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 28))
                        .foregroundStyle(.blue)
                }
                .accessibilityLabel("Add new trip")
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)
        }
        .background(Color.white)
    }
    
    private var dateCarouselView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(viewModel.datesForCalendar, id: \.self) { date in
                    DateSelectionButton(
                        date: date,
                        isSelected: Calendar.current.startOfDay(for: date) == 
                                    Calendar.current.startOfDay(for: viewModel.selectedDate),
                        action: {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                viewModel.selectDate(date)
                            }
                        }
                    )
                }
            }
            .scrollTargetLayout()
        }
        .scrollTargetBehavior(.viewAligned)
        .background(Color.white)
        .clipShape(.rect(cornerRadius: 12))
        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
    }
    
    private var emptyStateView: some View {
        VStack(spacing: 16) {
            Image(systemName: "calendar.badge.exclamationmark")
                .font(.system(size: 48))
                .foregroundStyle(.gray)
            
            VStack(spacing: 4) {
                Text("No Trips Scheduled")
                    .font(.headline)
                    .foregroundStyle(.primary)
                
                Text("You don't have any trips on this date. Plan one today!")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }
            
            Button(action: {}) {
                HStack(spacing: 8) {
                    Image(systemName: "plus")
                    Text("Plan a Trip")
                }
                .frame(maxWidth: .infinity)
                .frame(height: 44)
                .foregroundStyle(.white)
                .background(.blue)
                .clipShape(.rect(cornerRadius: 10))
            }
            .accessibilityLabel("Plan a new trip")
            .padding(.top, 8)
        }
        .frame(maxWidth: .infinity)
        .padding(32)
        .background(Color.white)
        .clipShape(.rect(cornerRadius: 16))
    }
    
    private func formatDateHeader(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMMM d"
        return formatter.string(from: date)
    }
}

#Preview {
    CalendarTripsScreen()
}
