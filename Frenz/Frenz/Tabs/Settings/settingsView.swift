//
//  settingsView.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 10/31/24.
//

import SwiftUI

struct settingsView: View {
    
    var user: user
    @AppStorage("signed_in") var currentUserSignedIn: Bool?
    @State var showAlert = false
    @State var showReauthenticationView = false
    
    var body: some View {
        
        NavigationStack {
            
            ZStack {
                
                Color.black.edgesIgnoringSafeArea(.all)
                
                VStack {
                    //  Profile Picture
//                    
                    SettingsHeaderView(user: user, imagesURL: user.imagesURL[0], updatingProfile: false)
                    
                    
                    Form {
                        Section(header:
                                    Text("Profile Settings")
                            .font(.custom("Minecraft", size: 12))
                            .foregroundStyle(.white)
                        ) {
                            NavigationLink {
                                UpdateProfileView(user: user)
                            } label: {
                                Label("Update Profile", systemImage: "pencil")
                                    .foregroundStyle(.white)
                                    .font(.custom("Minecraft", size: 16))
                            }
                            
                            NavigationLink {
                                CardView(showAdmirersGifts: false, showGiftSendingOptions: false, user: user, updateCardView: false)
                            } label: {
                                Label("View Current Profile", systemImage: "eye")
                                    .foregroundStyle(.white)
                                    .font(.custom("Minecraft", size: 16))
                            }
                        }
                        
                        Section(header:
                                    Text("Account Settings")
                            .foregroundStyle(.white)
                            .font(.custom("Minecraft", size: 12))
                        ) {
                            // Remove the Group and use Button instead for logout
                            Button {
                                
                                try? AuthenticationManager.shared.signOut()
                                print("successfully logged out")
                                currentUserSignedIn = false
                                
                            } label: {
                                Label("Log out", systemImage: "lock")
                                    .foregroundStyle(.white)
                                    .font(.custom("Minecraft", size: 16))
                            }
                            
                            Button(role: .destructive) {
                                showAlert = true
                                
                                //  Make sure to reduce quantity by one !!
                            } label: {
                                Label("Delete account", systemImage: "trash")
                                    .foregroundStyle(.red)
                                    .font(.custom("Minecraft", size: 16))
                                
                            }
                            .alert("This action is PERMANENT and will delete your data. You will need to sign in AGAIN to proceed with deletion.", isPresented: $showAlert) {
                                
                                Button("Continue", role: .destructive) {
                                   showReauthenticationView = true
                                }
                            }
                            
                     
                        }
                        
                        Section(header:
                                    Text("About Frenz")
                            .font(.custom("Minecraft", size: 12))
                            .foregroundStyle(.white)
                        ) {
                            NavigationLink {
                                
                                faqAnswered()
                                
                            } label: {
                                Label("FAQ", systemImage: "lock")
                                    .foregroundStyle(.white)
                                    .font(.custom("Minecraft", size: 16))
                            }
                        }
                    }
                    .environment(\.colorScheme, .dark)
                    
                    
                    Spacer()
                    
                }
            }
        }
        .fullScreenCover(isPresented: $showReauthenticationView, content: {
            ReauthenticationView(userEmailBeforeVerification: user.email)
        })
    }
}

#Preview {
    settingsView(user: MockUser.fakeUser)
}
