//
//  ProfileScreen.swift
//  Tripzo
//
//  Created by Pankaj Kumar Rana on 03/05/26.
//

import SwiftUI

struct ProfileScreen: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var authManager: AuthManager
    @Environment(\.colorScheme) private var colorScheme
    @State private var isDarkMode = false
    @State private var showLogoutAlert = false
    @State private var isLoading = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // Profile Header
                    VStack(spacing: 12) {
                        // Profile Image
                        Circle()
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [.blue.opacity(0.6), .purple.opacity(0.6)]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(width: 120, height: 120)
                            .overlay(
                                Image(systemName: "person.fill")
                                    .font(.system(size: 50))
                                    .foregroundStyle(.white)
                            )
                        
                        Text("Alex Johnson")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Text("alex@gmail.com")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    
                    // Statistics
                    HStack(spacing: 12) {
                        ProfileStatView(text: "Reward Points", value: "1,250")
                        ProfileStatView(text: "Travel Trips", value: "8")
                        ProfileStatView(text: "Bucket List", value: "25")
                    }
                    .frame(maxWidth: .infinity)
                    
                    // Menu Items
                    VStack(spacing: 0) {
                        NavigationLink(destination: Text("Profile Detail Screen")) {
                            ProfileRow(icon: "person", title: "Edit Profile")
                        }
                        Divider()
                        
                        NavigationLink(destination: Text("Bookmarked Screen")) {
                            ProfileRow(icon: "bookmark", title: "Bookmarked Trips")
                        }
                        Divider()
                        
                        NavigationLink(destination: Text("Previous Trips Screen")) {
                            ProfileRow(icon: "airplane", title: "Previous Trips")
                        }
                        Divider()
                        
                        NavigationLink(destination: Text("Saved Places Screen")) {
                            ProfileRow(icon: "mappin", title: "Saved Places")
                        }
                        Divider()
                        
                        NavigationLink(destination: SettingsView(isDarkMode: $isDarkMode)) {
                            ProfileRow(icon: "gearshape", title: "Settings")
                        }
                        Divider()
                        
                        NavigationLink(destination: Text("App Version 1.0.0")) {
                            ProfileRow(icon: "info.circle", title: "App Version")
                        }
                    }
                    .clipShape(.rect(cornerRadius: 12))
                    .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 4)
                    
                    // Account Section
                    VStack(spacing: 0) {
                        // Dark Mode Toggle
                        HStack(spacing: 12) {
                            Image(systemName: "moon.stars")
                                .font(.system(size: 18))
                                .foregroundStyle(.orange)
                                .frame(width: 24)
                            
                            Text("Dark Mode")
                                .foregroundStyle(.primary)
                            
                            Spacer()
                            
                            Toggle("", isOn: $isDarkMode)
                                .labelsHidden()
                        }
                        .padding()
                        Divider()
                        
                        // Notifications Toggle
                        HStack(spacing: 12) {
                            Image(systemName: "bell")
                                .font(.system(size: 18))
                                .foregroundStyle(.blue)
                                .frame(width: 24)
                            
                            Text("Push Notifications")
                                .foregroundStyle(.primary)
                            
                            Spacer()
                            
                            Toggle("", isOn: .constant(true))
                                .labelsHidden()
                        }
                        .padding()
                    }
                    .clipShape(.rect(cornerRadius: 12))
                    .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 4)
                    
                    // Logout Button
                    Button(action: {
                        showLogoutAlert = true
                    }) {
                        HStack(spacing: 8) {
                            Image(systemName: "arrow.right.square")
                                .font(.system(size: 18))
                            Text("Logout")
                                .fontWeight(.semibold)
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .foregroundStyle(.white)
                        .background(.red.opacity(0.8))
                        .clipShape(.rect(cornerRadius: 12))
                    }
                    .disabled(isLoading)
                    
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 16)
            }
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
            }
            .alert("Logout", isPresented: $showLogoutAlert) {
                Button("Cancel", role: .cancel) { }
                Button("Logout", role: .destructive) {
                    Task {
                        await handleLogout()
                    }
                }
            } message: {
                Text("Are you sure you want to logout? You'll need to sign in again to continue.")
            }
        }
    }
    
    private func handleLogout() async {
        isLoading = true
        do {
            try await authManager.signOut()
        } catch {
            print("Logout error: \(error.localizedDescription)")
        }
        isLoading = false
    }
}

struct ProfileRow: View {
    let icon: String
    let title: String

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
            Text(value)
                .font(.headline)
                .fontWeight(.semibold)

            Text(text)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .padding(.horizontal, 8)
        .background(Color(.systemGray6))
        .clipShape(.rect(cornerRadius: 10))
    }
}

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var isDarkMode: Bool
    
    var body: some View {
        NavigationStack {
            List {
                Section("Appearance") {
                    Toggle(isOn: $isDarkMode) {
                        Label("Dark Mode", systemImage: "moon.stars")
                    }
                }
                
                Section("Privacy & Security") {
                    NavigationLink(destination: Text("Privacy Policy")) {
                        Label("Privacy Policy", systemImage: "lock.shield")
                    }
                    
                    NavigationLink(destination: Text("Terms & Conditions")) {
                        Label("Terms & Conditions", systemImage: "doc.text")
                    }
                }
                
                Section("Help & Support") {
                    NavigationLink(destination: Text("FAQ")) {
                        Label("FAQ", systemImage: "questionmark.circle")
                    }
                    
                    NavigationLink(destination: Text("Contact Us")) {
                        Label("Contact Us", systemImage: "envelope")
                    }
                }
                
                Section("About") {
                    HStack {
                        Text("App Version")
                        Spacer()
                        Text("1.0.0")
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ProfileScreen()
        .environmentObject(AuthManager())
}
