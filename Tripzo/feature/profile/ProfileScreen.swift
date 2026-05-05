//
//  ProfileScreen.swift
//  Tripzo
//
//  Created by Pankaj Kumar Rana on 03/05/26.
//

import SwiftUI

struct ProfileScreen: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 15) {
                Circle()
                    .fill(.gray.opacity(0.4))
                    .frame(width: 140, height: 140)
                    
                Text("Alex")
                    .font(.title2)
                    .multilineTextAlignment(.center)
                
                Text("alex@gmail.com")
                    .font(.title3)
                    .foregroundStyle(.primary)
                    .multilineTextAlignment(.center)
                
                
                HStack {
                    ProfileStatView(text: "Reward Points", value: "123")
                    ProfileStatView(text: "Travel Trips", value: "123")
                    ProfileStatView(text: "Bucket List", value: "123")
                }
                .frame(maxWidth: .infinity)
                .padding(.top, 20)
                
                VStack(spacing: 0) {
                    NavigationLink(destination: Text("Profile Detail")) {
                        ProfileRow(icon: "person", title: "Profile")
                    }
                    Divider()
                    NavigationLink(destination: Text("Bookmarked")) {
                        ProfileRow(icon: "bookmark", title: "Bookmarked")
                    }
                    Divider()
                    NavigationLink(destination: Text("Previous Trips")) {
                        ProfileRow(icon: "airplane", title: "Previous Trips")
                    }
                    Divider()
                    NavigationLink(destination: Text("Settings")) {
                        ProfileRow(icon: "gearshape", title: "Settings")
                    }
                    Divider()
                    NavigationLink(destination: Text("Version")) {
                        ProfileRow(icon: "info.circle", title: "Version")
                    }
                        
                }
                .cornerRadius(16)
                .padding(.top, 20)
                .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 4)
                Spacer()
                
            }
            .padding(.horizontal, 20)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                        
                    }
                    .accessibilityLabel("Back")
                }
                
                ToolbarItem(placement: .principal) {
                    Text("Profile")
                        .font(.headline)
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        
                    } label: {
                        Image(systemName: "pencil.line")
                    }
                    .accessibilityLabel("Edit Profile")
                }
            }
        }
    }
}

struct ProfileRow: View {
    var icon: String
    var title: String

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 18))
                .foregroundStyle(.gray)
                .frame(width: 24)

            Text(title)
                .foregroundStyle(.primary)

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundStyle(.gray)
                .font(.system(size: 14, weight: .semibold))
        }
        .padding()
    }
}

private struct ProfileStatView: View {
    let text: String
    let value: String

    var body: some View {
        VStack(spacing: 4) {
            Text(text)
                .font(.caption)
                .foregroundStyle(.gray)

            Text(value)
                .font(.headline)
        }
        .frame(maxWidth: .infinity)
    }
}
#Preview {
    ProfileScreen()
}
