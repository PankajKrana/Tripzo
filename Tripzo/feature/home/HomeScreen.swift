//
//  HomeScreen.swift
//  Tripzo
//
//  Created by Pankaj Kumar Rana on 25/04/26.
//

import SwiftUI

struct HomeScreen: View {
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 30) {
                // top bar view
                topBar
                
                // title bar
                Text("Explore the \nBeautiful world!")
                    .font(.custom("AveriaSerifLibre-Regular", size: 40))
                
                // Divider text
                dividerText
                
                // ScrollView Content
                scrollContent
                
            }
            .padding()
        }
    }
}


extension HomeScreen {
    @ViewBuilder
    private var topBar: some View {
        HStack {
            Capsule()
                .frame(width: 120, height: 50, alignment: .topLeading)
                .overlay {
                    HStack {
                        Circle()
                            .fill(.blue)
                            .frame(height: 50)
                        Spacer()
                    }
                    
                }
            Spacer()
            
            Button {
                
            } label: {
                Circle()
                    .fill(.gray.opacity(0.2))
                    .frame(height: 50)
                    .overlay {
                        Image(systemName: "bell")
                            .font(.system(size: 20))
                            .foregroundStyle(.black)
                    }
            }
            
        }
        
    }
    
    @ViewBuilder
    private var  dividerText: some View {
        HStack {
            Text("Best Destination")
                .font(.system(size: 20))
                .bold()
            
            Spacer()
            
            Button {
                // TODO: Action
            } label: {
                Text("View all")
                    .font(.system(size: 14))
                    .foregroundStyle(.blue)
            }
            
        }
        
    }
    
    @ViewBuilder
    private var scrollContent: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 20) {
                ForEach(0..<10) { index in
                    RoundedRectangle(cornerRadius: 40)
                        .fill(.gray.opacity(0.1))
                        .frame(width: 268, height: 384)
                        .overlay {
                            VStack {
                                RoundedRectangle(cornerRadius: 20)
                                    .frame(width: 240, height: 286)
                                    .overlay {
                                        Image(.onbording1)
                                            .resizable()
                                            .scaledToFit()
                                    }
                            }
                        }
                }
            }
            .scrollTargetLayout()
            .scrollIndicators(.hidden)
        }
    }
    
    
}

#Preview {
    HomeScreen()
}
