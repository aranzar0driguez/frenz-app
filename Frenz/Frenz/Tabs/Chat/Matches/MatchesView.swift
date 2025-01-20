//
//  MatchesView.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 10/15/24.
//

import SwiftUI

struct MatchesView: View {
    
    var users: [user]
    @Binding var index: Int
    @StateObject var matchesVM = MatchesViewModel()
    var giftSendingPurposeToShow : GiftSentPurpose
    
    @EnvironmentObject var profileVM : ProfileViewModel
    @EnvironmentObject var allUsers: AllOfUsers
    @State var isFetchingNewUsers = false
    
    var body: some View {
        
        ZStack {
            
            Color.black.edgesIgnoringSafeArea(.all)
            
            ScrollView {
                
                VStack {
                    
                   
                    //  List of matches and the gift they gave around their profile picture
                    
                    ScrollView(.horizontal) {
                        HStack {
                            
                            if !users.isEmpty {
                                //
                                ForEach(users, id: \.self) { user in
                                    
                                    //`Show the gifts we have received + the one's we haven't approved
                                    
                                    if let giftOfOtherUser = user.giftsReceived.first(where: { gift in
                                        gift.giftAction == .sent && gift.otherUser == profileVM.user?.email && gift.giftSentPurpose == giftSendingPurposeToShow
                                    }) {
                                        ChatProfileView(chatUser: user, gift: giftOfOtherUser, rimColor: giftSendingPurposeToShow == .romantic ? .red : .green, bigSize: true)
                                            .onTapGesture {
                                                
                                                matchesVM.selectedUser = user
                                                matchesVM.selectedMessageID = giftOfOtherUser.messageID
                                                matchesVM.acceptedGift = giftOfOtherUser.acceptedGift
                                                matchesVM.giftSentPurpose = giftOfOtherUser.giftSentPurpose
                                                matchesVM.gift = giftOfOtherUser
                                                matchesVM.showDoYouWantToAcceptChatInvitationView = true
                                                
                                            }
                                    }
                                    
                                }
                            }
                            
                        }
                    }
                    
                    //  Active chats header
                    ActiveChatsHeaderView()
                    
                    if !users.isEmpty || isFetchingNewUsers {
                        ForEach(users, id: \.self) { user in
                            
                            if let giftOfOtherUser = user.giftsReceived.first(where: { gift in
                                gift.otherUser == profileVM.user?.email && gift.acceptedGift == true && gift.giftSentPurpose == giftSendingPurposeToShow
                            }) {
                                
                                NavigationLink(value: NavigationData(message: giftOfOtherUser.messageID, user: user)) {
                                    VStack {
                                        
                                        ChatCellView(message: giftOfOtherUser.messageID, index: $index, loggedInUser: profileVM.user ?? MockUser.fakeUser)
                                        
                                    }
                                    
                                }
                                
                                
                            }
                            
                            
                        }
                        .padding(.bottom, 30)
                        
                        HStack {
                            Label("Pull down the screen to refresh new chats & gifts", systemImage: "arrow.clockwise")
                                .foregroundStyle(.gray)
                                .opacity(0.8)
                                .font(.custom("Minecraft", size: 14))
                                                       
                        }

                    } else {
                        VStack {
                            GiftsView()
                                .padding(.bottom, 30)
                            
                            Label("Pull down the screen to refresh new chats & gifts", systemImage: "arrow.clockwise")
                                .foregroundStyle(.gray)
                                .opacity(0.8)
                                .font(.custom("Minecraft", size: 14))
                            
                        }
                    }
                    
                   
                }
                
            }
            .refreshable {
                
                Task {
                    isFetchingNewUsers = true
                    guard let loggedInUserEmail = profileVM.user?.email else {
                        return
                    }
                    
                    try await allUsers.getAllGiftsArrayUsers(userEmail: loggedInUserEmail)
                    
                    isFetchingNewUsers = false
                }

            }
            .blur(radius: matchesVM.showDoYouWantToAcceptChatInvitationView ? 6 : 0)
            .disabled(matchesVM.showDoYouWantToAcceptChatInvitationView)
            
            if matchesVM.showDoYouWantToAcceptChatInvitationView {
                
                AcceptChatConfirmationView(personToShowProfile: matchesVM.selectedUser!, loggedInUser: profileVM.user!, showDoYouWantToAcceptChatInvitationView: $matchesVM.showDoYouWantToAcceptChatInvitationView, selectedMessageID: matchesVM.selectedMessageID!, giftSentPurpose: giftSendingPurposeToShow, gift: matchesVM.gift!, acceptedGift: matchesVM.acceptedGift!)
                
            }
            
        }
        .onAppear {
            
        }
        
        .padding([.leading, .trailing], 15)
        .navigationDestination(for: NavigationData.self) { data in
            //
            DirectMessagingView(user: data.user, messagesID: data.message)
        }
    }
    
}





#Preview {
    MatchesView(users: MockUser.fakeUsers, index: .constant(1), giftSendingPurposeToShow: .friends)
}

// Create a custom type to hold multiple values
struct NavigationData: Hashable {
    let message: String
    let user: user
    
    // Implement Hashable if your types don't automatically conform
    func hash(into hasher: inout Hasher) {
        hasher.combine(user.id)
    }
}
