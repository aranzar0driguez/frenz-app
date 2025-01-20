//
//  NextButtonBottom.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 10/16/24.
//

import SwiftUI

struct NextButtonBottom: View {
    
    var action: () -> Void
    var disabled: Bool
    var updatingProfile: Bool
    
    var body: some View {
        ZStack {
            
            Color.black.edgesIgnoringSafeArea(.all)
            
            
            Button(action: action) {
                
                NextButton(buttonText: updatingProfile ? "Update": "Next", textColor: .black, buttonColor: .white, isDisabled: disabled)
                    .padding(.top, 20)
                   
            }
            .disabled(disabled)
          
            
        }.frame(height: 60)
    }
}

