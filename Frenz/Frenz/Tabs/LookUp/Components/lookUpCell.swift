//
//  lookUpCell.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 10/15/24.
//

import SwiftUI

struct lookUpCell: View {
    
    var user: user
    
    var body: some View {
        VStack {
            
            
            ZStack (alignment: .bottom){
                
                
                Color.black.edgesIgnoringSafeArea(.all)


                if let imageURL = URL(string: user.imagesURL[0]) {
                    
                    EventRemoteImage(urlString: imageURL)
                        .scaledToFill()
                        .blur(radius: 27.0)
                        .frame(width: UIScreen.main.bounds.width/2.3, height: 215)
                        .clipShape(RoundedRectangle(cornerRadius: 20))

                }
                
            
//                Rectangle()
//                    .fill(LinearGradient(gradient: Gradient(colors: [.clear, .black]), startPoint: .top, endPoint: .bottom))
//                    .opacity(0.7)
//                    .blur(radius: 10.0)
//                    .frame(width: UIScreen.main.bounds.width/2.3, height: 60)
//                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
                HStack {
                    HStack {
                        
                        Text("\(String(user.firstName.first ?? " ")).")

                        Text("\(String(user.lastName.first ?? " ")).")

                    }
                    .foregroundStyle(.white)
                    .padding(.leading, 10)
                    .padding(.bottom, 0)
                    .font(.custom("Minecraft", size: 15))
                    .frame(alignment: .leading)
                    
                    
                    Spacer()
                    
                        if (user.appUtilizationPurpose == .friendsAndRomantic || user.appUtilizationPurpose == .romantic) {
                            Image("heart")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 30, height: 30)
                        }
                        
                        if (user.appUtilizationPurpose == .friendsAndRomantic || user.appUtilizationPurpose == .friends) {
                            Image("peace")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 30, height: 30)
                        }
                        
                    
                }
                .frame(width: UIScreen.main.bounds.width/2.3)

                
            }
            .padding(.bottom, 5)

            
            VStack (alignment: .leading) {
                
                if let customField = user.customField {
                    BubbleButton(interest: customField, color: .red)
                }
//                BubbleButton(interest: user.major, color: .blue)
                
            }
            .font(.custom("Minecraft", size: 15))
            .frame(width: UIScreen.main.bounds.width/2.3, alignment: .leading)
            
            
            
            
        }.background(.black)
        
        
        
    }
}

#Preview {
    lookUpCell(user: MockUser.fakeUser)
}
