//
//  OnBoardingView.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 10/16/24.
//

import SwiftUI

struct OnBoardingView: View {
    
    //  Lets us know whi
    @State var onBoardingPage: Int = 0
    @StateObject var signUpVM = SignUpViewModel()
    var userEmail: String
    var universityID: String
        
    let transition: AnyTransition = .asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading))
    
    
    var body: some View {
        
        ZStack {
            
            Color.black.edgesIgnoringSafeArea(.all)
            
            //  Content
            switch onBoardingPage {
                
            case 0: // First and Last Name
                SignUpP1View(signUpPageIndex: $onBoardingPage, signUpVM: signUpVM, universityID: universityID, userEmail: userEmail)
                    .transition(transition)
                
            case 1: //  Birthday
                SignUpP2View(signUpPageIndex: $onBoardingPage, signUpVM: signUpVM)
                    .transition(transition)
                
            case 2:
                whatIsYourSexView(updatingProfile: false, signUpPageIndex: $onBoardingPage, signUpVM: signUpVM)
                    .transition(transition)

            case 3: //  Interests
                SignUpP3View(updatingProfile: false, signUpPageIndex: $onBoardingPage, signUpVM: signUpVM)
                    .transition(transition)

            case 4: // Major
                SignUpP4View(updatingProfile: false, signUpPageIndex: $onBoardingPage, signUpVM: signUpVM)
                    .transition(transition)
                
            case 5:  //  Resco
                universityCustomOptionsView( updatingProfile: false, signUpPageIndex: $onBoardingPage, signUpVM: signUpVM)
                    .transition(transition)
                
            case 6:
                whatAreYouInterestedInView(updatingProfile: false, signUpPageIndex: $onBoardingPage, signUpVM: signUpVM)
                    .transition(transition)
               
            case 7:
                whatAreYouAttractedToView(updatingProfile: false, signUpPageIndex: $onBoardingPage, signUpVM: signUpVM)
                    .transition(transition)
            
            case 8:
                whatAreYouLookingFor(updatingProfile: false, signUpPageIndex: $onBoardingPage, signUpVM: signUpVM)
                    .transition(transition)
            
                //  Future admirers bio
            case 9:
                SignUpP5View(updatingProfile: false, signUpPageIndex: $onBoardingPage, signUpVM: signUpVM)
                    .transition(transition)
               
                //  Future friends bio
            case 10:
                SignUpP6View(updatingProfile: false, signUpPageIndex: $onBoardingPage, signUpVM: signUpVM)
                    .transition(transition)

            case 11:
                selectPicturePromptsView(signUpPageIndex: $onBoardingPage, signUpVM: signUpVM, updatingProfile: false)
                    .transition(transition)
                
            case 12:
                selectImagesView(updatingProfile: false, signUpPageIndex: $onBoardingPage, signUpVM: signUpVM)
                    .transition(transition)
                
            case 13:
                selectWrittenPrompts(signUpPageIndex: $onBoardingPage, signUpVM: signUpVM, updatingProfile: false)
                    .transition(transition)
    
            case 14:
                completeWrittenPromptsView(signUpPageIndex: $onBoardingPage, signUpVM: signUpVM, updatingProfile: false)
                    .transition(transition)
              
            case 15:
                MapLocationView(updatingProfile: false, signUpPageIndex: $onBoardingPage, signUpVM: signUpVM)
                    .transition(transition)

            default:
                Text("Error")
                
            }
            
            
        }
        
    }
}

#Preview {
    OnBoardingView(userEmail: "", universityID: "")
}


