//
//  Message.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 10/28/24.
//

import Foundation

struct Message: Identifiable, Codable, Hashable {
    var id = UUID()
    var text: String
    var timeStamp: Date
    var sender: String
    var receiver: String
    
    init(
        text: String,
        timeStamp: Date,
        sender: String,
        receiver: String
    ) {
        self.text = text
        self.timeStamp = timeStamp
        self.sender = sender
        self.receiver = receiver
    }
    
    enum CodingKeys: String, CodingKey {
        
        case id = "message_id"
        case text = "text"
        case timeStamp = "time_stamp"
        case sender = "other_user"
        case receiver = "receiver"
        
    }
    
    init (from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try container.decode(UUID.self, forKey: .id)
        self.text = try container.decode(String.self, forKey: .text)
        self.timeStamp = try container.decode(Date.self, forKey: .timeStamp)
        self.sender = try container.decode(String.self, forKey: .sender)
        self.receiver = try container.decode(String.self, forKey: .receiver)

    }
    
    func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.text, forKey: .text)
        try container.encode(self.timeStamp, forKey: .timeStamp)
        try container.encode(self.sender, forKey: .sender)
        try container.encode(self.receiver, forKey: .receiver)


    }
    
}
