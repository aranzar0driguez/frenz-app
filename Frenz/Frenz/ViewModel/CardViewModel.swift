//
//  CardViewModel.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 10/15/24.
//

import Foundation

@MainActor
final class CardViewModel: ObservableObject {
    
    @Published var showGiftOptions = false
    @Published var selectedUser : user?
    
    //  Selected gift
    @Published var selectedGift: GiftType?
    @Published var showGiftGivingConfirmationScreen: Bool = false 
    @Published var hasApprovedtoGiveGift: Bool = false 
    @Published var showRomanticGifts: Bool = true 
    @Published var giftSentPurposeOfGiftUserIntendsToSend: GiftSentPurpose = .romantic
    @Published var showGiftHasBeenSuccessfullySentView: Bool = false 
    @Published var errorSendingGift: Bool = false 
    @Published var thisUserNoLongerExists = false 
    // Index?
}
