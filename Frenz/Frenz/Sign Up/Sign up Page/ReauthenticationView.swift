//
//  ReauthenticationView.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 12/5/24.
//

import SwiftUI
import GoogleSignInSwift

struct ReauthenticationView: View {
    
    @AppStorage("signed_in") var currentUserSignedIn: Bool? //  Shows the user the final view
    @StateObject private var authenticationVM = AuthenticationViewModel()   //  Keeps track of authenticating the user
    @State var isLoadingButton = false  //  Disables button when the user presses it
    @EnvironmentObject var pViewModel : ProfileViewModel
    @EnvironmentObject var allUsers : AllOfUsers
    
    @State var userEmailBeforeVerification: String //   Keep track of the user who is trying to delete their email
    
    @State var successfulDeletion = false  //   Indicates that the user has successfully deleted their account
    @State var issueDeletingAccount = false
    
    var body: some View {
        
        ZStack {
            
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Please sign-in with the email you used to create your account")
                    .foregroundStyle(.white)
                    .font(.custom("Minecraft", size: 20))
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 20)
                
                Text("Loading...")
                    .foregroundStyle(isLoadingButton ? .white : .clear)
                    .font(.custom("Minecraft", size: 12))
                    .padding(.bottom, 30)
                
                
                GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(scheme: .dark, style: .icon, state: .normal)) {
                    
                    isLoadingButton = true
                    issueDeletingAccount = false

                    Task {
                        
                        
                        do {
                            
                            let credential = try await authenticationVM.signInGoogle()
                            
                            //  Fetches the current user
                            try await pViewModel.loadCurrentUser()

                            //  Fetches the current user's (after logging in) email
                            let userEmailAfterVerification = pViewModel.user?.email

                           
                            //  If that email matches currently logged in user
                            if userEmailBeforeVerification == userEmailAfterVerification {
                               
                                //  Reduces the user's count first
                                try await QuantityManager.shared.adjustUserCount(addUser: false)

                                
                                //  Refreshes the admirers/friends array in case anyone deleted their profile
                                try await allUsers.getAllGiftsArrayUsers(userEmail: userEmailAfterVerification!)
                                
                                //  Deltes the user's account
                                try await pViewModel.deleteUser(authCredential: credential, userEmail: userEmailAfterVerification!, friendsGiftArray: allUsers.friendGiftUsers, admirersGiftArray: allUsers.romanticGiftUsers)
                                
                                isLoadingButton = false
                                successfulDeletion = true
                                                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                    
                                    currentUserSignedIn = false
                                }


                            } else {
                                
                                //  please ensure you are logging in with the same account that you logged into
                                issueDeletingAccount = true


                            }
                            
                            isLoadingButton = false
                            
                        } catch  {
                            issueDeletingAccount = true
                            isLoadingButton = false
                            print("Please ensure you're logging in with the same email you created this account with")
                        }
                    }
                }
                .disabled(isLoadingButton)
                .clipShape(Circle())

                
                Text("Please ensure you're logging in with the same email created this account with.")
                    .foregroundStyle(issueDeletingAccount ? .red : .clear)
                    .multilineTextAlignment(.center)
                    .font(.custom("Minecraft", size: 12))
                    .padding(.top, 10)
               

                
                Text("This account has been successfully deleted.")
                    .foregroundStyle(successfulDeletion ? .white : .clear)
                    .font(.custom("Minecraft", size: 12))
            }
        }

        
    }
}

