//
//  GiftsOptionsView.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 10/14/24.
//

import SwiftUI

struct GiftsOptionsView: View {
    
    @ObservedObject var cardViewModel : CardViewModel
    @EnvironmentObject var profileVM : ProfileViewModel
    var showAdmirersGifts: Bool
    var user: user
    
    var romanticLabels = ["heart", "chocolate", "rose", "teddy bear", "wine", "cake", "coffee", "letter", "dinner", "plant", "cool", "cookie", "bulldog", "pizza", "peace", "hat"]

//    var friendsLabels = ["dinner", "plant", "cool", "cookie", "bulldog", "pizza", "peace", "hat"]
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Select a gift for \(user.firstName):")
                    .font(.custom("Minecraft", size: 17))
                    .padding(.bottom, 15)
                    .foregroundStyle(.white)
                
                VStack(spacing: 10) {
                    
                    HStack {
                                                
                        
                        ForEach(Array(zip(
                            showAdmirersGifts == true ? GiftType.allCases[0..<4].indices : GiftType.allCases[8..<12].indices,
                            showAdmirersGifts == true ? GiftType.allCases[0..<4] : GiftType.allCases[8..<12])),
                                id: \.1) { index, gift in
                            giftIcon(giftLabel: romanticLabels[index], giftType: gift, cardViewModel: cardViewModel)
                        }

                    }
                    
                    HStack {
                                                
                        
                        ForEach(Array(zip(
                            showAdmirersGifts == true ? GiftType.allCases[4..<8].indices : GiftType.allCases[12..<16].indices,
                            showAdmirersGifts == true ? GiftType.allCases[4..<8] : GiftType.allCases[12..<16])),
                                id: \.1) { index, gift in
                            giftIcon(giftLabel: romanticLabels[index], giftType: gift, cardViewModel: cardViewModel)
                        }

                    }
                    

                }
            }
            
            .disabled(cardViewModel.showGiftGivingConfirmationScreen)
            .blur(radius: cardViewModel.showGiftGivingConfirmationScreen ? 20 : 0)
            
            if cardViewModel.showGiftGivingConfirmationScreen == true {
                
                if let loggedInUser = profileVM.user {
                    
                    //  if the user has already given them a gift
                    if let giftSent = loggedInUser.giftsReceived.first(where: { gift in
                        gift.giftAction == .sent && gift.otherUser == user.email && gift.giftSentPurpose == cardViewModel.giftSentPurposeOfGiftUserIntendsToSend
                    }) {
                        
                        //  Show final confirmation
                        if cardViewModel.showGiftHasBeenSuccessfullySentView {
                            GiftSentConfirmationView(cardViewModel: cardViewModel)
                        //  Show warning
                        } else {
                            YouCannotSendGiftTwiceView(cardViewModel: cardViewModel, user: user, showAdmirerGift: showAdmirersGifts)
                        }
                      
                        //  If the other use has already sent you the same type of gift... 
                    } else if let giftSent = loggedInUser.giftsReceived.first(where: { gift in
                        gift.giftAction == .received && gift.otherUser == user.email && gift.giftSentPurpose == cardViewModel.giftSentPurposeOfGiftUserIntendsToSend
                    }) {
                        ThisUserAlreadySentYouGiftView(cardViewModel: cardViewModel, showAdmirerGift: showAdmirersGifts)
                    } else {
                        //  If the user has NOT given them a gift before, show them this screen:
                        AreYouSureYouWantToSendGiftView(user: user, cardViewModel: cardViewModel)
                    }
                }
            }
        }.onAppear {
            if !showAdmirersGifts {
                cardViewModel.giftSentPurposeOfGiftUserIntendsToSend = .friends
            }
        }
        
    }
}


struct giftIcon: View {
    
    var giftLabel: String
    var giftType: GiftType
    @ObservedObject var cardViewModel : CardViewModel
    
    var body: some View {
        
        ZStack {
            VStack {
                
                Image(giftType.rawValue)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60, height: 60)
                
                Text(giftLabel)
                    .font(.custom("Minecraft", size: 15))
                    .foregroundStyle(.white)
                
            }
            .frame(width: 80)
            .onTapGesture {
                cardViewModel.selectedGift = giftType
                cardViewModel.showGiftGivingConfirmationScreen = true

                //  What index are we in ?
            }
        }
    }
}

#Preview {
    GiftsOptionsView(cardViewModel: CardViewModel(), showAdmirersGifts: true, user: MockUser.fakeUser)
}
