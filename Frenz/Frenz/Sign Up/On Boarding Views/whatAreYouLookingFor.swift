//
//  whatAreYouLookingFor.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 10/17/24.
//

import SwiftUI

struct whatAreYouLookingFor: View {
    
    var updatingProfile: Bool
    var userEmail: String?
    
    @Binding var signUpPageIndex: Int
    @ObservedObject var signUpVM : SignUpViewModel

    @State var successfulUpdate = false
    
    var body: some View {
        
        ZStack {
            
            Color.black.edgesIgnoringSafeArea(.all)
            
            if !updatingProfile {
                BackArrowButton(numOfPagesToGoBack: 1, signUpPageIndex: $signUpPageIndex, topPadding: 30, leadingPadding: 15)
            }
            
            
            VStack {
                
                Text("Right now I'm looking for...")
                    .font(.custom("Minecraft", size: 20))
                    .foregroundStyle(.white)
                    .padding(.bottom, 40)
                
                VStack (spacing: 10) {
                    ForEach(LookingFor.allCases, id: \.self) { reason in
                        
                        WhiteBoxButton(buttonText: reason.rawValue, isSelected: signUpVM.appUser.lookingFor == reason, buttonWidth: UIScreen.main.bounds.width, buttonHeight: 70) {
                            
                            signUpVM.appUser.lookingFor = reason
                        }
                        .padding(.bottom, 5)
                        
                    }
                }.padding(.bottom, 30)
                
                
                NextButtonBottom (action: {
                    
                    if updatingProfile {
                        
                        Task {
                            
                            guard let email = userEmail, let lookingFor = signUpVM.appUser.lookingFor?.rawValue else {
                                return
                            }
                            
                            try await UserManager.shared.updateUserField(userEmail: email, lookingFor, codingKeyRawValue: user.CodingKeys.lookingFor.rawValue)
                            
                            successfulUpdate = true
                        }
                        
                    }
                    else {
                        withAnimation(.spring()) {
                            
                            signUpPageIndex += 1
                        }
                    }
                }, disabled: signUpVM.appUser.lookingFor == nil, updatingProfile: updatingProfile)
                
                
                Text("Your profile has been successfully updated!")
                    .foregroundStyle(successfulUpdate ? .red : .clear)
                    .font(.custom("Minecraft", size: 20))
                    .padding(.top, 20)
                
            }
            
            
        }
    }
}

#Preview {
    whatAreYouLookingFor(updatingProfile: false, signUpPageIndex: .constant(1), signUpVM: SignUpViewModel())
}
