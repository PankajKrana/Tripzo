//
//  ChatDetailScreen.swift
//  Tripzo
//
//  Created by Pankaj Kumar Rana on 10/05/26.
//

import SwiftUI

struct ChatDetailScreen: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: MessagingViewModel
    @FocusState private var isFocused: Bool
    
    var conversation: Conversation {
        viewModel.currentConversation ?? .init(
            userId: "",
            userName: "Chat",
            userAvatar: "person.fill",
            lastMessage: "",
            messages: []
        )
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            chatHeader
            
            Divider()
            
            // Messages
            ScrollViewReader { proxy in
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 12) {
                        ForEach(conversation.messages) { message in
                            ChatBubble(
                                message: message,
                                onDelete: {
                                    viewModel.deleteMessage(message)
                                }
                            )
                            .id(message.id)
                        }
                    }
                    .padding(16)
                }
                .onChange(of: conversation.messages.count) { _, _ in
                    if let lastMessage = conversation.messages.last {
                        withAnimation {
                            proxy.scrollTo(lastMessage.id, anchor: .bottom)
                        }
                    }
                }
                .onAppear {
                    if let lastMessage = conversation.messages.last {
                        proxy.scrollTo(lastMessage.id, anchor: .bottom)
                    }
                }
            }
            
            Divider()
            
            // Input Area
            messageInputArea
        }
        .navigationBarBackButtonHidden(true)
        .background(Color(.systemGray6))
        .onAppear {
            viewModel.markAsRead(conversation)
        }
    }
    
    private var chatHeader: some View {
        HStack(spacing: 12) {
            Button(action: { dismiss() }) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.primary)
            }
            .accessibilityLabel("Back")
            
            // User Info
            HStack(spacing: 10) {
                Circle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [.blue.opacity(0.6), .purple.opacity(0.6)]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 40, height: 40)
                    .overlay(
                        Image(systemName: conversation.userAvatar)
                            .font(.system(size: 16))
                            .foregroundStyle(.white)
                    )
                    .overlay(
                        Circle()
                            .fill(conversation.isOnline ? .green : .gray)
                            .frame(width: 12, height: 12)
                            .offset(x: 12, y: 12)
                    )
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(conversation.userName)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    
                    Text(conversation.isOnline ? "Active now" : "Active 2h ago")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            
            Spacer()
            
            // Action Buttons
            HStack(spacing: 16) {
                Button(action: {}) {
                    Image(systemName: "phone.fill")
                        .font(.system(size: 16))
                        .foregroundStyle(.blue)
                }
                .accessibilityLabel("Call \(conversation.userName)")
                
                Button(action: {}) {
                    Image(systemName: "video.fill")
                        .font(.system(size: 16))
                        .foregroundStyle(.blue)
                }
                .accessibilityLabel("Video call \(conversation.userName)")
                
                Menu {
                    Button("View Profile", action: {})
                    Button("Mute", action: {})
                    Button("Block", role: .destructive, action: {})
                } label: {
                    Image(systemName: "ellipsis")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(.primary)
                }
                .accessibilityLabel("More options")
            }
        }
        .padding(16)
        .background(Color.white)
    }
    
    private var messageInputArea: some View {
        HStack(spacing: 8) {
            // Emoji button
            Button(action: {}) {
                Image(systemName: "smiley")
                    .font(.system(size: 18))
                    .foregroundStyle(.blue)
            }
            .accessibilityLabel("Insert emoji")
            
            // Text input
            HStack(spacing: 8) {
                TextField("Message...", text: $viewModel.messageText)
                    .textFieldStyle(.roundedBorder)
                    .focused($isFocused)
                    .frame(minHeight: 36)
                
                // Camera button
                Button(action: {}) {
                    Image(systemName: "camera.fill")
                        .font(.system(size: 16))
                        .foregroundStyle(.blue)
                }
                .accessibilityLabel("Send photo")
            }
            
            // Send button
            Button(action: {
                viewModel.sendMessage(viewModel.messageText)
            }) {
                Image(systemName: viewModel.messageText.isEmpty ? "heart.fill" : "paperplane.fill")
                    .font(.system(size: 18))
                    .foregroundStyle(.white)
                    .frame(width: 36, height: 36)
                    .background(viewModel.messageText.isEmpty ? Color.red.opacity(0.7) : Color.blue)
                    .clipShape(Circle())
            }
            .accessibilityLabel(viewModel.messageText.isEmpty ? "Send heart" : "Send message")
        }
        .padding(12)
        .background(Color.white)
    }
}

// MARK: - Chat Bubble
struct ChatBubble: View {
    let message: ChatMessage
    let onDelete: () -> Void
    @State private var showDeleteOption = false
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 8) {
            if message.isCurrentUser {
                Spacer()
            } else {
                Circle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [.blue.opacity(0.6), .purple.opacity(0.6)]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 32, height: 32)
                    .overlay(
                        Image(systemName: message.senderAvatar)
                            .font(.system(size: 14))
                            .foregroundStyle(.white)
                    )
            }
            
            VStack(alignment: message.isCurrentUser ? .trailing : .leading, spacing: 4) {
                HStack {
                    messageBubble
                        .contextMenu {
                            Button(role: .destructive) {
                                onDelete()
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                            
                            Button {
                                UIPasteboard.general.string = message.content
                            } label: {
                                Label("Copy", systemImage: "doc.on.doc")
                            }
                        }
                }
                
                HStack(spacing: 4) {
                    Text(message.formattedTime)
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                    
                    if message.isCurrentUser && message.isRead {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 10))
                            .foregroundStyle(.blue)
                    }
                }
            }
            
            if !message.isCurrentUser {
                Spacer()
            }
        }
    }
    
    private var messageBubble: some View {
        Text(message.content)
            .font(.body)
            .foregroundStyle(message.isCurrentUser ? .white : .primary)
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(
                message.isCurrentUser
                    ? Color.blue
                    : Color(.systemGray5)
            )
            .clipShape(.rect(cornerRadius: 16))
            .lineLimit(nil)
    }
}

#Preview {
    ChatDetailScreen(
        viewModel: MessagingViewModel()
    )
}
