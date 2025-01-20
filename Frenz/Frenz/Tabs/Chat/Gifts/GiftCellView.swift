//
//  GiftCellView.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 10/15/24.
//

import SwiftUI

struct GiftCellView: View {
    
    var user: user
    var rimColor: Color
    
    var body: some View {
 
        
        ZStack {
            //  Maybe display major instead?
            
//            Image(user.images[0])
//                .resizable()
//                .scaledToFit()
//                .frame(width: UIScreen.main.bounds.width/2-15, height: 150)
//                .blur(radius: 25.00)
//                .clipShape(Circle())
//                .overlay(Circle()
//                    .stroke(rimColor, lineWidth: 4))
            
            
            Image("teddyBear")
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .padding(.top, 130)
            

            
        }
    
        
        
        
    }
}

#Preview {
    GiftCellView(user: MockUser.fakeUser, rimColor: .green)
}
