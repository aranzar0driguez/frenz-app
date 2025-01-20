//
//  CardView.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 10/14/24.
//

import Foundation
import SwiftUI

//  This is what the user when they click on a profile

struct CardView: View {
    
    @StateObject var cardViewModel = CardViewModel()
    @StateObject var fetchUsersVM : FetchUsersViewModel
    @EnvironmentObject var allUsers : AllOfUsers
    

    @State var isLoading = true
    var showAdmirersGifts: Bool?
    var showGiftSendingOptions: Bool
    var user: user
    var updateCardView: Bool
    
    // Initialize the ViewModel
    init(showAdmirersGifts: Bool?, showGiftSendingOptions: Bool, user: user, updateCardView: Bool) {
        self.showAdmirersGifts = showAdmirersGifts
        self.showGiftSendingOptions = showGiftSendingOptions
        self.user = user
        self.updateCardView = updateCardView
        _fetchUsersVM = StateObject(wrappedValue: FetchUsersViewModel(user: user))
    }
    
    var body: some View {
            
        ZStack {
            
            Color.black.edgesIgnoringSafeArea(.all)
            
            if isLoading {
                Spacer()
                
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(2)
                    .frame(maxWidth: 120, maxHeight: 30)
                
                Spacer()
                
            } else if cardViewModel.thisUserNoLongerExists == false{
                
                ScrollView {
                    
                    MainCardPictureView(user: fetchUsersVM.otherUser)
                        .frame(height: UIScreen.main.bounds.height/1.4)
                        .padding(.bottom, 10)
                    
                    
                    VStack (alignment: .leading) {
                        
                        
                        //Bio about themselves
                        
                        VStack (alignment: .leading) {
                            if let showAdmirerBio = showAdmirersGifts {
                                Text(showAdmirerBio ? "\(fetchUsersVM.otherUser.admirerBio)" : "\(fetchUsersVM.otherUser.friendBio)")
                                    .font(.custom("Minecraft", size: 16))
                                    .padding(.top, 12)
                                    .padding(.bottom, 30)
                            } else {
                                Text("\(fetchUsersVM.otherUser.friendBio)")
                                    .font(.custom("Minecraft", size: 16))
                                    .padding(.top, 12)
                                    .padding(.bottom, 30)
                            }
                            
                            
                            InterestsWrappingStackView(user: fetchUsersVM.otherUser)
                                .padding(.bottom, 10)
                            
                            if let showAdmirerBio = showAdmirersGifts {
                                LookingForView(user: fetchUsersVM.otherUser, showingAdmirers: showAdmirerBio)
                            } else {
                                LookingForView(user: fetchUsersVM.otherUser, showingAdmirers: false)
                            }
                            
                        }
                        .foregroundColor(.white)
                        
                    }
                    .padding([.leading, .trailing], 15)
                    .frame(maxWidth: UIScreen.main.bounds.width, alignment: .leading)
                    
                    //  If the user has at least 1 picture prompt (not counting the pfp one)
                    if fetchUsersVM.otherUser.selectedPicturePrompts.count > 1 {
                        ForEach (1..<(fetchUsersVM.otherUser.selectedPicturePrompts.count)) { i in
                            
                            ImageWithPromptView(prompt: fetchUsersVM.otherUser.selectedPicturePrompts[i], url: fetchUsersVM.otherUser.imagesURL[i])
                                .padding(.bottom, 20)
                            
                            if i-1 >= 0 && i-1 < fetchUsersVM.otherUser.selectedWrittenPrompts.count {
                                TextPromptView(prompt: fetchUsersVM.otherUser.selectedWrittenPrompts[i-1], userResponse: fetchUsersVM.otherUser.answeredWrittenPrompts[i-1])
                                    .padding([.top, .bottom], 20)
                            }
                        }
                    }
                    
                    if showGiftSendingOptions {
                        
                        HStack {
                            
                            Button {
                                guard let romanticGift = showAdmirersGifts else { return }
                                
                                cardViewModel.showRomanticGifts = romanticGift
                                
                                cardViewModel.showGiftOptions.toggle()
                            } label : {
                                AcceptButton(buttonText: "Send a gift!", backgroundColor: .green, width: 170)
                            }
                            
//                            Button {
//                                cardViewModel.showGiftOptions.toggle()
//                            } label : {
//                                AcceptButton(buttonText: "Mmm...not now", backgroundColor: .red, width: 170)
//                            }
                        }
                    }
                    
                    Spacer()
                        .frame(height: 60)
                    
                }
            }
            else {
                
                Text("This user no longer exists : {")
                    .font(.custom("Minecraft", size: 18))
                    .multilineTextAlignment(.center)
                
                
            }
        }
            .sheet(isPresented:
                    
                    $cardViewModel.showGiftOptions, content: {
                GiftsOptionsView(cardViewModel: cardViewModel, showAdmirersGifts: showAdmirersGifts ?? true, user: fetchUsersVM.otherUser)
                    .presentationDetents([.fraction(0.4)])
                
            })
            .blur(radius: cardViewModel.showGiftOptions ? 10 : 0)
            .ignoresSafeArea()
            .background(.black)
            
        //  UNDO THIS COMMENTING !!
            .onAppear {
                
                if updateCardView {
                    Task {
                        //  Fetches the most recent version of the user
                        guard let u = await fetchUsersVM.fetchUser() else {
                            cardViewModel.thisUserNoLongerExists = true
                            isLoading = false

                            return
                        }
                        
                        //  Updates the environment variable (not the backend)
                        allUsers.updateNewUserValue(updatedUser: u)
                        
                        isLoading = false
                    }
                    
                } else {
                    fetchUsersVM.otherUser = self.user
                    isLoading = false
                }
            }
    }
}


#Preview {
    CardView(showAdmirersGifts: false, showGiftSendingOptions: true, user: MockUser.fakeUser, updateCardView: false)
}
