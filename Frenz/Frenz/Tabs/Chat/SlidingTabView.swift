//
//  ChatView.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 10/15/24.
//

import SwiftUI

struct SlidingTabView: View {
        
    @Binding var index : Int
    var keepHeader: Bool
    @ObservedObject var mapViewModel : MapViewModel
    
    var body: some View {
        
        VStack {
            
            if keepHeader {
                HStack {
                    Text("Chats & Matches")
                    
                    Spacer()
                }
                .font(.custom("Minecraft", size: 30))
                .padding(.horizontal)
                .foregroundColor(.white)
            }
            
            //  Tab view
            
            HStack (spacing: 0){
                
                Spacer(minLength: 0)
                
                Text(mapViewModel.showFriendsFirst == true ? "Friends" : "Admirers")
                    .foregroundStyle(self.index == 0 ? .black: .white)
                    .font(.custom("Minecraft", size: 15))
                    .frame(width: 150, height: 45)
                    .background(.white.opacity(self.index == 0 ? 1 : 0))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding([.bottom, .top], 4)
                    .onTapGesture {

                        if !keepHeader && mapViewModel.showFriendsFirst == false  {
                            
                            mapViewModel.clickedOnAdmirers = true
                            
                        } else if !keepHeader && mapViewModel.showFriendsFirst == true {
                            
                            mapViewModel.clickedOnAdmirers = false
                        }
                        
                        withAnimation(.default) {
                            self.index = 0
                        }
                        
                    }
                
                
                Spacer(minLength: 0)
                
                
                
                Text(mapViewModel.showFriendsFirst == true ? "Admirers" : "Friends")
                    .foregroundStyle(self.index == 1 ? .black: .white)
                    .font(.custom("Minecraft", size: 15))
                    .frame(width: 150, height: 45)
                    .background(.white.opacity(self.index == 1 ? 1 : 0))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding([.bottom, .top], 4)
                    .onTapGesture {

                        if !keepHeader && mapViewModel.showFriendsFirst == false {
                            mapViewModel.clickedOnAdmirers = false
                        } else if !keepHeader && mapViewModel.showFriendsFirst == true {
                            
                            mapViewModel.clickedOnAdmirers = true
                        }
                        
                        withAnimation(.default) {
                            self.index = 1
                        }
                        
                    }
                
                Spacer(minLength: 0)

                
            }
            .frame(width: UIScreen.main.bounds.width/1.2)
            .background(.black)
            .clipShape(Capsule())
            .padding(.top, 5)
        }
    }
}

#Preview {
    SlidingTabView(index: .constant(1), keepHeader: false, mapViewModel: MapViewModel())
}
