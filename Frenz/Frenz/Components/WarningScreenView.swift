//
//  WarningScreenView.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 12/5/24.
//

import SwiftUI

struct WarningScreenView: View {
    
    var message: String
    @EnvironmentObject var profileVM : ProfileViewModel
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                
                Color.black.edgesIgnoringSafeArea(.all)
                
                
                VStack {
                    
                    if let user = profileVM.user {
                        
                        SettingsHeaderView(user: user, imagesURL: user.imagesURL[0], updatingProfile: false)
                        
                        
                        Form {
                            Section(header: Text("Profile Settings")
                                .font(.custom("Minecraft", size: 12))
                                .foregroundStyle(.white)
                                    
                            ) {
                                NavigationLink {
                                    CardView(showAdmirersGifts: false, showGiftSendingOptions: false, user: user, updateCardView: false)
                                } label: {
                                    Label("View Profile", systemImage: "eye")
                                        .foregroundStyle(.white)
                                        .font(.custom("Minecraft", size: 16))
                                }
                                
                                NavigationLink {
                                    UpdateProfileView(user: user)
                                } label: {
                                    Label("Update Profile", systemImage: "pencil")
                                        .foregroundStyle(.white)
                                        .font(.custom("Minecraft", size: 16))
                                }
                                
                                NavigationLink {
                                    UserNotFoundRequestFormView()
                                } label: {
                                    Label("User Request", systemImage: "person.fill")
                                        .foregroundStyle(.white)
                                        .font(.custom("Minecraft", size: 16))
                                }
                            }
                            
                           
                           
                        }
                        .environment(\.colorScheme, .dark)
                        .frame(maxHeight: 200)
                    }
                        
                        // TODO: test this out
                        Text(message)
                            .foregroundStyle(.white)
                            .font(.custom("Minecraft", size: 20))
                            .lineSpacing(4)
                            .multilineTextAlignment(.center)
                            .padding([.leading, .trailing], 15)
                            .frame(width: UIScreen.main.bounds.width - 20, height: 220)
                            .minimumScaleFactor(0.5)
                            .overlay(RoundedRectangle(cornerRadius: 20).stroke(.white, lineWidth: 3))
                        
                        Spacer()
                        
                    
                }
                .padding(.top, 30)
                
            }
        }
    }
}

#Preview {
    WarningScreenView(message: "Thank you for signing up! In the meantime, feel free to view and edit your profile.\n\nMatches will be released Dec 15th!")
}
