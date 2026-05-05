//
//  ContentView.swift
//  Tripzo
//
//  Created by Pankaj Kumar Rana on 24/04/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        AppCoordinator()
    }
}

#Preview {
    ContentView()
        .environmentObject(AuthManager())
}
