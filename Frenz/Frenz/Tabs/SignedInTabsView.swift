//
//  RootView.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 10/14/24.
//

import Foundation
import SwiftUI

struct SignedInTabsView: View {
    
    //  We need a state object that holds ALL of our current users, we can then dispaly them on our map 
    @EnvironmentObject var allUsers : AllOfUsers
    @EnvironmentObject var universityEO : UniversityViewModel
    
    @StateObject var profileVM = ProfileViewModel()
    
    @ObservedObject var warningScreenVM : WarningScreenViewModel
    @AppStorage("signed_in") var currentUserSignedIn: Bool?
    
    @State var isLoading = false
    @State var index = 0
    
    var body: some View {
        
        VStack (spacing: 0){
            
            if isLoading {
                
                HStack {
                    Text("Loading your awesome profile...")
                        .foregroundStyle(.white)
                        .font(.custom("Minecraft", size: 17))
                    
                    Image("heart")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 40)
                    
                }
               
            }
            
            else {
                
                
                //  This code is commented out because it prevents the warning message from popping up
                //  The warning message can be turned off by going onto google firestore > version > show_sub_full_screen = false
                
//                if warningScreenVM.showSubWarningScreen {
//                    WarningScreenView(message: warningScreenVM.subMessage)
//
//                } else {
                //  TODO: Make sure to uncomment this ^^
                    
                    if index == 0 {
                        multiplemaps()
                        
                    }
                    
                    else if index == 1 {
                        SlidingTabCardSelectionView()
                    }
                    
                    else if index == 2 {
                        ChatView()
                    }
                    
                    else if index == 3 {
                        lookUpView()
                    }
                    
                    else if index == 4 {
                        settingsView(user: profileVM.user ?? MockUser.fakeUser)
                    }
                    
                    bottomToolBar(index: self.$index)
//                }
            }
            
        }

        .ignoresSafeArea()
        
        .environmentObject(profileVM)
        .environmentObject(allUsers)
        
        .task {
            do {
                isLoading = true
                
                do {
                    try await profileVM.loadCurrentUser()
                    
                } catch {
                    currentUserSignedIn = false
                }
                                
                guard let loggedInUser = profileVM.user else {
                    currentUserSignedIn = false
                    return
                }
                
                
                if let token = KeychainHelper.shared.retrieve(key: "fcmToken") {
                    print("FCM TOKEN: \(token)")
                    
                    //  If the token stored in the logged in user's is different than the one from the one 
                    if loggedInUser.fcmToken != token {
                        try await UserManager.shared.updateUserField(userEmail: loggedInUser.email, token, codingKeyRawValue: user.CodingKeys.fcmToken.rawValue)
                    }
                }
                
                
              
//                try await UserManager.shared.onlyUseForReplicationPurposes()
                
                try await universityEO.loadUniversity(universityID: loggedInUser.universityID)
                
                allUsers.resetQueriedUsers()
                try await allUsers.getQueriedUsers(limit: 8)
           
                
                allUsers.resetUsersArray()
                try await allUsers.getUsersFromEmails(emails: loggedInUser.friendsMapEmails, appUtilizationPurpose: .friends, usersOnMap: true)
                try await allUsers.getUsersFromEmails(emails: loggedInUser.admirersMapEmails, appUtilizationPurpose: .romantic, usersOnMap: true)
                try await allUsers.getUsersFromEmails(emails: loggedInUser.friendsCardsEmails, appUtilizationPurpose: .friends, usersOnMap: false)
                try await allUsers.getUsersFromEmails(emails: loggedInUser.admirersCardsEmails, appUtilizationPurpose: .romantic, usersOnMap: false)
                
                try await allUsers.getAllGiftsArrayUsers(userEmail: loggedInUser.email)
                isLoading = false
                
            } catch {
                print("error loading data: \(error)")
            }
        }
        

        
    }
}

struct bottomToolBar: View {
    
    @Binding var index : Int
     
    var body: some View {
        ZStack {
            
            Rectangle()
                .fill(Color.black)
                .frame(width: UIScreen.main.bounds.width, height: 75)
                
            
            HStack {
             
                
                Button {
                    self.index = 0
                    
                } label : {
                    Image("pin")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 40)
                }
                
                Spacer()
                
                Button {
                    
                    self.index = 1
                    
                } label : {
                    Image("yellowHeart")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 38, height: 38)
                }
                
                Spacer()
                
                Button {
                    self.index = 2
                } label :{
                    Image("chat")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 32, height: 32)
                    
                }
                
                Spacer()

                
                Button {
                    self.index = 3
                } label :{
                    Image("magnifyingGlass")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 55, height: 55)
                    
                }
                
                Button {
                    self.index = 4
                } label :{
                    Image("gear")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 55, height: 55)
                    
                }
            }

            .padding([.leading, .trailing], 30)
            .padding(.bottom, 15)
        }.frame(width: UIScreen.main.bounds.width)

    }
}

#Preview {
    bottomToolBar(index: .constant(1))
}
