//
//  BackArrowButton.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 10/19/24.
//

import SwiftUI

struct BackArrowButton: View {
    
    //  Number of pages to go back (can be calculated depending on whether the user has chosen to only do friends and/or only do
    var numOfPagesToGoBack: Int
    @Binding var signUpPageIndex: Int
    var topPadding: CGFloat
    var leadingPadding: CGFloat
    var color: Color?
//    var goingBacktoSelectImagePromptView: Bool? = false
//    @Binding var signUpVM : SignUpViewModel

    var body: some View {
        
        
        

            
            VStack {
                HStack {
                    Text("<")
                        .foregroundStyle(color ?? .white)
                        .font(.custom("Minecraft", size: 55))
                        .padding(.top, topPadding)
                        .padding(.leading, leadingPadding)
                        .onTapGesture {
                            withAnimation(.spring()) {
                                
                                signUpPageIndex = signUpPageIndex - numOfPagesToGoBack
                            }
                        }
                    
                    Spacer()
                }
                
                Spacer()
            }
            .ignoresSafeArea()
        
    }
}

#Preview {
    BackArrowButton(numOfPagesToGoBack: 2, signUpPageIndex: .constant(1), topPadding: 10, leadingPadding: 10)
}
