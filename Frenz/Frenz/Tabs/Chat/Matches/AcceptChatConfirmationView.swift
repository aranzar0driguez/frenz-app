//
//  AcceptChatConfirmationView.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 11/18/24.
//

import SwiftUI

struct AcceptChatConfirmationView: View {
    
    var personToShowProfile: user
    var loggedInUser: user
    @Binding var showDoYouWantToAcceptChatInvitationView : Bool
    var selectedMessageID: String
    var giftSentPurpose : GiftSentPurpose 
    var gift: GiftReceived
    
    @EnvironmentObject var profileVM : ProfileViewModel
    @EnvironmentObject var allUsers : AllOfUsers
    
    var acceptedGift: Bool

    var body: some View {
        
        ZStack {
            
            VStack {
                Text(!acceptedGift ? "Would you like to accept \(personToShowProfile.firstName)'s gift? This means they will be able to chat with you!" : "You have accepted to chat with \(personToShowProfile.firstName)! Feel free to stalk their profile ; )")
                    .foregroundStyle(.white)
                    .font(.custom("Minecraft", size: 18))
                    .padding([.leading, .trailing], 15)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 15)
                
                HStack {
                    
                    if acceptedGift == false {
                        
                        Button {
                            Task {
                                
                                //  Updates it in the back-end
                                try await  UserManager.shared.updateAcceptedChat(user1: personToShowProfile.email, user2: loggedInUser.email, messageID: selectedMessageID)
                                
                                
                                try await profileVM.loadCurrentUser() //    Updates the user
                                                                
                                try await allUsers.getAllGiftsArrayUsers(userEmail: loggedInUser.email) //  Updates so that this is reflected 
                                
                                //  TODO: TELL THE OTHER USER THEIR GIFT HAS BEEN ACCEPTED
                                
                                await SendNotifCloudFunction.shared.sendNotif(fcmToken: [personToShowProfile.fcmToken], title: "Gift Accepted 💛", message: "Someone just accepted your gift -- start chatting with them!")
                                
                                
                                showDoYouWantToAcceptChatInvitationView = false
                                
                            }
                        } label : {
                            AcceptButton(buttonText: "Yes", backgroundColor: .green, width: 90)
                            
                        }
                    }
                    
                    Button {
                        
                        showDoYouWantToAcceptChatInvitationView = false
                        
                    } label : {
                        AcceptButton(buttonText: !acceptedGift ? "No" : "Exit", backgroundColor: .red, width: !acceptedGift ? 90 : 150)
                    }
                    
                }
                .padding(.bottom, 10)
                
                HStack {
                    
                    NavigationLink(value: personToShowProfile) {
                        
                        AcceptButton(buttonText: "View Profile", backgroundColor: .blue, width: 150)
                        
                    }
                }
            }
            .frame(width: 300, height: 250)
            .background(.black)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay(RoundedRectangle(cornerRadius: 20)
                .stroke(.white, lineWidth: 2))
            
        }
        //  TODO: The showAdmirerGifts was given a value of false
        .navigationDestination(for: user.self) { user in
            CardView(showAdmirersGifts: false, showGiftSendingOptions: false, user: user, updateCardView: false)
        }
        
        
    }
}

//#Preview {
//    AcceptChatConfirmationView(personToShowProfile: MockUser.fakeUser, showDoYouWantToAcceptChatInvitationView: .constant(false))
//}
