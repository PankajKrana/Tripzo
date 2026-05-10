//
//  Trip.swift
//  Tripzo
//
//  Created by Pankaj Kumar Rana on 10/05/26.
//

import Foundation

struct Trip: Identifiable {
    let id: UUID
    let title: String
    let destination: String
    let startDate: Date
    let endDate: Date
    let image: String
    let price: Double
    let rating: Double
    let reviewCount: Int
    let description: String
    let location: String
    let travelers: Int
    let duration: Int
    var isFavorite: Bool
    let category: TripCategory
    let latitude: Double?
    let longitude: Double?
    
    enum TripCategory: String, CaseIterable {
        case beach = "Beach"
        case mountain = "Mountain"
        case adventure = "Adventure"
        case cultural = "Cultural"
        case city = "City"
        case nature = "Nature"
    }
    
    init(
        id: UUID = UUID(),
        title: String,
        destination: String,
        startDate: Date,
        endDate: Date,
        image: String,
        price: Double,
        rating: Double,
        reviewCount: Int = 0,
        description: String,
        location: String,
        travelers: Int,
        duration: Int,
        isFavorite: Bool = false,
        category: TripCategory = .adventure,
        latitude: Double? = nil,
        longitude: Double? = nil
    ) {
        self.id = id
        self.title = title
        self.destination = destination
        self.startDate = startDate
        self.endDate = endDate
        self.image = image
        self.price = price
        self.rating = rating
        self.reviewCount = reviewCount
        self.description = description
        self.location = location
        self.travelers = travelers
        self.duration = duration
        self.isFavorite = isFavorite
        self.category = category
        self.latitude = latitude
        self.longitude = longitude
    }
    
    var dayOfWeek: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        return formatter.string(from: startDate)
    }
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d"
        return formatter.string(from: startDate)
    }
    
    var pricePerPerson: String {
        String(format: "₹%.0f", price)
    }
}

// MARK: - Sample Data
extension Trip {
    static var sampleTrips: [Trip] {
        let today = Date()
        let calendar = Calendar.current
        
        return [
            Trip(
                title: "Goa Beach Paradise",
                destination: "Goa",
                startDate: calendar.date(byAdding: .day, value: 0, to: today)!,
                endDate: calendar.date(byAdding: .day, value: 3, to: today)!,
                image: "onbording1",
                price: 15000,
                rating: 4.8,
                reviewCount: 234,
                description: "Experience the vibrant beaches and nightlife of Goa",
                location: "📍 Goa, India",
                travelers: 4,
                duration: 3,
                isFavorite: true,
                category: .beach,
                latitude: 15.4909,
                longitude: 73.8278
            ),
            Trip(
                title: "Himalayan Adventure",
                destination: "Manali",
                startDate: calendar.date(byAdding: .day, value: 0, to: today)!,
                endDate: calendar.date(byAdding: .day, value: 5, to: today)!,
                image: "onbording1",
                price: 25000,
                rating: 4.9,
                reviewCount: 456,
                description: "Explore the majestic Himalayan mountains",
                location: "📍 Manali, India",
                travelers: 6,
                duration: 5,
                category: .mountain,
                latitude: 32.2406,
                longitude: 77.1887
            ),
            Trip(
                title: "Rajasthan Heritage",
                destination: "Jaipur",
                startDate: calendar.date(byAdding: .day, value: 1, to: today)!,
                endDate: calendar.date(byAdding: .day, value: 4, to: today)!,
                image: "onbording1",
                price: 12000,
                rating: 4.7,
                reviewCount: 312,
                description: "Discover the royal history and culture of Rajasthan",
                location: "📍 Jaipur, India",
                travelers: 3,
                duration: 3,
                category: .cultural,
                latitude: 26.9124,
                longitude: 75.7873
            ),
            Trip(
                title: "Kerala Backwaters",
                destination: "Kerala",
                startDate: calendar.date(byAdding: .day, value: 2, to: today)!,
                endDate: calendar.date(byAdding: .day, value: 5, to: today)!,
                image: "onbording1",
                price: 18000,
                rating: 4.6,
                reviewCount: 198,
                description: "Relax in the serene backwaters of Kerala",
                location: "📍 Kochi, India",
                travelers: 2,
                duration: 3,
                isFavorite: true,
                category: .nature,
                latitude: 9.9312,
                longitude: 76.2673
            ),
            Trip(
                title: "Delhi City Tour",
                destination: "Delhi",
                startDate: calendar.date(byAdding: .day, value: 3, to: today)!,
                endDate: calendar.date(byAdding: .day, value: 4, to: today)!,
                image: "onbording1",
                price: 8000,
                rating: 4.5,
                reviewCount: 567,
                description: "Explore the monuments and markets of Delhi",
                location: "📍 Delhi, India",
                travelers: 5,
                duration: 1,
                category: .city,
                latitude: 28.7041,
                longitude: 77.1025
            ),
            Trip(
                title: "Mysore Palace Tour",
                destination: "Mysore",
                startDate: calendar.date(byAdding: .day, value: 5, to: today)!,
                endDate: calendar.date(byAdding: .day, value: 7, to: today)!,
                image: "onbording1",
                price: 10000,
                rating: 4.4,
                reviewCount: 289,
                description: "Visit the magnificent Mysore Palace",
                location: "📍 Mysore, India",
                travelers: 4,
                duration: 2,
                category: .cultural,
                latitude: 12.2958,
                longitude: 76.6394
            ),
        ]
    }
}
