//
//  SignUpP4View.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 10/16/24.
//

import SwiftUI
import WrappingHStack

struct SignUpP4View: View {
    
    @EnvironmentObject var universityEO: UniversityViewModel
    
    var updatingProfile: Bool
    var userEmail: String?
    
    @Binding var signUpPageIndex: Int
    @ObservedObject var signUpVM : SignUpViewModel
    @State var successfulUpdate = false

    
    var body: some View {
        
        ZStack (alignment: .bottom){
            
            Color.black.edgesIgnoringSafeArea(.all)
            
            if !updatingProfile {
                BackArrowButton(numOfPagesToGoBack: 1, signUpPageIndex: $signUpPageIndex, topPadding: 30, leadingPadding: 15)
            }
            
            
            VStack {
                Text("Select your major:")
                    .foregroundStyle(.white)
                    .font(.custom("Minecraft", size: 27))
                    .padding(.bottom, 20)
                
                if successfulUpdate {
                    Text("Your profile has been successfully updated!")
                        .foregroundStyle(.red)
                        .font(.custom("Minecraft", size: 20))
                        .padding(.bottom, 20)
                }
                
                ScrollView{
                    
                    if let majors = universityEO.university?.majors {
                        ForEach(majors, id: \.self) { major in
                            Button {
                                signUpVM.appUser.major = major
                            } label : {
                                BubbleButtonTapped(buttonText: major, isSelected: signUpVM.appUser.major == major, color: .white, tappedFontColor: .black)
                                    .padding([.bottom, .top], 4)
                            }
                        }
                    }
                    
                }
                
                
                Spacer()
                
                NextButtonBottom (action: {
                    
                    if updatingProfile {
                        Task {
                            guard let email = userEmail else {
                                return
                            }
                            
                            try await UserManager.shared.updateUserField(userEmail: email, signUpVM.appUser.major, codingKeyRawValue: user.CodingKeys.major.rawValue)
                            
                            successfulUpdate = true
                        }
                    }
                    
                    else {
                        withAnimation(.spring()) {
                            
                            //  If the college has an array of dormNames, go onto the next page
                            if let custom = universityEO.university?.dormNames {
                                signUpPageIndex += 1
                            //  If the college does NOT have an array of dormNames, skip the next page
                            } else {
                                signUpPageIndex += 2
                            }
                        }
                    }
                }, disabled: signUpVM.appUser.major.count == 0, updatingProfile: updatingProfile)
            }
            
        }
    }
    
    
    
}

#Preview {
    SignUpP4View(updatingProfile: false, signUpPageIndex: .constant(0), signUpVM: SignUpViewModel())
}
