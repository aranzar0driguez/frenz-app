//
//  SignUpP1View.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 10/16/24.
//

import SwiftUI

struct SignUpP1View: View {
    
    

    @Binding var signUpPageIndex: Int
    @ObservedObject var signUpVM : SignUpViewModel
    
    var universityID: String
    var userEmail: String

    var body: some View {
        
        // User First Name, Last Name
        
        GeometryReader { _ in
            ZStack {
                
                Color.black.edgesIgnoringSafeArea(.all)
                
                
                VStack {
                    VStack {
                        
                        HStack {
                            Text("My name is:")
                                .foregroundStyle(.white)
                                .font(.custom("Minecraft", size: 30))
                                .padding(.bottom, 20)
                            
                            Spacer()
                            
                        }
                        .frame(width: UIScreen.main.bounds.width - 100, height: 25)
                        .padding(.bottom, 60)
                        
                        
                        CustomTextEditorView(text: $signUpVM.appUser.firstName, header: "First Name", bottomPadding: -20)
                        
                        
                        
                        CustomTextEditorView(text: $signUpVM.appUser.lastName, header: "Last Name", bottomPadding: 0)
                        
                        
                        Button {
                            withAnimation(.spring()) {
                                
                                signUpVM.appUser.universityID = universityID
                                signUpVM.appUser.email = userEmail
                                signUpPageIndex += 1
                                
                            }
                        } label : {
                            
                            NextButton(buttonText: "Next", textColor: .black, buttonColor: .white, buttonWidth: UIScreen.main.bounds.width - 100, buttonHeight: 45, isDisabled: signUpVM.appUser.firstName.isEmpty || signUpVM.appUser.lastName.isEmpty)
                        }
                        .disabled(signUpVM.appUser.firstName.isEmpty || signUpVM.appUser.lastName.isEmpty)
                        .padding(.bottom, 15)
                        
                        Text("*You will NOT be able to change this later")
                            .foregroundStyle(.white)
                            .font(.custom("Minecraft", size: 15))
                        
                    }
                    
                    
                }
                .padding(.bottom, UIScreen.main.bounds.height/3)
            }
        }.ignoresSafeArea(.keyboard, edges: .all)

    }
}

#Preview {
    SignUpP1View(signUpPageIndex: .constant(0), signUpVM: SignUpViewModel(), universityID: "", userEmail: "")
}


extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

