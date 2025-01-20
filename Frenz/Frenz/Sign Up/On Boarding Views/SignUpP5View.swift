//
//  SignUpP5View.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 10/16/24.
//

import SwiftUI
import Combine

struct SignUpP5View: View {
    
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
                    
                    BackArrowButton(numOfPagesToGoBack: 1, signUpPageIndex: $signUpPageIndex, topPadding: 30, leadingPadding: 15)
                    
                }
                
                VStack  {
                    HStack {
                        Text("Write a bio admirers will see:")
                            .foregroundStyle(.white)
                            .font(.custom("Minecraft", size: 25))
                            .padding(.bottom, 30)
                        
                        Spacer()
                    }
                    
                    
                    LongTextEditor(textHeader: "Bio:", fieldText: $signUpVM.appUser.admirerBio, emptyFieldHolder: "Make them fall in love...")
                        .padding(.bottom, 40)
                    
                    Button {
                        
                        if updatingProfile {
                            
                            Task {
                                guard let email = userEmail else {
                                    return
                                }
                                
                                try await UserManager.shared.updateUserField(userEmail: email, signUpVM.appUser.admirerBio, codingKeyRawValue: user.CodingKeys.admirerBio.rawValue)
                                
                                successfulUpdate = true
                            }
                            
                        }
                        
                        else {
                            withAnimation(.spring()) {
                                signUpPageIndex += 1
                                
                            }
                        }
                    } label : {
                        HStack {
                            
                            Spacer()
                            
                            NextButton(buttonText: updatingProfile ? "Update" : "Next", textColor: .black, buttonColor: .white, buttonWidth: UIScreen.main.bounds.width - 15, buttonHeight: 45, isDisabled: signUpVM.appUser.admirerBio.isEmpty)
                            
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
                .padding(.bottom, UIScreen.main.bounds.height / 3.7)
               
                
            }
        }
        .ignoresSafeArea(.keyboard, edges: .all)

//            .navigationBarBackButtonHidden()
//            .toolbar {
//                ToolbarItem (placement: .topBarLeading) {
//                    Button {
//                        presentationMode.callAsFunction()
//                        
//                    } label: {
//                        Text("< Back")
//                            
//                            .foregroundStyle(.white)
//                            .font(.custom("Minecraft", size: 17))
//                    }
//                }
//            }
        
    }
}

#Preview {
    SignUpP5View(updatingProfile: false, signUpPageIndex: .constant(1), signUpVM: SignUpViewModel())
}
