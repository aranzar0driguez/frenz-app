//
//  SignUpP6View.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 10/16/24.
//

import SwiftUI

struct SignUpP6View: View {
   
    var updatingProfile: Bool
    var userEmail: String?
    
    
    @Binding var signUpPageIndex: Int
    @ObservedObject var signUpVM : SignUpViewModel
    
    @State var successfulUpdate = false


    var body: some View {
        
       
        GeometryReader { _ in
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                
                if !updatingProfile {
                    BackArrowButton(numOfPagesToGoBack: signUpVM.appUser.appUtilizationPurpose == .friends ? 4 : 1, signUpPageIndex: $signUpPageIndex, topPadding: 30, leadingPadding: 15)
                }
                
                
                VStack  {
                    HStack {
                        Text("Write a bio for your future friends:")
                            .foregroundStyle(.white)
                            .font(.custom("Minecraft", size: 20))
                            .padding(.bottom, 30)
                        
                        Spacer()
                        
                    }
                    
                    
                    LongTextEditor(textHeader: "Bio:", fieldText: $signUpVM.appUser.friendBio, emptyFieldHolder: "Tell them something cool...")
                        .padding(.bottom, 40)
                    
                    
                    Button {
                        
                        if updatingProfile {
                            
                            Task {
                                
                                guard let email = userEmail else {
                                    return
                                }
                                
                                try await UserManager.shared.updateUserField(userEmail: email, signUpVM.appUser.friendBio, codingKeyRawValue: user.CodingKeys.friendBio.rawValue)
                                
                                successfulUpdate = true
                                
                            }
                            
                        }
                        
                        withAnimation(.spring()) {
                            
                            signUpPageIndex += 1
                            
                        }
                    } label : {
                        HStack {
                            
                            Spacer()
                            
                            NextButton(buttonText: updatingProfile ? "Update" : "Next", textColor: .black, buttonColor: .white, buttonWidth: UIScreen.main.bounds.width - 15, buttonHeight: 45, isDisabled: signUpVM.appUser.friendBio.isEmpty)
                            
                            Spacer()
                            
                        }
                    }
                    
                    
                    if (updatingProfile) {
                        
                        Text("Your profile has been successfully updated!")
                            .font(.custom("Minecraft", size: 23))
                            .foregroundStyle(successfulUpdate ? .red : .clear)
                            .padding(.top, 20)
                    }
                    
                    
                }
                .frame(width: UIScreen.main.bounds.width - 15)
                .padding(.bottom, UIScreen.main.bounds.height/3.5)
                
                
            }
        }
        .ignoresSafeArea(.keyboard, edges: .all)

    }
}

#Preview {
    SignUpP6View(updatingProfile: false, signUpPageIndex: .constant(1), signUpVM: SignUpViewModel())
}
