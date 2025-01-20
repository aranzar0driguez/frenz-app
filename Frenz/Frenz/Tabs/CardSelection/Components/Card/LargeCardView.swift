//
//  LargeCardView.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 11/24/24.
//

import SwiftUI

struct LargeCardView: View {
    
    var user: user
//    var index: Int
    @ObservedObject var carouselUserVM : MapViewModel


    
    var body: some View {
        
        if let imageURL = URL(string: user.imagesURL[0]) {
            VStack {
                
                
                ZStack {
                    
                    
                    EventRemoteImage(urlString: imageURL)
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width/1.2, height: UIScreen.main.bounds.height/1.5)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                    
                    Rectangle()
                        .fill(LinearGradient(gradient: Gradient(colors: [.clear, .black]), startPoint: .center, endPoint: .bottom))
                        .opacity(1.0)
                        .frame(width: UIScreen.main.bounds.width/1.2, height: UIScreen.main.bounds.height/1.5)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                    VStack (alignment: .leading){
                        Text("\(user.firstName), \(user.age)")
                        if let customField = user.customField {
                            BubbleButton(interest: customField, color: .blue)
                        }
                        BubbleButton(interest: user.major, color: .red)
                    }
                    .foregroundStyle(.white)
                    .padding(.leading, 15)
                    .padding(.bottom, 20)
                    .font(.custom("Minecraft", size: 25))
                    .frame(width: UIScreen.main.bounds.width/1.2, height: UIScreen.main.bounds.height/1.5, alignment: .bottomLeading)
                    
                    
                }
                
                .frame(width: UIScreen.main.bounds.width/1.2, height: UIScreen.main.bounds.height/1.5)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            .onTapGesture(perform: {
                carouselUserVM.selectedUser = user
                carouselUserVM.showCardViewSheet = true
            })
            
            .sheet(isPresented: $carouselUserVM.showCardViewSheet) {
                
                if let user = carouselUserVM.selectedUser {
                    
                    CardView(showAdmirersGifts: carouselUserVM.clickedOnAdmirers, showGiftSendingOptions: true, user: user, updateCardView: true)

                }
            }
        }
        
        

        
    }
}
//
//#Preview {
//    LargeCardView(user: MockUser.fakeUser, showCardView: .constant(false), index: 1)
//}
