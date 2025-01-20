//
//  MapLocationView.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 11/19/24.
//

import SwiftUI
import MapKit

struct MapLocationView: View {
    
    @EnvironmentObject var allUsers : AllOfUsers
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @AppStorage("signed_in") var currentUserSignedIn: Bool?

    var updatingProfile: Bool
    var userEmail: String?
    
    @Binding var signUpPageIndex: Int
    @ObservedObject var signUpVM : SignUpViewModel

    @State var successfulUpdate = false
    @State var isLoading = false
    
    
    var body: some View {
        ZStack {
            
            
            DNDMapLayoutView(centerCoordinate: $centerCoordinate)
                .ignoresSafeArea(.all)
                .environment(\.colorScheme, .light)
                .disabled(isLoading)
            

            Text("📍")
                .font(.system(size: 40))
                .padding(.bottom, 100)
            
           
            VStack {
                
                
                if !updatingProfile {
                    BackArrowButton(numOfPagesToGoBack: 1, signUpPageIndex: $signUpPageIndex, topPadding: 30, leadingPadding: 15, color: .black)
                        .disabled(isLoading)
                }

                Spacer()
                
                ZStack {

                        Rectangle()
                        .fill(Color.black)
                        .frame(width: UIScreen.main.bounds.width - 40, height: 160, alignment: .center)
                        .clipShape(RoundedRectangle(cornerRadius: 30))
                    
                    VStack {
                        
                        if (!successfulUpdate) {
                            Text(isLoading ? "Please wait while we upload your profile, this may take a minute." : "Last step! Move the map around to select where you'd like your profile to appear on the map.")
                                .padding([.leading, .trailing], 15)
                                .font(.custom("Minecraft", size: 17))
                                .foregroundStyle(.white)
                                .multilineTextAlignment(.center)
                                .padding(.bottom, 15)
                        } else {
                            Text("You have successfully updated your profile!")
                                .padding([.leading, .trailing], 15)
                                .font(.custom("Minecraft", size: 20))
                                .foregroundStyle(.white)
                                .multilineTextAlignment(.center)
                                .padding(.bottom, 15)
                        }
                        
                        
                        Button {
                            signUpVM.appUser.latitude = centerCoordinate.latitude
                            signUpVM.appUser.longitude = centerCoordinate.longitude
                            
                
                            if updatingProfile {
                                
                                Task {
                                    guard let email = userEmail else {
                                        return
                                    }
                                    
                                    //  Update latitude
                                    try await UserManager.shared.updateUserField(userEmail: email, signUpVM.appUser.latitude, codingKeyRawValue: user.CodingKeys.latitude.rawValue)
                                    
                                    //  Update longitude
                                    try await UserManager.shared.updateUserField(userEmail: email, signUpVM.appUser.longitude, codingKeyRawValue: user.CodingKeys.longitude.rawValue)
                                 
                                    
                                    successfulUpdate = true
                                }
                                
                            }
                            
                            else {
                                Task {
                                    
                                    do {
                                        isLoading = true
                                        
                                      
                                        
                                        let friendEmailsMap = try await allUsers.getFilteredUsers(appUtilizationPurpose: .friends, usersOnMap: true, user: signUpVM.appUser)
                                        let admirersEmailsMap = try await allUsers.getFilteredUsers(appUtilizationPurpose: .romantic, usersOnMap: true, user: signUpVM.appUser)
                                        let friendEmailsCards = try await allUsers.getFilteredUsers(appUtilizationPurpose: .friends, usersOnMap: false, user: signUpVM.appUser)
                                        let admirersEmailsCards = try await allUsers.getFilteredUsers(appUtilizationPurpose: .romantic, usersOnMap: false, user: signUpVM.appUser)
                                        
                                        signUpVM.appUser.friendsMapEmails = friendEmailsMap
                                        signUpVM.appUser.friendsCardsEmails = friendEmailsCards
                                        signUpVM.appUser.admirersMapEmails = admirersEmailsMap
                                        signUpVM.appUser.admirersCardsEmails = admirersEmailsCards
                                        
                                        
                                        try await UserManager.shared.createNewUserInFirebase(u: signUpVM.appUser, userImages: signUpVM.selectedImages)
                                        
                                        await MainActor.run {
                                            withAnimation(.spring()) {
                                                currentUserSignedIn = true
                                            }
                                        }
                                    }
                                    
                                }
                            }
                            
                            
                        } label : {
                            ZStack {
                                AcceptButton(buttonText: updatingProfile ? "Update" : "Complete!", backgroundColor: isLoading ? .gray : .white, width: 140, textColor: .black)
                                
                                
                                if isLoading {
                                    
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle(tint: .black))
                                        .scaleEffect(2)
                                        .frame(maxWidth: 130, maxHeight: 30)
                                    
                                }
                            }
                        }.disabled(isLoading)
                        
                    }
                    .frame(width: UIScreen.main.bounds.width - 40, height: 140, alignment: .center)
                }
                
                Spacer()
                    .frame(height: 15)
            }
                
        }
    }
}

#Preview {
    MapLocationView(updatingProfile: true, signUpPageIndex: .constant(0), signUpVM: SignUpViewModel())
}
