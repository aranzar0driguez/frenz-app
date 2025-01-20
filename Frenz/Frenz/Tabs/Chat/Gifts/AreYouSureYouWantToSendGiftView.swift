//
//  AreYouSureYouWantToSendGiftView.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 10/25/24.
//

import SwiftUI

struct AreYouSureYouWantToSendGiftView: View {
    
    var user: user
    @ObservedObject var cardViewModel : CardViewModel
    @EnvironmentObject var profileVM : ProfileViewModel
    @EnvironmentObject var allUsers : AllOfUsers
    
    var body: some View {
        
        ZStack {
            
            Color.black.edgesIgnoringSafeArea(.all)
            
            if !cardViewModel.errorSendingGift {
                
                VStack {
                    
                    Text("Are you sure you want to \nsend \(user.firstName) the gift?")
                        .multilineTextAlignment(.center)
                        .font(.custom("Minecraft", size: 20))
                        .foregroundColor(.white)
                        .padding(.bottom, 20)
                    
                    HStack {
                        Spacer()
                        
                        Button {
                            
                            cardViewModel.hasApprovedtoGiveGift = true
                            
                            Task {
                                
                                //  Shows the spinning loading wheel
                                cardViewModel.hasApprovedtoGiveGift = true
                                
                                //  Fetches the user's email and selected gift
                                guard let senderEmail = profileVM.user?.email, let selectedGift = cardViewModel.selectedGift else { return }
                                
                                //  Create the message object + updates both of the user's messaging field
                                let messageID = try await MessageManager.shared.createMessageMainDocument(giftSender: senderEmail, giftReceiver: user.email, lastMessage: "", isThisARomanticGift: true)
                                
                                //  If there was success creating message object + updating both user's messaging field
                                if messageID != "" {
                                    
                                    // Updates both user with the giftReceived array
                                    try await UserManager.shared.sendUsersGift(receiverEmail: user.email, senderEmail: senderEmail, giftType: selectedGift, giftSentPurpose: cardViewModel.showRomanticGifts == true ? .romantic : .friends, acceptedGift: false, messageID: messageID)
                                    
                                    //  profile vm model (fetch the user) to get new details about them
                                    try await profileVM.loadCurrentUser()
                                    
                                    guard let loggedInUser = profileVM.user else { return }
                                    
                                    //  Stops showing the spinning wheel
                                    cardViewModel.hasApprovedtoGiveGift = false
                                    
                                    //  Hides the confirmation
                                    cardViewModel.showGiftHasBeenSuccessfullySentView = true
                                    
                                    //  Re-fetch gift givers
                                    try await allUsers.getAllGiftsArrayUsers(userEmail: loggedInUser.email)
                                    
                                    //  TODO: SEND NOTIFICATION TO OTHER USER 
                                    print("The fcm token of the device we're supposed to target: \(user.fcmToken)")
                                    
                                    await SendNotifCloudFunction.shared.sendNotif(fcmToken: [user.fcmToken], title: "New Gift 🎁", message: "Someone just sent you a gift!")
                                    
                                } else { // If the other user no longer exists
                                    
                                    cardViewModel.hasApprovedtoGiveGift = false //stops showing the spinning wheel
                                    cardViewModel.errorSendingGift = true  //   shows the error message
                                    
                                }
                            }
                        } label : {
                            
                            AcceptButton(buttonText: "Yes", backgroundColor: cardViewModel.hasApprovedtoGiveGift ? .gray : .green, width: 80)
                        }
                        .disabled(cardViewModel.hasApprovedtoGiveGift == true)
                        
                        Spacer()
                        
                        Button {
                            
                            cardViewModel.showGiftGivingConfirmationScreen = false
                            
                        } label : {
                            AcceptButton(buttonText: "No", backgroundColor: cardViewModel.hasApprovedtoGiveGift ? .gray : .red, width: 80)
                            
                        }
                        .disabled(cardViewModel.hasApprovedtoGiveGift == true)
                        
                        Spacer()
                    }
                }
            } else if cardViewModel.errorSendingGift {
                
                ThereHasBeenAnErrorView(cardViewModel: cardViewModel)
            }
            
            
            if cardViewModel.hasApprovedtoGiveGift == true {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(2)
                    .frame(maxWidth: .infinity)
                    .frame(alignment: .center)
            }
            
            
        }
    }
}

#Preview {
    AreYouSureYouWantToSendGiftView(user: MockUser.fakeUser, cardViewModel: CardViewModel())
}
