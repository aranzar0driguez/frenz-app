//
//  MapButton.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 10/24/24.
//

import SwiftUI
import FirebaseAuth

struct MapButton: View {
    
    @ObservedObject var mapViewModel : MapViewModel
    @EnvironmentObject var allUsers : AllOfUsers
    @EnvironmentObject var profileVM : ProfileViewModel
    var onMap : Bool
    
    var body: some View {
        
        Button {

            guard let currentLoggedInUser = profileVM.user else { return }
            guard let clickedOnAdmirers = mapViewModel.clickedOnAdmirers else { return }
            
            if clickedOnAdmirers {
                                
                let lastClickTime = onMap ? currentLoggedInUser.newAdmirersUsersMap : currentLoggedInUser.newAdmirersUsersCards

                if has24HoursElapsed(since: lastClickTime) {
                    
                    Task {
                        mapViewModel.isLoading = true
                        
                        
                        //  Updates last Click time
                        try await UserManager.shared.updateUserField(userEmail: currentLoggedInUser.email, Date(), codingKeyRawValue: onMap ? user.CodingKeys.newAdmirersUsersMap.rawValue : user.CodingKeys.newAdmirersUsersCards.rawValue)
                        
                        //  Fetches users + returns them
                        let emails = try await allUsers.getFilteredUsers(appUtilizationPurpose: .romantic, usersOnMap: onMap, user: currentLoggedInUser)
            
                        //  Updates the user's email field
                        try await UserManager.shared.updateUserField(userEmail: currentLoggedInUser.email, emails, codingKeyRawValue: onMap ? user.CodingKeys.admirersMapEmails.rawValue : user.CodingKeys.admirersCardsEmails.rawValue)
                        
                        //  If 24 hours have occured, update the users
                        try await profileVM.loadCurrentUser()
                        
                        mapViewModel.isLoading = false
                    }
                    
                } else {
                    mapViewModel.comeBackTime = Calendar.current.date(byAdding: .hour, value: 24, to: lastClickTime)!
                    mapViewModel.show24HourWarningScreen = true
                }
                
             
            } else {
                
                let lastClickTime = onMap ? currentLoggedInUser.newFriendUsersMap : currentLoggedInUser.newFriendsUsersCards
            
                if has24HoursElapsed(since: lastClickTime) {
                    Task {
                        
                        mapViewModel.isLoading = true
                        
                        try await UserManager.shared.updateUserField(userEmail: currentLoggedInUser.email, Date(), codingKeyRawValue: onMap ? user.CodingKeys.newFriendUsersMap.rawValue :  user.CodingKeys.newFriendsUsersCards.rawValue)
                        
                        let emails = try await allUsers.getFilteredUsers(appUtilizationPurpose: .friends, usersOnMap: onMap, user: currentLoggedInUser)
                        
                        //  Updates the user's email field
                        try await UserManager.shared.updateUserField(userEmail: currentLoggedInUser.email, emails, codingKeyRawValue: onMap ? user.CodingKeys.friendsMapEmails.rawValue : user.CodingKeys.friendsCardsEmails.rawValue)
                        
                        //  If 24 hours have occured, update the users
                        try await profileVM.loadCurrentUser()
                        
                        mapViewModel.isLoading = false 
                    }
                } else {
                    mapViewModel.comeBackTime = Calendar.current.date(byAdding: .hour, value: 24, to: lastClickTime)!
                    mapViewModel.show24HourWarningScreen = true
                }

            }
            
                                    
        } label: {
            Text("New Users")
                .foregroundStyle(.white)
                .font(.custom("Minecraft", size: 20))
                .padding()
                .background(Color.black)
                .cornerRadius(20)
                .shadow(radius: 3)
                .overlay(RoundedRectangle(cornerRadius: 20).stroke(.white, lineWidth: 2))
                .shadow(radius: 4)
        }
        .padding(.trailing, 20)
        .padding(.bottom, 30)
        
    }
}


func has24HoursElapsed(since date: Date) -> Bool {
    let now = Date()
    let elapsedTime = now.timeIntervalSince(date)
    return elapsedTime >= 24 * 60 * 60 // 24 hours in seconds
    
    //  TODO: UNDO THIS  ^^ 
}

#Preview {
    MapButton(mapViewModel: MapViewModel(), onMap: true)
}

