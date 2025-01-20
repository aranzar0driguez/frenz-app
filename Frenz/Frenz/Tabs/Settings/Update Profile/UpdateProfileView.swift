//
//  UpdateProfileView.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 11/19/24.
//

import SwiftUI

struct UpdateProfileView: View {
    
    var user: user
    @StateObject var viewModel = SignUpViewModel()
    @State var updateProfilePage: Int = 0
    @EnvironmentObject var pViewModel : ProfileViewModel
    
    @State var navPath = NavigationPath()
    
    let transition: AnyTransition = .asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading))
    
    
    var body: some View {
        
        
            ZStack {
                
                Color.black.edgesIgnoringSafeArea(.all)
         
                VStack {
                    
                    SettingsHeaderView(user: viewModel.appUser, imagesURL: user.imagesURL[0], updatingProfile: true)

                    
                    Form {
                        
                        Section(header:
                                    Text("Biography")
                            .font(.custom("Minecraft", size: 12))
                            .foregroundStyle(.white)
                        ) {
                            
                            NavigationLink {
                                
                                SignUpP5View(updatingProfile: true, userEmail: user.email, signUpPageIndex: .constant(0), signUpVM: viewModel)
                                
                            } label: {
                                Text("Admirer Bio")
                                    .foregroundStyle(.white)
                                    .font(.custom("Minecraft", size: 15))
                            }
                            
                            NavigationLink {
                                
                                SignUpP6View(updatingProfile: true, userEmail: user.email, signUpPageIndex: .constant(0), signUpVM: viewModel)
                                
                            } label: {
                                Text("Friends Bio")
                                    .foregroundStyle(.white)
                                    .font(.custom("Minecraft", size: 15))
                            }
                            
                        }
                        
                        Section(header:
                                    Text("Personal Interests")
                            .font(.custom("Minecraft", size: 12))
                            .foregroundStyle(.white)
                        ) {
                            
                            
                            NavigationLink {
                                
                                SignUpP3View(updatingProfile: true, userEmail: user.email, signUpPageIndex: .constant(0), signUpVM: viewModel)
                                
                            } label: {
                                Text("Interests")
                                    .foregroundStyle(.white)
                                    .font(.custom("Minecraft", size: 15))
                            }
                            
                            NavigationLink {
                                SignUpP4View(updatingProfile: true, userEmail: user.email, signUpPageIndex: .constant(0), signUpVM: viewModel)
                            } label: {
                                Text("Major")
                                    .foregroundStyle(.white)
                                    .font(.custom("Minecraft", size: 15))
                            }
                            
                            NavigationLink {
                                universityCustomOptionsView(updatingProfile: true, userEmail: user.email, signUpPageIndex: .constant(0), signUpVM: viewModel)
                                
                            } label : {
                                Text("Residential College")
                                    .foregroundStyle(.white)
                                    .font(.custom("Minecraft", size: 15))
                            }
                            
                            NavigationLink {
                                whatIsYourSexView(updatingProfile: true, userEmail: user.email, signUpPageIndex: .constant(0), signUpVM: viewModel)
                                
                            } label : {
                                Text("Sex")
                                    .foregroundStyle(.white)
                                    .font(.custom("Minecraft", size: 15))
                            }
                            
                            NavigationLink {
                                
                                whatAreYouAttractedToView(updatingProfile: true, userEmail: user.email, signUpPageIndex: .constant(0), signUpVM: viewModel)
                                
                            } label: {
                                Text("Sexuality")
                                    .foregroundStyle(.white)
                                    .font(.custom("Minecraft", size: 15))
                            }
                            
                            //   When they change this, they will no longer be able to see their matches
                            
                            NavigationLink {
                                
                                whatAreYouInterestedInView(updatingProfile: true, userEmail: user.email, signUpPageIndex: .constant(0), signUpVM: viewModel)
                                
                            } label: {
                                Text("Admirers & Friends")
                                    .foregroundStyle(.white)
                                    .font(.custom("Minecraft", size: 15))
                            }
                            
                            NavigationLink {
                                whatAreYouLookingFor(updatingProfile: true, userEmail: user.email, signUpPageIndex: .constant(0), signUpVM: viewModel)
                            } label: {
                                Text("Looking For")
                                    .foregroundStyle(.white)
                                    .font(.custom("Minecraft", size: 15))
                            }
                            
                        }
                        
                        Section(header:
                                    Text("Images & Prompts")
                            .font(.custom("Minecraft", size: 12))
                            .foregroundStyle(.white)
                        ) {
                            
                            NavigationLink {
                                
                                selectPicturePromptsView(signUpPageIndex: $updateProfilePage, signUpVM: viewModel, updatingProfile: true, userEmail: user.email)
                                
                                //  Image prompts >> selection of images
                            } label: {
                                Text("Images & Image Prompts")
                                    .foregroundStyle(.white)
                                    .font(.custom("Minecraft", size: 15))
                            }
                            
                            
                            NavigationLink {
                                selectWrittenPrompts(signUpPageIndex: .constant(0), signUpVM: viewModel, updatingProfile: true, userEmail: user.email)
                            } label : {
                                Text("Written Prompts")
                                    .foregroundStyle(.white)
                                    .font(.custom("Minecraft", size: 15))
                            }
                            
                        }
                        
                        Section(header:
                                    Text("Map")
                            .font(.custom("Minecraft", size: 12))
                            .foregroundStyle(.white)
                        ) {
                            NavigationLink {
                                MapLocationView(updatingProfile: true, userEmail: user.email, signUpPageIndex: .constant(0), signUpVM: viewModel)
                            } label: {
                                Text("Map Placement")
                                    .foregroundStyle(.white)
                                    .font(.custom("Minecraft", size: 15))
                            }
                            
                        }
                        
                        //  Images prompts > Images
                        //  Written Prompts (needs to be one less than # of images
                    }
                    .environment(\.colorScheme, .dark)
                    
                    
                }
                
                
                
            }

        
        .onAppear {
            //  Fetch the user (will update it when changes are made)
            
            Task {
                
                // Make sure to uncomment this
                try await pViewModel.loadCurrentUser()
                guard let currentUser = pViewModel.user else { return }
                
                viewModel.appUser = currentUser
            }
            
            
            //  Resets back to 1 to avoid extra items in array
            
            viewModel.selectedImages = [UIImage(resource: .no)]
            viewModel.photoPickerItems = [nil]
            
            for i in 0..<(user.imagesURL.count) {
                
                viewModel.selectedImages.append(UIImage(resource: .no))
                viewModel.photoPickerItems.append(nil)
                
            }
                        
        }
    }
}

#Preview {
    UpdateProfileView(user: MockUser.fakeUser)
}
