//
//  UserPinView.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 10/14/24.
//

import Foundation
import SwiftUI

struct UserPinView: View {
    
    var user: user
    @ObservedObject var mapViewModel : MapViewModel
    var url: String? = nil
    
    var body: some View {
    
        
        if let imageURL = URL(string: user.imagesURL[0]) {
            
            VStack {
                EventRemoteImage(urlString: imageURL)
                    .scaledToFill()
                    .frame(width: 55, height: 55)
                    .clipShape(Circle())
                
                
                
            }.onTapGesture {
                mapViewModel.selectedUser = user
                mapViewModel.showCardViewSheet.toggle()
            }
        }
    }
    
    
}

#Preview {
    UserPinView(user: MockUser.fakeUser, mapViewModel: MapViewModel())
}
