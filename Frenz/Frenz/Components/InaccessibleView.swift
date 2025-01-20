//
//  InaccessibleView.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 12/1/24.
//

import SwiftUI

struct InaccessibleView: View {
    
    var doNotShowAdmirers: Bool
    
    var body: some View {
        ZStack {
            
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack {
                Text(doNotShowAdmirers ? "Since you have indicated that you're only interested in <Making Friends>, we have hidden this view. You can change this in your settings under Update Profile > Admirers & Friends. Click on the <Friends> button above to view cool people!" : "Since you have indicated that you're only interested in <Meeting Romantic Suitors>, we have hidden this view. You can change this in your settings under Update Profile > Admirers & Friends.")
                    .foregroundStyle(.white)
                    .font(.custom("Minecraft", size: 20))
                    .multilineTextAlignment(.center)
                    .padding([.leading, .trailing], 15)
                    .lineSpacing(3)
                    .padding(.bottom, 25)
                
                Image("heart")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
            }
        }
    }
}

#Preview {
    InaccessibleView(doNotShowAdmirers: true)
}
