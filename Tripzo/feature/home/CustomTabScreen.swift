//
//  CustomTabScreen.swift
//  Tripzo
//
//  Created by Pankaj Kumar Rana on 24/04/26.
//

import SwiftUI

struct CustomTabScreen: View {
    var body: some View {
        TabView {
            Tab("Home", systemImage: "house") {
                HomeScreen()
            }
            Tab("Calendar", systemImage: "calendar") {
                PlaceholderTabView(title: "Calendar")
            }
            
            Tab("Message", systemImage: "ellipsis.message") {
                PlaceholderTabView(title: "Message")
            }
            Tab("Profile", systemImage: "person") {
                ProfileScreen()
            }
            Tab("Search", systemImage: "magnifyingglass", role: .search) {
                PlaceholderTabView(title: "Search")
            }
        }
        
    }
}

private struct PlaceholderTabView: View {
    let title: String

    var body: some View {
        ContentUnavailableView("\(title) Coming Soon", systemImage: "clock")
    }
}

#Preview {
    CustomTabScreen()
}
