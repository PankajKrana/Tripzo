//
//  Typography.swift
//  Tripzo
//

import SwiftUI

struct TripzoTypography {
    // Display
    static let displayLarge = Font.system(size: 57, weight: .bold, design: .default)
    static let displayMedium = Font.system(size: 45, weight: .bold, design: .default)
    static let displaySmall = Font.system(size: 36, weight: .bold, design: .default)

    // Headline
    static let headlineLarge = Font.system(size: 32, weight: .bold, design: .default)
    static let headlineMedium = Font.system(size: 28, weight: .semibold, design: .default)
    static let headlineSmall = Font.system(size: 24, weight: .semibold, design: .default)

    // Title
    static let titleLarge = Font.system(size: 22, weight: .semibold, design: .default)
    static let titleMedium = Font.system(size: 18, weight: .semibold, design: .default)
    static let titleSmall = Font.system(size: 16, weight: .semibold, design: .default)

    // Body
    static let bodyLarge = Font.system(size: 16, weight: .regular, design: .default)
    static let bodyMedium = Font.system(size: 14, weight: .regular, design: .default)
    static let bodySmall = Font.system(size: 12, weight: .regular, design: .default)

    // Label
    static let labelLarge = Font.system(size: 14, weight: .medium, design: .default)
    static let labelMedium = Font.system(size: 12, weight: .medium, design: .default)
    static let labelSmall = Font.system(size: 11, weight: .medium, design: .default)

    // Decorative
    static let serifs = Font.system(size: 34, weight: .semibold, design: .serif)
    static let serifsMedium = Font.system(size: 28, weight: .semibold, design: .serif)
}

extension Font {
    static var displayLarge: Font { TripzoTypography.displayLarge }
    static var displayMedium: Font { TripzoTypography.displayMedium }
    static var displaySmall: Font { TripzoTypography.displaySmall }

    static var headlineLarge: Font { TripzoTypography.headlineLarge }
    static var headlineMedium: Font { TripzoTypography.headlineMedium }
    static var headlineSmall: Font { TripzoTypography.headlineSmall }

    static var titleLarge: Font { TripzoTypography.titleLarge }
    static var titleMedium: Font { TripzoTypography.titleMedium }
    static var titleSmall: Font { TripzoTypography.titleSmall }

    static var bodyLarge: Font { TripzoTypography.bodyLarge }
    static var bodyMedium: Font { TripzoTypography.bodyMedium }
    static var bodySmall: Font { TripzoTypography.bodySmall }

    static var labelLarge: Font { TripzoTypography.labelLarge }
    static var labelMedium: Font { TripzoTypography.labelMedium }
    static var labelSmall: Font { TripzoTypography.labelSmall }
}
