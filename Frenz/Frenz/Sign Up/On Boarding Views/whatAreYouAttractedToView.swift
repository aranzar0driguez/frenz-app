//
//  whatAreYouAttractedToView.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 10/17/24.
//

import SwiftUI

struct whatAreYouAttractedToView: View {
    
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
                Text("What sex are you attracted to?")
                    .font(.custom("Minecraft", size: 25))
                    .foregroundStyle(.white)
                    .padding(.bottom, 40)
                
                
                VStack (spacing: 20){
                    
                    
                    ForEach(AttractedSex.allCases, id: \.self) { sex in
                        
                        WhiteBoxButton(buttonText: sex.rawValue, isSelected: signUpVM.appUser.attractedSex == sex, buttonWidth: UIScreen.main.bounds.width, buttonHeight: 70) {
                            signUpVM.appUser.attractedSex = sex
                        }
                    }

                }.padding(.bottom, 30)
                
                NextButtonBottom (action: {
                    
                    if updatingProfile {
                        
                        Task {
                            
                            guard let email = userEmail, let major = signUpVM.appUser.attractedSex else {
                                return
                            }
                            
                            try await UserManager.shared.updateUserField(userEmail: email, major.rawValue, codingKeyRawValue: user.CodingKeys.attractedSex.rawValue)
                            
                            successfulUpdate = true
                        }
                        
                    }
                    else {
                        withAnimation(.spring()) {
                            
                            if signUpVM.appUser.appUtilizationPurpose == .romantic || signUpVM.appUser.appUtilizationPurpose == .friendsAndRomantic {
                                
                                signUpPageIndex += 1

                            } else if signUpVM.appUser.appUtilizationPurpose == .friends{
                                signUpPageIndex += 3
                            }
                            
                        }
                    }
                }, disabled: signUpVM.appUser.attractedSex == nil, updatingProfile: updatingProfile)
                
                Text("Your profile has been successfully updated!")
                    .foregroundStyle(successfulUpdate ? .red : .clear)
                    .font(.custom("Minecraft", size: 20))
                    .padding(.top, 20)
            }
        }
    }
}

#Preview {
    whatAreYouAttractedToView(updatingProfile: false, signUpPageIndex: .constant(1), signUpVM: SignUpViewModel())
}
