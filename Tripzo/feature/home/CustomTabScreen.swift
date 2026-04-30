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
                
            }
            
            Tab("Message", systemImage: "ellipsis.message") {
                
            }
            Tab("Profile", systemImage: "person") {
                
            }
            Tab("Search", systemImage: "magnifyingglass", role: .search) {
                
            }
        }
        
    }
}

#Preview {
    CustomTabScreen()
}
