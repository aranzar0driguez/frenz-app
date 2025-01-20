//
//  SignUpP3View.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 10/16/24.
//

import SwiftUI
import WrappingHStack

struct SignUpP3View: View {
    
    //  Gives us access to our interests
    @EnvironmentObject var universityEO: UniversityViewModel

    var updatingProfile: Bool
    var userEmail: String?
    
    let colors: [Color] = [
        .yellow,
        .orange,
        .pink,
        .red,
        .purple,
        .green,
        .teal,
        .blue,
        .cyan
    ]
    
    @Binding var signUpPageIndex: Int
    @ObservedObject var signUpVM : SignUpViewModel
    @State var successfulUpdate = false

    
    var body: some View {
        
        ZStack (alignment: .bottom){
            
            //  Black background
            Color.black.edgesIgnoringSafeArea(.all)
            
            
            if !updatingProfile {
                BackArrowButton(numOfPagesToGoBack: 1, signUpPageIndex: $signUpPageIndex, topPadding: 30, leadingPadding: 15)
            }
            
            VStack {
                
                Text("Select 2 - 6 interests")
                    .foregroundStyle(.white)
                    .font(.custom("Minecraft", size: 23))
                    .padding(.bottom, 20)
                
                if successfulUpdate {
                    Text("Your profile has been successfully updated!")
                        .foregroundStyle(.red)
                        .font(.custom("Minecraft", size: 20))
                        .padding(.bottom, 20)
                }
                
                VStack (alignment: .leading){
                    
                    // Displays each of the interests based on section
                    ScrollView {
                        /*Yale.yaleUniversity.interests*/
                        if let interests = universityEO.university?.interests {
                            ForEach(Array(zip(interests, colors.cycled())), id: \.0.interestType) { (interest, color) in
                                interestsSection(header: interest.interestType, color: color, interests: interest.interests, selectedInterests: $signUpVM.appUser.interests)
                                    .padding(.bottom, 10)
                            }
                        }
                    }
                    .padding(.bottom, 60)
                    
                }
                .frame(width: UIScreen.main.bounds.width - 15, alignment: .leading)
                
               
                
            }
            Spacer()
            
            //  Bottom button
            
                        NextButtonBottom (action: {
                            
                            if updatingProfile {
                                Task {
                                    guard let email = userEmail else {
                                        return
                                    }
                                    
                                    try await UserManager.shared.updateUserField(userEmail: email, signUpVM.appUser.interests, codingKeyRawValue: user.CodingKeys.interests.rawValue)
                                    
                                    successfulUpdate = true
                                }
                                
                            }
            
                            withAnimation(.spring()) {
                                signUpPageIndex += 1
                            }
                        }, disabled: signUpVM.appUser.interests.count < 2 || signUpVM.appUser.interests.count > 6, updatingProfile: updatingProfile)
            
            
          
        }
    }
}

#Preview {
    SignUpP3View(updatingProfile: false, signUpPageIndex: .constant(2), signUpVM: SignUpViewModel())
}

struct interestsSection: View {
    
    var header: String
    var color: Color
    var interests: [String]
    @Binding var selectedInterests: [String]
    
    
    var body: some View {
        
        
        VStack (alignment: .leading){
            
            
            Text("\(header)")
                .font(.custom("Minecraft", size: 21))
                .foregroundStyle(.white)
            
            WrappingHStack(interests, spacing: WrappingHStack.Spacing.constant(10)) { interest in
                
                //  Adds/removes the interest depending on whether the user had previously clicked on it
                Button {
                    
                    if selectedInterests.contains(interest) {
                        if let index = selectedInterests.firstIndex(of: interest) {
                            selectedInterests.remove(at: index)
                        }
                    }
                    else {
                        selectedInterests.append(interest)
                    }
                    
                } label : {
                    BubbleButtonTapped(buttonText: interest, isSelected: selectedInterests.contains(interest), color: color)
                        .padding([.bottom, .top], 4)
                    
                }
                
            }
            
        }
        
    }
}

extension Sequence {
    func cycled() -> AnySequence<Element> {
        return AnySequence { () -> AnyIterator<Element> in
            var iterator = self.makeIterator()
            return AnyIterator {
                if let next = iterator.next() {
                    return next
                } else {
                    iterator = self.makeIterator()
                    return iterator.next()
                }
            }
        }
    }
}
