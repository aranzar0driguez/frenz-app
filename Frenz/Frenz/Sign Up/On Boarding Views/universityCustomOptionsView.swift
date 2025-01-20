//
//  universityCustomOptionsView.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 11/29/24.
//

import SwiftUI

//  Only show this view is the university has a customoptions view
struct universityCustomOptionsView: View {

    @EnvironmentObject var universityEO: UniversityViewModel
    
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
                Text("Please select your residential college: ")
                    .foregroundStyle(.white)
                    .font(.custom("Minecraft", size: 27))
                    .padding(.bottom, 20)
                
                if successfulUpdate {
                    Text("Your profile has been successfully updated!")
                        .foregroundStyle(.red)
                        .font(.custom("Minecraft", size: 20))
                        .padding(.bottom, 20)
                }
                
                ScrollView {
                    
                    if let customFields = universityEO.university?.dormNames {
                        ForEach(customFields, id: \.self) { field in
                            Button {
                                signUpVM.appUser.customField = field
                            } label : {
                                BubbleButtonTapped(buttonText: field, isSelected: signUpVM.appUser.customField == field, color: .white, tappedFontColor: .black)
                                    .padding([.bottom, .top], 4)
                            }
                        }
                    }
                }
                
                Spacer()
                
                NextButtonBottom(action: {
                    if updatingProfile {
                        
                        Task {
                            
                            guard let email = userEmail, let newValue = signUpVM.appUser.customField else {
                                return
                            }
                            
                            try await UserManager.shared.updateUserField(userEmail: email, newValue, codingKeyRawValue: user.CodingKeys.customField.rawValue)
                            
                            successfulUpdate = true
                        }
                        
                    } else {
                        
                        withAnimation(.spring()) {
                            signUpPageIndex += 1
                        }
                        
                    }
                }, disabled: signUpVM.appUser.customField!.count == 0, updatingProfile: updatingProfile)
            }
            
        }
    }
}

#Preview {
    universityCustomOptionsView(updatingProfile: false, signUpPageIndex: .constant(1), signUpVM: SignUpViewModel())
}
