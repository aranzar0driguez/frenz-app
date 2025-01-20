//
//  MainCardPictureView.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 10/14/24.
//

import Foundation
import SwiftUI

struct MainCardPictureView: View {
    
    var user: user
    
    var body: some View {
        //  Image
        ZStack(alignment: .bottom) {
            
            
            if let imageURL = URL(string: user.imagesURL[0]) {
                
                
                VStack {
                    
                    EventRemoteImage(urlString: imageURL)
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width-5, height: UIScreen.main.bounds.height/1.4)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                
//                VStack {
//                    AsyncImage(url: imageURL, content: { image in
//                        image
//                            .resizable()
//                            .scaledToFill()
//                            .frame(width: UIScreen.main.bounds.width-5, height: UIScreen.main.bounds.height/1.4)
//                            .clipShape(RoundedRectangle(cornerRadius: 20))
//                    }, placeholder: {
//                        ProgressView()
//                            .frame(width: UIScreen.main.bounds.width-5, height: UIScreen.main.bounds.height/1.4)
//
//                    })
//                        
//                }
            }
            //  TODO: Change this back to the comment above ^^
//            Image("samplePic3")
//                .resizable()
//                .scaledToFill()
//                .frame(width: UIScreen.main.bounds.width-5, height: UIScreen.main.bounds.height/1.4)
//                .clipShape(RoundedRectangle(cornerRadius: 20))


            
            ZStack(alignment: .bottom) {
                Rectangle()
                    .fill(LinearGradient(gradient: Gradient(colors: [.clear, .black]), startPoint: .top, endPoint: .bottom))
                    .opacity(0.9)
                    .frame(height: 150)
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        
                        
                        HStack {
                            Text("\(user.firstName) \(user.lastName), \(user.age)")
                                .lineLimit(1)
                                .minimumScaleFactor(0.4)

                            
                        }
                        .font(.custom("Minecraft", size: 20.5))


                        
                        HStack {
                            
                            Text("\(user.major)")
                            
                        }
                        .lineLimit(1)
                        .minimumScaleFactor(0.4)
                        .font(.custom("Minecraft", size: 17))

                        HStack {
                            if let customField = user.customField {
                                Text("\(customField)")
                            }
                        }
                        .font(.custom("Minecraft", size: 17))
                        
                        
                    }
                    .foregroundColor(.white)
                    .padding(.leading, 5)
                    .padding(.bottom, 5)
                    .frame(width: UIScreen.main.bounds.width-115, alignment: .leading)
                    
                    HStack {
                        
                        
                        if (user.appUtilizationPurpose == .friendsAndRomantic || user.appUtilizationPurpose == .romantic) {
                            Image("heart")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 40, height: 40)
                        }
                        
                        if (user.appUtilizationPurpose == .friendsAndRomantic || user.appUtilizationPurpose == .friends) {
                            Image("peace")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 40, height: 40)
                        }
                    }
                    .padding(.trailing, user.appUtilizationPurpose == .romantic ? 10 : 0)
                    .frame(width: 90, alignment: .trailing)
                }
            }
            .frame(width: UIScreen.main.bounds.width)
        }
    }
}


#Preview {
    MainCardPictureView(user: MockUser.fakeUser)
}
