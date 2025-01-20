//
//  completeWrittenPromptsView.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 10/17/24.
//

import SwiftUI

struct completeWrittenPromptsView: View {
    
    @Binding var signUpPageIndex: Int
    @ObservedObject var signUpVM : SignUpViewModel
//    
    var updatingProfile: Bool
    var userEmail: String?
//    
    @State var successfulUpdate = false
//    
        
    
    var body: some View {
        
        //        GeometryReader { _ in
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            if !updatingProfile {
                
                BackArrowButton(numOfPagesToGoBack: 1, signUpPageIndex: $signUpPageIndex, topPadding: 30, leadingPadding: 15)
                
            }
            
            VStack {
                Text("Complete your prompts")
                    .font(.custom("Minecraft", size: 23))
                    .foregroundStyle(.white)
                    .padding(.bottom, 20)
                
                if successfulUpdate {
                    Text("Your profile has been successfully updated!")
                        .foregroundStyle(.red )
                        .font(.custom("Minecraft", size: 20))
                        .padding(.top, 20)
                        .padding(.bottom, 10)
                }
                
                ScrollView{
                    
                    
                    ForEach(signUpVM.appUser.selectedWrittenPrompts, id: \.self) { prompt in
                        promptFieldText(header: prompt, promptAnswer: $signUpVM.appUser.answeredWrittenPrompts[signUpVM.appUser.selectedWrittenPrompts.firstIndex(of: prompt) ?? 0])
                    }
                    
                }
                if !updatingProfile {
                    
                    ZStack {
                        
                        NextButtonBottom (action: {
                            
                            signUpPageIndex += 1

                            
                        }, disabled: signUpVM.appUser.answeredWrittenPrompts.contains(""), updatingProfile: false)
                        
//                        if isLoading {
//                            ProgressView()
//                                .progressViewStyle(CircularProgressViewStyle(tint: .black))
//                                .scaleEffect(2)
//                                .frame(maxWidth: 130, maxHeight: 38)
//                        }
                        
                    }
                }
                
                else {
                    
                    Button {
                        
                        guard let email = userEmail else { return }
                        
                        Task {
                            
                            
                            try await UserManager.shared.updateUserField(userEmail: email, signUpVM.appUser.selectedWrittenPrompts, codingKeyRawValue: user.CodingKeys.selectedWrittenPrompts.rawValue)
                            
                            try await UserManager.shared.updateUserField(userEmail: email, signUpVM.appUser.answeredWrittenPrompts, codingKeyRawValue: user.CodingKeys.answeredWrittenPrompts.rawValue)
                            
                            successfulUpdate = true
                            
                        }
                        
                    } label : {
                        
                        NextButton(buttonText: "Update", textColor: .black, buttonColor: .white, isDisabled: false)
                    }
                    
                }
                
            }
            
            
            
        }
        //        }.ignoresSafeArea(.keyboard, edges: .all)
        
    }
}
//#Preview {
//    completeWrittenPromptsView(signUpPageIndex: .constant(1), signUpVM: SignUpViewModel(), updatingProfile: false, goBackToRootView: .constant(false))
//}

struct promptFieldText: View {
    
    var header: String
    @Binding var promptAnswer: String
    
    var body: some View {
        VStack (alignment: .leading){
            
            Text(header)
                .font(.custom("Minecraft", size: 19))
                .foregroundStyle(.white)
                .padding([.leading, .trailing, .top], 15)
                .padding(.bottom, 7)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            
            
            HStack {
                
                Spacer()
                
                TextEditor(text: $promptAnswer)
                    .font(.custom("Minecraft", size: 16))
                    .foregroundStyle(.white)
                    .colorScheme(.dark)
                    .frame(width: UIScreen.main.bounds.width - 40, height: 60)
                    .background(.black)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(.white, lineWidth: 1))
                    .onChange(of: promptAnswer) { newValue in
                        if newValue.count > 50 {
                            promptAnswer = String(newValue.prefix(50))
                        }
                    }
                
                Spacer()
            }
            
            
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width - 15, height: 127, alignment: .leading)
        .overlay(RoundedRectangle(cornerRadius: 20).stroke(.white, lineWidth: 1.5))
    }
    
}
