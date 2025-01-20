//
//  MessagesViewModel.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 10/28/24.
//

import Foundation
import FirebaseFirestore

final class MessagesViewModel: ObservableObject {
    
    @Published private(set) var messages: [Message] = []
    @Published private(set) var latestMessage: String = ""
    
    private let messagesDocumentID: String
    private var signedInUserEmail: String = ""
    
    init(messagesDocumentID: String) {
        self.messagesDocumentID = messagesDocumentID
        getMessages()
    }
    
    //  Initialized to retrieve latest message 
    init(messagesDocumentID: String, signedInUser: String) {
        self.messagesDocumentID = messagesDocumentID
        self.signedInUserEmail = signedInUser
        getLatestMessage()
    }
    
    //  Fetches the collection of documents in firebase for a specific message
    
    let db = Firestore.firestore().collection("messages")
    
    func getMessages() {
        db.document(messagesDocumentID).collection("msglist").addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("error fetching documents \(String(describing: error))")
                return
            }
            
            //  Always need to use self when you're referencing a variable in yoru class
            self.messages = documents.compactMap { document -> Message? in
                do {
                    return try document.data(as: Message.self)
                } catch {
                    print("Error decoding documents into Message: \(error)")
                    return nil
                }
            }
            self.messages.sort { $0.timeStamp < $1.timeStamp }
           

        }
    }
    
    func getLatestMessage() {
        db.document(messagesDocumentID).addSnapshotListener { querySnapshot, error in
            
            guard let document = querySnapshot, document.exists else {
                print("error fetching document \(String(describing: error))")
                return
            }
            
            do {
                let doc = try document.data(as: MessageInfo.self)
                let latestMessage = doc.lastMessage
                self.latestMessage = latestMessage
                print("latest message: \(self.latestMessage)")
            } catch {
                print("error decoding document into message info object \(error)")
            }
            
        }
    }
    
}
