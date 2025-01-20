//
//  MessageInfo.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 10/28/24.
//

import Foundation

struct MessageInfo: Codable, Identifiable {
    
    var id = UUID()
    var giftSender: String
    var giftReceiver: String
    var lastMessage: String
    var isThisARomanticGift: Bool
    
    init(
        giftSender: String,
        giftReceiver: String,
        lastMessage: String,
        isThisARomanticGift: Bool
    ) {
        self.giftSender = giftSender
        self.giftReceiver = giftReceiver
        self.lastMessage = lastMessage
        self.isThisARomanticGift = isThisARomanticGift
    }
    
    enum CodingKeys: String, CodingKey {
        
        case id = "message_id"
        case giftSender = "gift_sender"
        case giftReceiver = "gift_receiver"
        case lastMessage = "last_message"
        case isThisARomanticGift = "is_this_a_romantic_gift"
        
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.giftSender = try container.decode(String.self, forKey: .giftSender)
        self.giftReceiver = try container.decode(String.self, forKey: .giftReceiver)
        self.lastMessage = try container.decode(String.self, forKey: .lastMessage)
        self.isThisARomanticGift = try container.decode(Bool.self, forKey: .isThisARomanticGift)

    }
    
    func encode(to encoder: Encoder) throws {
     
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.giftSender, forKey: .giftSender)
        try container.encode(self.giftReceiver, forKey: .giftReceiver)
        try container.encode(self.lastMessage, forKey: .lastMessage)
        try container.encode(self.isThisARomanticGift, forKey: .isThisARomanticGift)
        
    }
}
