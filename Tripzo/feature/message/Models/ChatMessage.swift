//
//  ChatMessage.swift
//  Tripzo
//
//  Created by Pankaj Kumar Rana on 10/05/26.
//

import Foundation

struct ChatMessage: Identifiable {
    let id: UUID
    let senderId: String
    let senderName: String
    let senderAvatar: String
    let content: String
    let timestamp: Date
    let isRead: Bool
    var messageType: MessageType
    
    enum MessageType {
        case text
        case image
        case emoji
        case systemMessage
    }
    
    init(
        id: UUID = UUID(),
        senderId: String,
        senderName: String,
        senderAvatar: String,
        content: String,
        timestamp: Date = Date(),
        isRead: Bool = false,
        messageType: MessageType = .text
    ) {
        self.id = id
        self.senderId = senderId
        self.senderName = senderName
        self.senderAvatar = senderAvatar
        self.content = content
        self.timestamp = timestamp
        self.isRead = isRead
        self.messageType = messageType
    }
    
    var formattedTime: String {
        let formatter = DateFormatter()
        let calendar = Calendar.current
        
        if calendar.isDateInToday(timestamp) {
            formatter.dateFormat = "h:mm a"
        } else if calendar.isDateInYesterday(timestamp) {
            return "Yesterday"
        } else {
            formatter.dateFormat = "MMM d"
        }
        
        return formatter.string(from: timestamp)
    }
    
    var isCurrentUser: Bool {
        senderId == "current_user"
    }
}

struct Conversation: Identifiable {
    let id: UUID
    let userId: String
    let userName: String
    let userAvatar: String
    let lastMessage: String
    let lastMessageTime: Date
    let unreadCount: Int
    let isOnline: Bool
    var messages: [ChatMessage]
    
    init(
        id: UUID = UUID(),
        userId: String,
        userName: String,
        userAvatar: String,
        lastMessage: String,
        lastMessageTime: Date = Date(),
        unreadCount: Int = 0,
        isOnline: Bool = false,
        messages: [ChatMessage] = []
    ) {
        self.id = id
        self.userId = userId
        self.userName = userName
        self.userAvatar = userAvatar
        self.lastMessage = lastMessage
        self.lastMessageTime = lastMessageTime
        self.unreadCount = unreadCount
        self.isOnline = isOnline
        self.messages = messages
    }
    
    var lastMessageTimeFormatted: String {
        let formatter = DateFormatter()
        let calendar = Calendar.current
        
        if calendar.isDateInToday(lastMessageTime) {
            formatter.dateFormat = "h:mm a"
        } else if calendar.isDateInYesterday(lastMessageTime) {
            return "Yesterday"
        } else {
            formatter.dateFormat = "MMM d"
        }
        
        return formatter.string(from: lastMessageTime)
    }
}

// MARK: - Sample Data
extension Conversation {
    static var sampleConversations: [Conversation] {
        let calendar = Calendar.current
        let now = Date()
        
        return [
            Conversation(
                userId: "user1",
                userName: "Priya Singh",
                userAvatar: "person.fill",
                lastMessage: "That's awesome! Can't wait for the trip 🎉",
                lastMessageTime: calendar.date(byAdding: .minute, value: -15, to: now) ?? now,
                unreadCount: 2,
                isOnline: true,
                messages: [
                    ChatMessage(
                        senderId: "user1",
                        senderName: "Priya Singh",
                        senderAvatar: "person.fill",
                        content: "Hey! How's everything going?",
                        timestamp: calendar.date(byAdding: .hour, value: -2, to: now) ?? now
                    ),
                    ChatMessage(
                        senderId: "current_user",
                        senderName: "You",
                        senderAvatar: "person.fill",
                        content: "Hi Priya! All good, planning the Goa trip",
                        timestamp: calendar.date(byAdding: .hour, value: -1, to: now) ?? now,
                        isRead: true
                    ),
                    ChatMessage(
                        senderId: "user1",
                        senderName: "Priya Singh",
                        senderAvatar: "person.fill",
                        content: "That's awesome! Can't wait for the trip 🎉",
                        timestamp: calendar.date(byAdding: .minute, value: -15, to: now) ?? now
                    )
                ]
            ),
            Conversation(
                userId: "user2",
                userName: "Rahul Patel",
                userAvatar: "person.fill",
                lastMessage: "See you at the airport",
                lastMessageTime: calendar.date(byAdding: .hour, value: -1, to: now) ?? now,
                unreadCount: 0,
                isOnline: false,
                messages: [
                    ChatMessage(
                        senderId: "user2",
                        senderName: "Rahul Patel",
                        senderAvatar: "person.fill",
                        content: "Flight is at 6 PM tomorrow",
                        timestamp: calendar.date(byAdding: .hour, value: -2, to: now) ?? now
                    ),
                    ChatMessage(
                        senderId: "current_user",
                        senderName: "You",
                        senderAvatar: "person.fill",
                        content: "Got it! I'll be there by 4",
                        timestamp: calendar.date(byAdding: .hour, value: -1, to: now) ?? now,
                        isRead: true
                    ),
                    ChatMessage(
                        senderId: "user2",
                        senderName: "Rahul Patel",
                        senderAvatar: "person.fill",
                        content: "See you at the airport",
                        timestamp: calendar.date(byAdding: .minute, value: -30, to: now) ?? now,
                        isRead: true
                    )
                ]
            ),
            Conversation(
                userId: "user3",
                userName: "Anjali Verma",
                userAvatar: "person.fill",
                lastMessage: "Room booking is confirmed! 🏨",
                lastMessageTime: calendar.date(byAdding: .hour, value: -3, to: now) ?? now,
                unreadCount: 1,
                isOnline: true,
                messages: [
                    ChatMessage(
                        senderId: "user3",
                        senderName: "Anjali Verma",
                        senderAvatar: "person.fill",
                        content: "I booked the hotel for us",
                        timestamp: calendar.date(byAdding: .hour, value: -4, to: now) ?? now
                    ),
                    ChatMessage(
                        senderId: "user3",
                        senderName: "Anjali Verma",
                        senderAvatar: "person.fill",
                        content: "Room booking is confirmed! 🏨",
                        timestamp: calendar.date(byAdding: .hour, value: -3, to: now) ?? now
                    )
                ]
            ),
            Conversation(
                userId: "user4",
                userName: "Nikhil Kumar",
                userAvatar: "person.fill",
                lastMessage: "👍",
                lastMessageTime: calendar.date(byAdding: .day, value: -1, to: now) ?? now,
                unreadCount: 0,
                isOnline: false,
                messages: []
            ),
            Conversation(
                userId: "user5",
                userName: "Sneha Sharma",
                userAvatar: "person.fill",
                lastMessage: "Let me know the dates!",
                lastMessageTime: calendar.date(byAdding: .day, value: -2, to: now) ?? now,
                unreadCount: 0,
                isOnline: false,
                messages: []
            ),
            Conversation(
                userId: "user6",
                userName: "Arjun Singh",
                userAvatar: "person.fill",
                lastMessage: "Sounds great! Count me in 🎊",
                lastMessageTime: calendar.date(byAdding: .day, value: -3, to: now) ?? now,
                unreadCount: 0,
                isOnline: true,
                messages: []
            ),
        ]
    }
}
