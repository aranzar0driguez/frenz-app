//
//  SettingsHeaderView.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 11/19/24.
//

import SwiftUI

struct SettingsHeaderView: View {
    
    var user: user
    var imagesURL: String
    var updatingProfile: Bool
    
    var body: some View {
        
        
        if let imageURL = URL(string: imagesURL) {
            
            VStack {
                EventRemoteImage(urlString: imageURL)
                    .scaledToFill()
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
                    .overlay(Circle()
                        .stroke(.white, lineWidth: 3))
                    .padding(.bottom, 20)
            }

        }
        
        //  Name
        
        Text(updatingProfile ? "\(user.firstName) \(user.lastName), \(user.age)" : "\(user.firstName) \(user.lastName)")
            .foregroundStyle(.white)
            .font(.custom("Minecraft", size: 25))
            .multilineTextAlignment(.center)
            .padding(.bottom, 3)
        
        //  Email
        Text("\(user.email)")
            .foregroundStyle(.gray)
            .font(.custom("Minecraft", size: 14))
            .padding(.bottom)
    }
}

#Preview {
    SettingsHeaderView(user: MockUser.fakeUser, imagesURL: "", updatingProfile: false)
}
