//
//  whatIsYourSexView.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 11/28/24.
//

import SwiftUI

struct whatIsYourSexView: View {
    
    var updatingProfile: Bool
    var userEmail: String?
    
    @Binding var signUpPageIndex: Int
    @ObservedObject var signUpVM: SignUpViewModel
    
    @State var successfulUpdate = false
    
    var body: some View {
        
        ZStack {
            
            Color.black.edgesIgnoringSafeArea(.all)
            
            if !updatingProfile {
                BackArrowButton(numOfPagesToGoBack: 1, signUpPageIndex: $signUpPageIndex, topPadding: 30, leadingPadding: 15)
            }
            
            VStack {
                Text("What is your sex?")
                    .font(.custom("Minecraft", size: 25))
                    .foregroundStyle(.white)
                    .padding(.bottom, 40)
                
                VStack (spacing: 20) {
                    
                    ForEach(Sex.allCases, id: \.self) { sex in
                        
                        
                        //  TODO: Complte this !!the is selected
                        WhiteBoxButton(buttonText: sex.rawValue, isSelected: signUpVM.appUser.sex == sex, buttonWidth: UIScreen.main.bounds.width - 15, buttonHeight: 70) {
                            
                            signUpVM.appUser.sex = sex
                            
                        }
                        .padding(.bottom, 5)
                        
                    }
                    
                }
                .padding(.bottom, 30)
                
                NextButtonBottom(action: {
                    if updatingProfile {
                        
                        //  TODO: Complete this  !!
                        Task {
                            
                            guard let email = userEmail, let sex = signUpVM.appUser.sex else {
                                return
                            }
                            
                            try await UserManager.shared.updateUserField(userEmail: email, sex.rawValue, codingKeyRawValue: user.CodingKeys.sex.rawValue)
                            
                            successfulUpdate = true
                            
                        }
                        
                    } else {
                        withAnimation(.spring()) {
                            signUpPageIndex += 1
                        }
                    }
                }, disabled: signUpVM.appUser.sex == nil, updatingProfile: updatingProfile)
                
                Text("Your profile has been succesfully updated!")
                    .foregroundStyle(successfulUpdate ? .white : .clear)
                    .font(.custom("Minecraft", size: 20))
                    .padding(.top, 20)
                
            }

        }
    }
}

#Preview {
    whatIsYourSexView(updatingProfile: false, signUpPageIndex: .constant(1), signUpVM: SignUpViewModel())
}
