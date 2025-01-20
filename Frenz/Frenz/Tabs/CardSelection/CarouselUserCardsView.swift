//
//  CarouselUserCardsView.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 11/24/24.
//

import SwiftUI

struct CarouselUserCardsView: View {
    @State private var currentIndex: Int = 0
    @State private var dragOffset: CGFloat = 0
    
    @ObservedObject var carouselUserVM : MapViewModel
    
    var users: [user]
    let screenOffSet = UIScreen.main.bounds.width/1.35
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            
            VStack {
                
                ZStack {
                    
                    ForEach(users, id:\ user.id) { user in
                        
                        
                        
                        if let index = users.firstIndex(of: user) {
                            LargeCardView(user: user, carouselUserVM: carouselUserVM)
                                .contentShape(Rectangle())
                            //                                            .border(Color.red) // For debugging hit areas
                                .scaleEffect(currentIndex == index ? 1.0 : 0.7)
                                .offset(x: CGFloat(index - currentIndex) * screenOffSet + dragOffset)
                                .animation(.interpolatingSpring(stiffness: 300, damping: 50), value: dragOffset)
                                .padding(.top, 30)
                                
                            
                        }
                    }
                    
                }
                .gesture (
                    DragGesture()
                        .onChanged { gesture in
                            dragOffset = gesture.translation.width
                        }
                        .onEnded { value in
                            let threshold: CGFloat = 50
                            
                            if value.translation.width > threshold {
                                
                                withAnimation {
                                    currentIndex = max(0, currentIndex - 1)
                                }
                            } else if value.translation.width < -threshold {
                                withAnimation {
                                    var secondParam = currentIndex + 1
                                    
                                    currentIndex = min(users.count - 1, currentIndex + 1)
                                }
                            }
                            
                            dragOffset = 0
                            
                        })
            }
            
            
            
        }
        
        
        
    }
    
    
}

#Preview {
    CarouselUserCardsView(carouselUserVM: MapViewModel(), users: MockUser.fakeUsers)
}


