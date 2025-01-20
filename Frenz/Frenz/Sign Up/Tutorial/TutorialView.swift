//
//  TutorialView.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 10/17/24.
//

import SwiftUI

struct TutorialView: View {
    var body: some View {
        
        ZStack {
            
            Color.black.edgesIgnoringSafeArea(.all)

            
            TabView {
                
                
                TutorialP1View()
                
                TutorialP2View()
                
                TutorialP3View()
                
            }.tabViewStyle(.page(indexDisplayMode: .always))
                .indexViewStyle(.page(backgroundDisplayMode: .always))
        }
    }
}

#Preview {
    TutorialView()
}
