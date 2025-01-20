//
//  LookingForView.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 10/14/24.
//

import SwiftUI

struct LookingForView: View {
    
    var user: user
    var showingAdmirers: Bool
    
    var body: some View {
//        ScrollView(.horizontal) {
            VStack {
//                ForEach(0..<6) {_ in
                    
//                    HStack {
//                        Image("yellowHeart")
//                            .resizable()
//                            .scaledToFill()
//                            .frame(width: 35, height: 35)
                
     
                
                HStack {
                    
                    
                    Text("Looking for:")
                        .font(.custom("Minecraft", size: 22))
                        .foregroundStyle(.white)
                    
                    Image("magnifyingGlass")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                    Spacer()

                }
                
                HStack {
                    
                    
                    
                    if let lookingFor = user.lookingFor?.rawValue {
                        Text(showingAdmirers ? "\(lookingFor)" : "Cool Friends")
                            .font(.custom("Minecraft", size: 17))
                            .foregroundStyle(.white)
                    } else {
                        Text("Cool Friends")
                            .font(.custom("Minecraft", size: 17))
                            .foregroundStyle(.white)
                    }
                    
                    Spacer()
                }
                        
//                    }
                    
//                }
//            }
        }
        .padding(.bottom, 15)

    }
}

#Preview {
    LookingForView(user: MockUser.fakeUser, showingAdmirers: false)
}
