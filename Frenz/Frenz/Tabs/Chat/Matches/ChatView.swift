//
//  ChatView.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 10/15/24.
//

import SwiftUI

struct ChatView: View {
    
    @State var index = 0
   
    @EnvironmentObject var profileVM : ProfileViewModel
    @EnvironmentObject var allUsers : AllOfUsers
    @StateObject var mapViewModel = MapViewModel()


    var body: some View {
        
        NavigationStack {
            ZStack {
                
                Color.black.edgesIgnoringSafeArea(.all)
                
                
                VStack {
                    SlidingTabView(index: $index, keepHeader: true, mapViewModel: mapViewModel)
                    
                    Spacer()
                    
                    //  Fetch all of the users in the giftsReceieved array and filter based on romantic vs. friends
                    TabView (selection: self.$index) {
                        
                        //  Admirers
                        if let purpose = profileVM.user?.appUtilizationPurpose {
                            
                            if purpose == .friendsAndRomantic || purpose == .romantic {
                               
                                MatchesView(users: allUsers.romanticGiftUsers, index: $index, giftSendingPurposeToShow: .romantic)
                                    .tag(0)
            
                                
                            } else {
                                
                                InaccessibleView(doNotShowAdmirers: true)
                                    .tag(purpose == .friends ? 1 : 0)
                                    .onAppear {
                                        mapViewModel.showFriendsFirst = true
                                    }
                        
                            }
                            
                            if purpose == .friendsAndRomantic || purpose == .friends {
                                
                                MatchesView(users: allUsers.friendGiftUsers, index: $index, giftSendingPurposeToShow: .friends)
                                    .tag(purpose == .friends ? 0 : 1)
                                    .onAppear {
                                        if purpose == .friends {
                                            mapViewModel.showFriendsFirst = true
                                        }
                                        
                                    }
                                
                            } else {
                                
                                InaccessibleView(doNotShowAdmirers: false)
                                    .tag(1)
                                
                            }
                        }
                        
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                }
                
                
            }
        }
        .onAppear {
            
        }
        
    }
}

#Preview {
    ChatView()
}
