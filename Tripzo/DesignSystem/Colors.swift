//
//  Colors.swift
//  Tripzo
//

import SwiftUI

struct TripzoColors {
    // Primary Colors
    static let primary = Color(red: 0.2, green: 0.4, blue: 1.0)
    static let primaryDark = Color(red: 0.1, green: 0.25, blue: 0.8)
    static let primaryLight = Color(red: 0.5, green: 0.7, blue: 1.0)

    // Secondary Colors
    static let secondary = Color(red: 0.0, green: 0.8, blue: 0.6)
    static let secondaryDark = Color(red: 0.0, green: 0.65, blue: 0.45)

    // Accent Colors
    static let accent = Color(red: 1.0, green: 0.6, blue: 0.0)
    static let accentLight = Color(red: 1.0, green: 0.75, blue: 0.3)

    // Status Colors
    static let success = Color(red: 0.2, green: 0.85, blue: 0.4)
    static let warning = Color(red: 1.0, green: 0.7, blue: 0.0)
    static let error = Color(red: 1.0, green: 0.3, blue: 0.3)
    static let info = Color(red: 0.0, green: 0.5, blue: 1.0)

    // Neutral Colors
    static let surface = Color(red: 0.98, green: 0.98, blue: 0.99)
    static let surfaceDark = Color(red: 0.15, green: 0.15, blue: 0.16)
    static let background = Color.white
    static let backgroundDark = Color(red: 0.1, green: 0.1, blue: 0.11)

    // Text Colors
    static let textPrimary = Color(red: 0.1, green: 0.1, blue: 0.12)
    static let textSecondary = Color(red: 0.4, green: 0.4, blue: 0.42)
    static let textTertiary = Color(red: 0.6, green: 0.6, blue: 0.62)

    // Borders & Dividers
    static let border = Color(red: 0.85, green: 0.85, blue: 0.87)
    static let divider = Color(red: 0.9, green: 0.9, blue: 0.92)

    // Rating Colors
    static let ratingStar = Color(red: 1.0, green: 0.8, blue: 0.0)
    static let ratingBackground = Color(red: 0.95, green: 0.95, blue: 0.96)
}

extension Color {
    static var tripzoPrimary: Color { TripzoColors.primary }
    static var tripzoSecondary: Color { TripzoColors.secondary }
    static var tripzoAccent: Color { TripzoColors.accent }
    static var tripzoSurface: Color { TripzoColors.surface }
}
