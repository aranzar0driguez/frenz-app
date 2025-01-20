//
//  whatAreYouInterestedInView.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 10/17/24.
//

import SwiftUI

struct whatAreYouInterestedInView: View {
    
    var updatingProfile: Bool
    var userEmail: String?
    
    @Binding var signUpPageIndex: Int
    @ObservedObject var signUpVM : SignUpViewModel
        
    @State var successfulUpdate = false
    
    var body: some View {
        
        ZStack {
            
            Color.black.edgesIgnoringSafeArea(.all)
            
            if !updatingProfile {
                BackArrowButton(numOfPagesToGoBack: signUpVM.appUser.customField == "" ? 2 : 1, signUpPageIndex: $signUpPageIndex, topPadding: 30, leadingPadding: 15)
            }

            
            VStack {
                Text("What are you interested in?")
                    .font(.custom("Minecraft", size: 25))
                    .foregroundStyle(.white)
                    .padding(.bottom, 40)
                
                VStack (spacing: 20){
                    
                    //  If they change it, make sure to ask them to first update their sexuality, what they are looking for and bio? in order to change their "What are you looking for?
                    
                    ForEach(AppUtilizationPurpose.allCases, id: \.self) { purpose in

                        WhiteBoxButton(buttonText: purpose.rawValue, isSelected: signUpVM.appUser.appUtilizationPurpose == purpose, buttonWidth: UIScreen.main.bounds.width - 15, buttonHeight: 70) {
                            signUpVM.appUser.appUtilizationPurpose = purpose
                        }
                        .padding(.bottom, 5)
                        
                    }
                    
                }
                .padding(.bottom, 30)
                
                
                NextButtonBottom (action: {
                    
                    if updatingProfile {
                        
                        Task {
                            guard let email = userEmail, let purpose = signUpVM.appUser.appUtilizationPurpose else {
                                return
                            }
                            
                            try await  UserManager.shared.updateUserField(userEmail: email, purpose.rawValue, codingKeyRawValue: user.CodingKeys.appUtilizationPurpose.rawValue)
                            
                                successfulUpdate = true
                        }
                        
                        print("profile has been updated!")
                        
                        //  Load the new profile view? 
                    }
                    
                    else {
                        
                        withAnimation(.spring()) {
                            
                            signUpPageIndex += 1
                        }
                    }
                }, disabled: signUpVM.appUser.appUtilizationPurpose == nil, updatingProfile: updatingProfile)
                
                
                Text("Your profile has been successfully updated!")
                    .foregroundStyle(successfulUpdate ? .red : .clear)
                    .font(.custom("Minecraft", size: 20))
                    .padding(.top, 20)
                
            }.frame(width: UIScreen.main.bounds.width - 15)
        }
        
    }
}

#Preview {
    whatAreYouInterestedInView(updatingProfile: false, signUpPageIndex: .constant(1), signUpVM: SignUpViewModel())
}
