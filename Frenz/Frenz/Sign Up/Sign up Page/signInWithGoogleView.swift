//
//  signInWithGoogleView.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 10/18/24.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift
import FirebaseFirestore




struct signInWithGoogleView: View {
    
    @AppStorage("signed_in") var currentUserSignedIn: Bool? //  Shows the user the final view
    @StateObject private var authenticationVM = AuthenticationViewModel()   //  Keeps track of authenticating the user
    @State var isLoadingButton = false  //  Disables button when the user presses it
    @State var pleaseEnsure = false // This ensures the user only uses .edu email to log in
    
    @EnvironmentObject var universityEO: UniversityViewModel
    
    
    var firstTimeUser: Bool //  Will dictate how the sign is handled
    
    
    var body: some View {
        
        ZStack {
            
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack {
                Text(firstTimeUser ? "Please use your @yale.edu email to create your account:" : "Please sign-in using your @yale.edu email:")
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
                    pleaseEnsure = false // When the user re-clicks this button, it will be make the warning disappear

                    authenticationVM.userAlreadyExists = false
                    
                    Task {
                        
                        do {
                            
                            try await authenticationVM.signInGoogle()
                            
                            //  Holds the domain of the email
                            let domain = authenticationVM.userEmail.components(separatedBy: "@").last ?? ""
                            
                            
                            //  CHeck if that domain is in one of the universities, if it is make the domain of the ID equal within the user's viewmodel, if not, throw and error
                            
                            //  TODO: DELETE THIS LATER
                            
                            guard let university = try await UniversityManager.shared.getUniversity(universityID: "61e27926-fe8a-42fc-9beb-7e6da335da1c") else {
                                        return
                            }
                            
                            //  TODO: Make sure to remove the line above and replace it with this one!
                            //  If it makes it to this line, this means that the email was valid and verified !
//                            guard let university = try await UniversityManager.shared.findValidUniversityEmail(emailEnding: domain) else {
//                                //  Throw an error
//                                
//                                
//                                pleaseEnsure = true
//                                isLoadingButton = false
//                                
//                                return
//                            }
                            
                            //  Sets our environment object to an actual uniersity value
                            universityEO.university = university
                            authenticationVM.universityID = university.id.uuidString.lowercased()
                            
        
                            //  If they're a first time user and the user DOES NOT exist, it will show them the sign up page
                            
                            if firstTimeUser {
                                authenticationVM.showFullScreenCover = !authenticationVM.userAlreadyExists
                                
                            }
                            //  NOT A FIRST TIME USER
                            else {
                                //  USER EXISTS
                                if authenticationVM.userAlreadyExists {
                                    currentUserSignedIn = true
                                }
                            }
                            
                            isLoadingButton = false
                            
                        } catch let error as NSError {
                            if error.code == 7 {
                                
                                pleaseEnsure = true
                                isLoadingButton = false
                                
                                // Handle permission denied error
                                print("Access denied. Check your Firebase security rules.")
                                // Optionally, show an alert to the user
                            } else {
                                throw error
                            }
                        }
                    }
                }
                .disabled(isLoadingButton)
                .clipShape(Circle())
         
                Text("Please ensure that are using a valid .edu email")
                    .foregroundStyle(pleaseEnsure ? .red : .clear)
                    .font(.custom("Minecraft", size: 12))
                    .padding(.top, 10)
                
                //  Only shows this if the user already exists and they're trying to sign up
                Text("There is already an account associated with this email")
                    .foregroundStyle(authenticationVM.userAlreadyExists && firstTimeUser ? .white : .clear)
                    .font(.custom("Minecraft", size: 12))

                // When the user tries to sign in but their account doesn't exist
               Text("That account does not exist. Feel free to sign up!")
                    .foregroundStyle(!authenticationVM.userAlreadyExists && !firstTimeUser && authenticationVM.numOfTimesButtonPressed > 0 ? .white : .clear)
                    .font(.custom("Minecraft", size: 12))
            }
        }

        .fullScreenCover(isPresented: $authenticationVM.showFullScreenCover) {
            OnBoardingView(userEmail: authenticationVM.userEmail, universityID: authenticationVM.universityID)
        }
    }
}

#Preview {
    signInWithGoogleView(firstTimeUser: true)
}
