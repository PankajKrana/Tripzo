//
//  DateSelectionButton.swift
//  Tripzo
//

import SwiftUI

struct DateSelectionButton: View {
    let date: Date
    let isSelected: Bool
    let action: () -> Void
    
    private var dayOfWeek: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        return formatter.string(from: date)
    }
    
    private var dayOfMonth: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter.string(from: date)
    }
    
    private var isToday: Bool {
        Calendar.current.isDateInToday(date)
    }
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 6) {
                Text(dayOfWeek.uppercased())
                    .font(.caption)
                    .fontWeight(.semibold)
                
                Text(dayOfMonth)
                    .font(.headline)
                    .fontWeight(.bold)
                
                if isToday {
                    Circle()
                        .fill(.blue)
                        .frame(width: 4, height: 4)
                }
            }
            .frame(width: 60, height: 80)
            .background(isSelected ? Color.blue : Color.white)
            .foregroundStyle(isSelected ? .white : .primary)
            .clipShape(.rect(cornerRadius: 12))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(isSelected ? Color.clear : Color.gray.opacity(0.2), lineWidth: 1)
            )
        }
        .accessibilityLabel("Select \(dayOfWeek), \(dayOfMonth)")
    }
}

#Preview {
    DateSelectionButton(date: Date(), isSelected: false, action: {})
}
