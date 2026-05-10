//
//  TripsViewModel.swift
//  Tripzo
//
//  Created by Pankaj Kumar Rana on 10/05/26.
//

import Foundation
import Combine

@MainActor
final class TripsViewModel: ObservableObject {
    @Published var allTrips: [Trip] = Trip.sampleTrips
    @Published var selectedDate: Date = Date()
    @Published var tripsForSelectedDate: [Trip] = []
    @Published var upcomingTrips: [Trip] = []
    
    init() {
        updateTrips()
    }
    
    func updateTrips() {
        selectedDate = Calendar.current.startOfDay(for: selectedDate)
        
        let calendar = Calendar.current
        let nextDay = calendar.date(byAdding: .day, value: 1, to: selectedDate) ?? selectedDate
        
        // Trips for selected date
        tripsForSelectedDate = allTrips.filter { trip in
            let tripStart = calendar.startOfDay(for: trip.startDate)
            let tripEnd = calendar.startOfDay(for: trip.endDate)
            return tripStart <= selectedDate && selectedDate <= tripEnd
        }
        
        // Upcoming trips (trips starting after selected date)
        upcomingTrips = allTrips.filter { trip in
            calendar.startOfDay(for: trip.startDate) >= nextDay
        }.sorted { $0.startDate < $1.startDate }
    }
    
    func selectDate(_ date: Date) {
        selectedDate = date
        updateTrips()
    }
    
    var datesForCalendar: [Date] {
        var dates: [Date] = []
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        
        for i in 0..<14 {
            if let date = calendar.date(byAdding: .day, value: i, to: today) {
                dates.append(date)
            }
        }
        return dates
    }
}
