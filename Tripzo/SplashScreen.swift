//
//  SplashScreen.swift
//  Tripzo
//
//  Created by Pankaj Kumar Rana on 24/04/26.
//

import SwiftUI

struct SplashScreen: View {
    var body: some View {
        ZStack {
            Color.blue.ignoresSafeArea()
            
            VStack {
                Text("Tripzo")
                    .font(.custom("AveriaSerifLibre-Regular", size: 70))
                    .foregroundStyle(.white)
            }
        }
    }
}

#Preview {
    SplashScreen()
}
