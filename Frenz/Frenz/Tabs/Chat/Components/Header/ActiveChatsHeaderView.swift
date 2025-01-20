//
//  ActiveChatsHeaderView.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 10/15/24.
//

import SwiftUI

struct ActiveChatsHeaderView: View {
    var body: some View {
        HStack {
            Text("Active Chats")
                .font(.custom("Minecraft", size: 25))
                .foregroundStyle(.white)
            
            Spacer()
        }
        
        Rectangle()
            .frame(height: 1)
            .foregroundStyle(.white)
            .padding(.bottom, 10)
    }
}

#Preview {
    ActiveChatsHeaderView()
}
