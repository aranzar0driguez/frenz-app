//
//  UserNotFoundRequestFormView.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 11/21/24.
//

import SwiftUI

struct UserNotFoundRequestFormView: View {
    
    @EnvironmentObject var profileVM : ProfileViewModel
    @State var email: String = ""
    @State var successfulEmailSent = false
    @State var isLoading = false
    
    var body: some View {
        
        GeometryReader { _ in
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                
                VStack {
                    // Add smaller spacer at top to push content up
                    Spacer().frame(height: UIScreen.main.bounds.height * 0.13)
                    
                    VStack {
                        Text("Wish someone specific was on this app? Type their email and we'll send them an email {they won't know it was you}.")
                            .font(.custom("Minecraft", size: 18))
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding([.leading, .trailing], 15)
                        
                        
                        Image("heart")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 60, height: 60)
                            .frame(maxHeight: 80) // Fixed height container for the image
                    }
                    .frame(height: 140)
                    
                    CustomTextEditorView(text: $email,
                                         header: "Type an @yale.edu email...",
                                         bottomPadding: -25,
                                         width: (UIScreen.main.bounds.width - 30))
                    
                    Button {
                        
                        isLoading = true
                        
                        guard let loggedInUserEmail = profileVM.user?.email else { return }
                        
                        let request = UserDownloadRequest(emailBeingSentTo: email.lowercased(), requestUserEmail: [loggedInUserEmail], userIsAlreadyInApp: false, emailHasBeenSent: false)
                        
                        Task {
                            try await UserDownloadRequestManager.shared.createNewRequest(request: request)
                        }
                        
                        isLoading = false
                        
                        successfulEmailSent = true
                        // Send email
                    } label: {
                        
                        ZStack {
                            
                            NextButton(buttonText: "Send Email !",
                                       textColor: .black,
                                       buttonColor: .white,
                                       buttonWidth: 180,
                                       buttonHeight: 45,
                                       isDisabled: !email.contains("yale.edu") || isLoading)
                            .padding(.bottom, 20)
                            
                            if isLoading {
                                
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                    .scaleEffect(2)
                                    .frame(maxWidth: .infinity)
                                    .frame(alignment: .center)
                            }
                        }
                    }
                    
                    Text("Email has been successfully sent!")
                        .foregroundStyle(successfulEmailSent ? .white : .clear)
                        .font(.custom("Minecraft", size: 18))
                    
                    // Add larger spacer at bottom
                    Spacer().frame(height: UIScreen.main.bounds.height * 0.35)
                }
            }
        }.ignoresSafeArea(.keyboard, edges: .all)
    }

}

#Preview {
    UserNotFoundRequestFormView()
}
