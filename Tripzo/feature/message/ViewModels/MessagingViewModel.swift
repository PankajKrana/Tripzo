//
//  MessagingViewModel.swift
//  Tripzo
//
//  Created by Pankaj Kumar Rana on 10/05/26.
//

import Foundation
import Combine

@MainActor
final class MessagingViewModel: ObservableObject {
    @Published var conversations: [Conversation] = Conversation.sampleConversations
    @Published var currentConversation: Conversation?
    @Published var messageText: String = ""
    @Published var searchText: String = ""
    @Published var isTyping: Bool = false
    @Published var selectedFilter: MessageFilter = .all
    
    enum MessageFilter: String, CaseIterable {
        case all = "All"
        case unread = "Unread"
        case archived = "Archived"
    }
    
    var filteredConversations: [Conversation] {
        let searched = searchText.isEmpty ? conversations : conversations.filter { conversation in
            conversation.userName.localizedCaseInsensitiveContains(searchText)
        }
        
        switch selectedFilter {
        case .all:
            return searched.sorted { $0.lastMessageTime > $1.lastMessageTime }
        case .unread:
            return searched.filter { $0.unreadCount > 0 }.sorted { $0.lastMessageTime > $1.lastMessageTime }
        case .archived:
            return []
        }
    }
    
    func selectConversation(_ conversation: Conversation) {
        currentConversation = conversation
    }
    
    func sendMessage(_ content: String) {
        guard !content.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
              var conversation = currentConversation else { return }
        
        let newMessage = ChatMessage(
            senderId: "current_user",
            senderName: "You",
            senderAvatar: "person.fill",
            content: content,
            timestamp: Date(),
            isRead: true
        )
        
        conversation.messages.append(newMessage)
        
        if let index = conversations.firstIndex(where: { $0.id == conversation.id }) {
            conversations[index] = conversation
            currentConversation = conversation
        }
        
        messageText = ""
        
        // Simulate reply
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.simulateReply(to: &conversation)
        }
    }
    
    private func simulateReply(to conversation: inout Conversation) {
        let replies = [
            "Haha, that's great! 😄",
            "I agree! 👍",
            "That sounds perfect!",
            "Can't wait! 🎉",
            "Let me check and get back to you",
            "Sounds good to me!",
            "Thanks for letting me know!",
            "Will do! ✓",
            "See you soon! 👋",
        ]
        
        let randomReply = replies.randomElement() ?? "Got it!"
        let replyMessage = ChatMessage(
            senderId: conversation.userId,
            senderName: conversation.userName,
            senderAvatar: conversation.userAvatar,
            content: randomReply,
            timestamp: Date(),
            isRead: false
        )
        
        conversation.messages.append(replyMessage)
        
        if let index = conversations.firstIndex(where: { $0.id == conversation.id }) {
            conversations[index] = conversation
            currentConversation = conversation
        }
    }
    
    func deleteMessage(_ message: ChatMessage) {
        guard var conversation = currentConversation else { return }
        conversation.messages.removeAll { $0.id == message.id }
        
        if let index = conversations.firstIndex(where: { $0.id == conversation.id }) {
            conversations[index] = conversation
            currentConversation = conversation
        }
    }
    
    func markAsRead(_ conversation: Conversation) {
        if let index = conversations.firstIndex(where: { $0.id == conversation.id }) {
            var updated = conversations[index]
            updated = Conversation(
                id: updated.id,
                userId: updated.userId,
                userName: updated.userName,
                userAvatar: updated.userAvatar,
                lastMessage: updated.lastMessage,
                lastMessageTime: updated.lastMessageTime,
                unreadCount: 0,
                isOnline: updated.isOnline,
                messages: updated.messages
            )
            conversations[index] = updated
        }
    }
}
