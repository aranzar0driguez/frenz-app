//
//  selectPicturePromptsView.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 10/17/24.
//

import SwiftUI

struct selectPicturePromptsView: View {
    
    @EnvironmentObject var universityEO: UniversityViewModel

    @Binding var signUpPageIndex: Int
    @ObservedObject var signUpVM : SignUpViewModel
    
    var updatingProfile: Bool
    var userEmail: String?
    
    @State private var shouldNavigate = false
    
    var body: some View {
        
        ZStack {
            
            Color.black.edgesIgnoringSafeArea(.all)
            
            if !updatingProfile {
                BackArrowButton(numOfPagesToGoBack: 1, signUpPageIndex: $signUpPageIndex, topPadding: 30, leadingPadding: 15)
            }
            
            
            VStack {
                Text("Select 1-5 prompts for \n your pictures:")
                    .font(.custom("Minecraft", size: 24))
                    .foregroundStyle(.white)
                    .padding(.bottom, 20)
                    .multilineTextAlignment(.center)
                
                
                ScrollView {
                    
                    if let picPrompts = universityEO.university?.picPrompts {
                        ForEach(picPrompts, id: \.self) { prompt in
                            
                            WhiteBoxButton(buttonText: prompt, isSelected: signUpVM.appUser.selectedPicturePrompts.contains(prompt), buttonWidth: UIScreen.main.bounds.width - 15, buttonHeight: 80) {
                                if signUpVM.appUser.selectedPicturePrompts.contains(prompt) {
                                    
                                    //  If the user taps on the same prompt again, it removes it from the array
                                    if let index = signUpVM.appUser.selectedPicturePrompts.firstIndex(of: prompt) {
                                        
                                        
                                        signUpVM.appUser.selectedPicturePrompts.remove(at: index)
                                        signUpVM.selectedImages.remove(at: index)
                                        signUpVM.photoPickerItems.remove(at: index)
                                        
                                    }
                                }
                                else {
                                    
                                    //  If the user hasn't previously tapped the prompt, it adds it to the array
                                    signUpVM.appUser.selectedPicturePrompts.append(prompt)
                                    signUpVM.selectedImages.append(UIImage(resource: .no))
                                    signUpVM.photoPickerItems.append(nil)
                                }
                            }
                            .padding(.bottom, 7)
                        }
                    }
                }
                
                if !updatingProfile {
                    NextButtonBottom (action: {
                        withAnimation(.spring()) {
                            
                            if signUpVM.appUser.selectedPicturePrompts.count != signUpVM.selectedImages.count {
                                
                                
                                signUpVM.selectedImages.removeLast()
                                signUpVM.photoPickerItems.removeLast()
                            }
                            
                            
                            signUpPageIndex += 1
                            
                        }
                    }, disabled: signUpVM.appUser.selectedPicturePrompts.count < 2 || signUpVM.appUser.selectedPicturePrompts.count > 5, updatingProfile: false)
                }
                
                else {
                    
                    
                    NavigationLink(destination: selectImagesView(updatingProfile: true, userEmail: userEmail!, signUpPageIndex: $signUpPageIndex, signUpVM: signUpVM), isActive: $shouldNavigate) {
                        
                        NextButton(buttonText: "Next", textColor: .black, buttonColor: .white, isDisabled: signUpVM.appUser.selectedPicturePrompts.count < 2 || signUpVM.appUser.selectedPicturePrompts.count > 6)
                            .onTapGesture {
                                if signUpVM.appUser.selectedPicturePrompts.count != signUpVM.selectedImages.count {
                                    
                                    
                                    signUpVM.selectedImages.removeLast()
                                    signUpVM.photoPickerItems.removeLast()

                                    
                                }

                                
                                shouldNavigate = true
                            }
                    }
                                        
                }
                
            }
            .frame(width: UIScreen.main.bounds.width - 15)
            
        }
    }
}

#Preview {
    selectPicturePromptsView(signUpPageIndex: .constant(1), signUpVM: SignUpViewModel(), updatingProfile: false)
}
