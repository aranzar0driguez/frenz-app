//
//  MessageManager.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 10/28/24.
//

import Foundation
import FirebaseFirestore

final class MessageManager {
    
    static let shared = MessageManager()
    private init() { }
    
    @Published private(set) var messages: [Message] = []
    
    //  References the message collection databse
    private let messagesCollection = Firestore.firestore().collection("messages")
    
    //  Returns back a document that contains the collection of messages
    private func messagesDocument(messageID: String) -> DocumentReference {
        messagesCollection.document(messageID)
    }
    
    //  Adds a new collection of messages
    func createMessageMainDocument(giftSender: String, giftReceiver: String, lastMessage: String, isThisARomanticGift: Bool) async throws -> String{
        
        let messageInfo = MessageInfo(giftSender: giftSender, giftReceiver: giftReceiver, lastMessage: "", isThisARomanticGift: isThisARomanticGift)
        
        let document = messagesDocument(messageID: messageInfo.id.uuidString)
        try document.setData(from: messageInfo, merge: false)
        
        //  Updates both of the user's messaging field
        let successInFetchingUpdatingUsers = try await UserManager.shared.addMessageIDToBothUsers(user1: giftReceiver, user2: giftSender, messageID: messageInfo.id.uuidString)

        if !successInFetchingUpdatingUsers  {
            return ""
        } else {
            return messageInfo.id.uuidString
        }
        
    }
    //  Adds a subcollection
    func addMessageToSubCollection(messagesDocumentID: String, message: Message) async throws {
        
        
        try await messagesDocument(messageID: messagesDocumentID).collection("msglist").addDocument(from: message)
        
        let newMessage = message.text
        
        //  Update lastMessage
        let snapshot = try await messagesDocument(messageID: messagesDocumentID).getDocument()
                
        let data: [String : Any] = [
            MessageInfo.CodingKeys.lastMessage.rawValue : newMessage
        ]
        
        try await messagesDocument(messageID: messagesDocumentID).updateData(data)
        
    }
    
    func getMessageMainDocument(messageID: String) async throws -> MessageInfo? {
        
        let snapshot = try await messagesDocument(messageID: messageID).getDocument()
        return try? snapshot.data(as: MessageInfo.self)

        
    }
    
    //  Fetches the specific user to text (and accounts for which of those is logged in)
    func getUserToText(messagesID: String, loggedInUser: user) async throws -> user? {
        
        let messageInfoSnapshot = try await messagesDocument(messageID: messagesID).getDocument()
        
        //  First fetches the gift sender
        guard let userToTextID = messageInfoSnapshot.data()?[MessageInfo.CodingKeys.giftSender.rawValue] as? String else { return nil }
        
        //  Checks to see if person logged in is the SAME as the gift sender,
        if userToTextID != loggedInUser.email {
            
            let userToText = try await UserManager.shared.getUser(userEmail: userToTextID)
            return userToText

        }
        
        //  If this is the same person, it instead returns the other person 
        else {
            guard let userToTextID = messageInfoSnapshot.data()?[MessageInfo.CodingKeys.giftReceiver.rawValue] as? String else { return nil }
            let userToText = try await UserManager.shared.getUser(userEmail: userToTextID)
            return userToText

        }
}
    
    
    //  Function that returns all of the users in the messages (this should run when the application first runs)
    func getAllUsersToText(messagesID: [String], loggedInUser: user) async throws -> [user] {
        
        var users: [user] = []
        
        //  Iterates through all of the IDs in the user's array
        for id in messagesID {
            
            let user = try await getUserToText(messagesID: id, loggedInUser: loggedInUser)
            
            if let u = user {
                users.append(u)
            }
        }
        return users
        
    }

    //  This has the info of all types of
    func getAllMessageInfo(loggedInUser: user) async throws -> [MessageInfo] {
        
        var messageInfo : [MessageInfo] = []
        
        let messagesID = loggedInUser.messages
        
        for id in messagesID {
            
            if let m = try await getMessageMainDocument(messageID: id) {
                messageInfo.append(m)

            }
        }
        
        return messageInfo
        
    }
}

