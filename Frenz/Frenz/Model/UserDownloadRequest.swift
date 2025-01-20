//
//  UserDownloadRequest.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 11/21/24.
//

import Foundation

struct UserDownloadRequest: Codable {
        
    //
    var emailBeingSentTo: String
    var requestUserEmail: [String]
    var userIsAlreadyInApp: Bool
    var emailHasBeenSent: Bool
    
    init(
        emailBeingSentTo: String,
        requestUserEmail: [String],
        userIsAlreadyInApp: Bool,
        emailHasBeenSent: Bool
    ) {
        self.emailBeingSentTo = emailBeingSentTo
        self.requestUserEmail = requestUserEmail
        self.userIsAlreadyInApp = userIsAlreadyInApp
        self.emailHasBeenSent = emailHasBeenSent
    }
    
    enum CodingKeys: String, CodingKey {
        
        case emailBeingSentTo = "email_being_sent_to"
        case requestUserEmail = "request_user_email"
        case userIsAlreadyInApp = "user_is_already_in_app"
        case emailHasBeenSent = "email_has_already_been_sent"
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.emailBeingSentTo = try container.decode(String.self, forKey: .emailBeingSentTo)
        self.requestUserEmail = try container.decode([String].self, forKey: .requestUserEmail)
        self.userIsAlreadyInApp = try container.decode(Bool.self, forKey: .userIsAlreadyInApp)
        self.emailHasBeenSent = try container.decode(Bool.self, forKey: .emailHasBeenSent)
        
    }
    
    func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.emailBeingSentTo, forKey: .emailBeingSentTo)
        try container.encode(self.requestUserEmail, forKey: .requestUserEmail)
        try container.encode(self.userIsAlreadyInApp, forKey: .userIsAlreadyInApp)
        try container.encode(self.emailHasBeenSent, forKey: .emailHasBeenSent)
    }
}
