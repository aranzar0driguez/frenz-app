//
//  MatchesViewModel.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 11/19/24.
//

import Foundation

class MatchesViewModel: ObservableObject {
    
    @Published var showDoYouWantToAcceptChatInvitationView = false
    @Published var selectedUser : user?
    @Published var selectedMessageID: String?
    @Published var acceptedGift : Bool?
    @Published var giftSentPurpose : GiftSentPurpose?
    @Published var gift: GiftReceived? 
    
}
