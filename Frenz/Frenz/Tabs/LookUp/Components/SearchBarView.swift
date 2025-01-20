//
//  SearchBarView.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 10/22/24.
//

import Foundation
import SwiftUI

struct SearchBarView: View {
    
    
    @Binding var text: String
    
    @EnvironmentObject var allUsers: AllOfUsers
    
    var body: some View {
        
        let keywordBinding = Binding<String>(
            
            get: {
                text
            },
            set: {
                
                text = $0 //whatever was passed in
                allUsers.fetchUsers(from: text)
            }
            
        )
        
        HStack {
            ZStack {
                Rectangle()
                    .fill(Color.black)
                    .frame(height: 50)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .overlay(RoundedRectangle(cornerRadius: 20)
                        .stroke(.white, lineWidth: 1))
                                
                HStack {
                    
//                    Text("Search for a friend . . . or crush")
//                        .foregroundStyle(text.isEmpty ? .gray : .clear)
//                        .font(.custom("Minecraft", size: 15))
//                        .padding(.horizontal, 15)
                    
                    Spacer()
                }
                
                
                HStack {
                    TextField("Search for a friend . . . or crush", text: keywordBinding)
                        .textInputAutocapitalization(.none)
                        .font(.custom("Minecraft", size: 15))
                        .foregroundStyle(.white)
                        .background(.clear)
                        .padding(.horizontal, 15)
                        .onChange(of: text) { newValue in
                            allUsers.fetchUsers(from: newValue)
                        }
                    
                    
                    Image("magnifyingGlass")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 55, height: 55)
                        .padding(.trailing, 15)
                        .background(.clear)
                    
                }
            }
            .padding(.horizontal)
        }
    }
}

struct searchResult: View {
    var user: user
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                
                if let imageURL = URL(string: user.imagesURL[0]) {
                    
                    EventRemoteImage(urlString: imageURL)
                        .scaledToFill()
                        .frame(width: 45, height: 45)
                        .overlay(Circle().stroke(.gray, lineWidth: 1.0))
                        .clipShape(Circle())
                        .padding(.leading, 15)
                }
                
                Text("\(user.firstName) \(user.lastName)")
                    .foregroundStyle(.white)
                    .font(.custom("Minecraft", size: 12))
                    .padding([.leading, .trailing], 15)
                Spacer()
            }
            .padding(.vertical, 8)
            
            Rectangle()
                .foregroundStyle(.gray)
                .frame(height: 1)
        }
        .background(.black)
    }
}



