//
//  MessagesScreen.swift
//  Tripzo
//
//  Created by Pankaj Kumar Rana on 10/05/26.
//

import SwiftUI

struct MessagesScreen: View {
    @StateObject private var viewModel = MessagingViewModel()
    @State private var showNewChat = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(spacing: 0) {
                    // Header
                    headerView
                    
                    // Filter Tabs
                    filterTabsView
                    
                    // Search Bar
                    searchBarView
                    
                    // Conversations List
                    if viewModel.filteredConversations.isEmpty {
                        emptyStateView
                    } else {
                        ScrollView(.vertical, showsIndicators: false) {
                            LazyVStack(spacing: 0) {
                                ForEach(viewModel.filteredConversations) { conversation in
                                    NavigationLink(
                                        destination: ChatDetailScreen(viewModel: viewModel)
                                    ) {
                                        ConversationRowView(conversation: conversation)
                                            .contentShape(Rectangle())
                                            .onTapGesture {
                                                viewModel.selectConversation(conversation)
                                            }
                                    }
                                    
                                    Divider()
                                        .padding(.horizontal, 16)
                                }
                            }
                            .background(Color.white)
                        }
                    }
                }
                .background(Color(.systemGray6))
                
                // Floating Action Button
                VStack {
                    HStack {
                        Spacer()
                        
                        Button(action: { showNewChat = true }) {
                            Image(systemName: "square.and.pencil")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundStyle(.white)
                                .frame(width: 56, height: 56)
                                .background(Color.blue)
                                .clipShape(Circle())
                                .shadow(color: .blue.opacity(0.5), radius: 10, x: 0, y: 4)
                        }
                        .accessibilityLabel("New Message")
                        .padding(20)
                    }
                    
                    Spacer()
                }
            }
            .navigationBarBackButtonHidden(true)
            .sheet(isPresented: $showNewChat) {
                NewChatSheet(isPresented: $showNewChat)
            }
        }
    }
    
    private var headerView: some View {
        VStack(spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Messages")
                        .font(.system(size: 32, weight: .bold))
                    Text("Stay connected with friends")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                
                Spacer()
                
                Menu {
                    Button("Mark all as read", action: {})
                    Button("Settings", action: {})
                    Button("Help", action: {})
                } label: {
                    Image(systemName: "ellipsis.circle.fill")
                        .font(.system(size: 24))
                        .foregroundStyle(.gray)
                }
                .accessibilityLabel("More options")
            }
            .padding(.horizontal, 16)
            .padding(.top, 12)
        }
        .background(Color.white)
    }
    
    private var filterTabsView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(MessagingViewModel.MessageFilter.allCases, id: \.self) { filter in
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            viewModel.selectedFilter = filter
                        }
                    }) {
                        Text(filter.rawValue)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(
                                viewModel.selectedFilter == filter
                                    ? Color.blue
                                    : Color(.systemGray5)
                            )
                            .foregroundStyle(
                                viewModel.selectedFilter == filter
                                    ? .white
                                    : .primary
                            )
                            .clipShape(.capsule)
                    }
                }
                
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
        }
        .background(Color.white)
    }
    
    private var searchBarView: some View {
        HStack(spacing: 8) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.gray)
            
            TextField("Search conversations", text: $viewModel.searchText)
                .textFieldStyle(.plain)
                .autocorrectionDisabled()
            
            if !viewModel.searchText.isEmpty {
                Button(action: {
                    viewModel.searchText = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(.gray)
                }
            }
        }
        .padding(10)
        .background(Color(.systemGray5))
        .clipShape(.rect(cornerRadius: 20))
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color.white)
    }
    
    private var emptyStateView: some View {
        VStack(spacing: 16) {
            Image(systemName: "bubble.right")
                .font(.system(size: 48))
                .foregroundStyle(.gray)
            
            VStack(spacing: 4) {
                Text("No conversations")
                    .font(.headline)
                    .foregroundStyle(.primary)
                
                Text("Start a new chat to connect with others")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }
            
            Button(action: { showNewChat = true }) {
                HStack(spacing: 8) {
                    Image(systemName: "square.and.pencil")
                    Text("Start New Chat")
                }
                .frame(maxWidth: .infinity)
                .frame(height: 44)
                .foregroundStyle(.white)
                .background(.blue)
                .clipShape(.rect(cornerRadius: 10))
            }
            .padding(.top, 8)
        }
        .frame(maxWidth: .infinity)
        .padding(32)
        .background(Color.white)
        .clipShape(.rect(cornerRadius: 16))
        .padding(16)
    }
}

// MARK: - Conversation Row
struct ConversationRowView: View {
    let conversation: Conversation
    
    var body: some View {
        HStack(spacing: 12) {
            // Avatar with online indicator
            ZStack(alignment: .bottomTrailing) {
                Circle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [.blue.opacity(0.6), .purple.opacity(0.6)]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 56, height: 56)
                    .overlay(
                        Image(systemName: conversation.userAvatar)
                            .font(.system(size: 20))
                            .foregroundStyle(.white)
                    )
                
                if conversation.isOnline {
                    Circle()
                        .fill(.green)
                        .frame(width: 14, height: 14)
                        .overlay(Circle().stroke(.white, lineWidth: 2))
                }
            }
            
            // Message info
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(conversation.userName)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .lineLimit(1)
                    
                    Spacer()
                    
                    Text(conversation.lastMessageTimeFormatted)
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                }
                
                HStack {
                    Text(conversation.lastMessage)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                    
                    Spacer()
                    
                    if conversation.unreadCount > 0 {
                        Text("\(conversation.unreadCount)")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .frame(width: 20, height: 20)
                            .background(.blue)
                            .clipShape(Circle())
                    }
                }
            }
            
            Spacer()
        }
        .padding(12)
        .background(Color.white)
    }
}

// MARK: - New Chat Sheet
struct NewChatSheet: View {
    @Binding var isPresented: Bool
    @State private var searchText: String = ""
    
    let suggestedUsers = [
        ("Priya Singh", "person.fill", true),
        ("Rahul Patel", "person.fill", false),
        ("Anjali Verma", "person.fill", true),
        ("Nikhil Kumar", "person.fill", false),
    ]
    
    var filteredUsers: [(String, String, Bool)] {
        if searchText.isEmpty {
            return suggestedUsers
        }
        return suggestedUsers.filter { $0.0.localizedCaseInsensitiveContains(searchText) }
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                HStack {
                    TextField("Search people", text: $searchText)
                        .textFieldStyle(.roundedBorder)
                    
                    Button("Cancel") {
                        isPresented = false
                    }
                    .font(.subheadline)
                }
                .padding(16)
                
                List {
                    Section("Suggested") {
                        ForEach(filteredUsers, id: \.0) { user in
                            HStack(spacing: 12) {
                                Circle()
                                    .fill(
                                        LinearGradient(
                                            gradient: Gradient(colors: [.blue.opacity(0.6), .purple.opacity(0.6)]),
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                                    .frame(width: 44, height: 44)
                                    .overlay(
                                        Image(systemName: user.1)
                                            .font(.system(size: 16))
                                            .foregroundStyle(.white)
                                    )
                                
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(user.0)
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                    
                                    Text(user.2 ? "Active now" : "Active 2h ago")
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                                
                                Spacer()
                                
                                Button(action: { isPresented = false }) {
                                    Text("Message")
                                        .font(.caption)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(.blue)
                                }
                            }
                        }
                    }
                }
                .listStyle(.insetGrouped)
            }
            .navigationTitle("New Message")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    MessagesScreen()
}
