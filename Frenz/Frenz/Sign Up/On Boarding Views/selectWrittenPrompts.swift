//
//  selectWrittenPrompts.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 10/17/24.
//

import SwiftUI

struct selectWrittenPrompts: View {
    
    @EnvironmentObject var universityEO: UniversityViewModel
    @AppStorage("signed_in") var currentUserSignedIn: Bool?
    
    @Binding var signUpPageIndex: Int
    @ObservedObject var signUpVM : SignUpViewModel

    var updatingProfile: Bool
    var userEmail: String?

    
    
    // @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            if !updatingProfile {
                BackArrowButton(numOfPagesToGoBack: 1, signUpPageIndex: $signUpPageIndex, topPadding: 30, leadingPadding: 15)
            }


            //  Based on the number of pictures chosen, it gives you a certain number of prompts to pick from
            VStack {
                Text(updatingProfile ? "Since you currently have \(signUpVM.appUser.selectedPicturePrompts.count) pictures in your profile, please select \(signUpVM.appUser.selectedPicturePrompts.count - 1) written prompts." : "Select \(signUpVM.appUser.selectedPicturePrompts.count - 1) written prompts \nfor your profile:")
                    .font(.custom("Minecraft", size: 22))
                    .foregroundStyle(.white)
                    .padding(.bottom, 20)
                    .multilineTextAlignment(.center)
                
                
                ScrollView {
                    
                    if let commentPrompts = universityEO.university?.commentPrompts {
                        
                        ForEach(commentPrompts, id: \.self) { prompt in
                            
                            WhiteBoxButton(buttonText: prompt, isSelected: signUpVM.appUser.selectedWrittenPrompts.contains(prompt), buttonWidth: UIScreen.main.bounds.width - 15, buttonHeight: 80) {
                                if signUpVM.appUser.selectedWrittenPrompts.contains(prompt) {
                                    if let index = signUpVM.appUser.selectedWrittenPrompts.firstIndex(of: prompt) {
                                        signUpVM.appUser.selectedWrittenPrompts.remove(at: index)
                                        signUpVM.appUser.answeredWrittenPrompts.remove(at: index)
                                    }
                                }
                                else {
                                    signUpVM.appUser.selectedWrittenPrompts.append(prompt)
                                    signUpVM.appUser.answeredWrittenPrompts.append("")
                                }
                            }
                            .padding(.bottom, 7)
                        }
                    }
                }
                
                if !updatingProfile {
                    
                    NextButtonBottom (action: {
                        
                        withAnimation(.spring()) {
                            signUpPageIndex += 1
                        }
                        
                    }, disabled: signUpVM.appUser.selectedWrittenPrompts.count != (signUpVM.appUser.selectedPicturePrompts.count - 1), updatingProfile: false)
                    
                }
                                
                else {
                         
                    
                    NavigationLink {
                        
                        completeWrittenPromptsView(signUpPageIndex: .constant(0), signUpVM: signUpVM, updatingProfile: true, userEmail: userEmail)                        
                        
                    } label: {
                        
                        NextButton(buttonText: "Next", textColor: .black, buttonColor: .white, isDisabled: signUpVM.appUser.selectedWrittenPrompts.count != (signUpVM.appUser.selectedPicturePrompts.count - 1))
                        
                    }
                    
                    

                    
                }
                
            }
        }
      
    }
}

//#Preview {
//    selectWrittenPrompts(signUpPageIndex: .constant(1), signUpVM: SignUpViewModel(), updatingProfile: false, showNextView: .constant(false))
//}
