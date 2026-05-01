//
//  HomeFlowScreen.swift
//  Tripzo
//
//  Created by Codex on 01/05/26.
//

import SwiftUI

struct HomeFlowScreen: View {
    @State private var path: [Route] = []

    var body: some View {
        NavigationStack(path: $path) {
            CustomTabScreen()
        }
    }
}

private extension HomeFlowScreen {
    enum Route: Hashable {}
}

#Preview {
    HomeFlowScreen()
}
