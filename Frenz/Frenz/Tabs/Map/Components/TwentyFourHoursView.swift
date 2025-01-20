//
//  TwentyFourHoursView.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 11/30/24.
//

import SwiftUI

struct TwentyFourHoursView: View {
    
    @ObservedObject var mapViewModel : MapViewModel
    
    var body: some View {
        VStack {
            Spacer()
            
            ZStack {
                
                Rectangle()
                    .fill(Color.black)
                    .frame(width: UIScreen.main.bounds.width-27, height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(.white, lineWidth: 1.5))
                    .padding(.bottom, 15)
                
                VStack {
                    
                    Text("You are only able to click this button once every 24 hours. Come back on \(formatDateShortStyle(mapViewModel.comeBackTime)), to fetch a new set of users!")
                        .foregroundStyle(.white)
                        .lineSpacing(4)
                        .font(.custom("Minecraft", size: 19))
                        .padding([.leading, .trailing])
                        .multilineTextAlignment(.center)
                        .frame(width: UIScreen.main.bounds.width-20, height: 105)
                    
                    AcceptButton(buttonText: "OK", backgroundColor: .green, width: 120, textColor: .white)
                        .onTapGesture {
                            mapViewModel.show24HourWarningScreen = false
                        }
                    
                }
                
                
            }
            .frame(width: UIScreen.main.bounds.width-20, height: 160)
            
            
            Spacer()
        }
    }
}

#Preview {
    TwentyFourHoursView(mapViewModel: MapViewModel())
}

func formatDateShortStyle(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "M/d/yy @ h:mm a"
    return formatter.string(from: date)
}
