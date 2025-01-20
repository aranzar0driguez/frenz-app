//
//  mapView.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 10/14/24.
//

import SwiftUI
import MapKit

final class LocationBigMapViewModel : ObservableObject {
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D( latitude: 41.311180,
                                                                               longitude:-72.931630), span: MKCoordinateSpan(latitudeDelta: 0.017, longitudeDelta: 0.017))
}

@available(iOS 17.0, *)
var cameraPosition: MapCameraPosition {
    MapCameraPosition.region(MKCoordinateRegion(center: CLLocationCoordinate2DMake(41.311180, -72.931630), span: MKCoordinateSpan(latitudeDelta: 0.017, longitudeDelta: 0.017)))
}

struct mapView: View {
    
    @StateObject var locationMap = LocationBigMapViewModel()
    @ObservedObject var mapViewModel : MapViewModel
    
    @EnvironmentObject var allUsers :  AllOfUsers
    
    
    var body: some View {
        
        
        ZStack {
            if #available(iOS 17.0, *) {
                Map(position: .constant(cameraPosition), bounds: nil, interactionModes: .all, scope: nil) {
                    
                    ForEach(mapViewModel.clickedOnAdmirers == true ? allUsers.admirersMap : allUsers.friendsMap) { user in
                        
                        Annotation("", coordinate: CLLocationCoordinate2D(latitude: user.latitude, longitude: user.longitude)) {
                                                        
                                UserPinView(user: user, mapViewModel: mapViewModel, url: user.imagesURL[0])
                                
                                
                           
                        }
                        
                    }.annotationTitles(.hidden)
                    
                }
                .ignoresSafeArea(.all)
                .environment(\.colorScheme, .light)

                
                
            }
            else {
                //  OLDER VERSIONS OF IOS
                Map(coordinateRegion: $locationMap.region, annotationItems: mapViewModel.clickedOnAdmirers == false ? allUsers.friendsMap : allUsers.admirersMap) { user in
                    
                    MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: user.latitude, longitude: user.longitude)) {
                                                
                            
                            UserPinView(user: user, mapViewModel: mapViewModel, url: user.imagesURL[0])
                      
                        
                    }
                }
                .environment(\.colorScheme, .light)
                .ignoresSafeArea(.all)
            }
        }
        .sheet(isPresented: $mapViewModel.showCardViewSheet) {
        
            CardView(showAdmirersGifts: mapViewModel.clickedOnAdmirers, showGiftSendingOptions: true, user: mapViewModel.selectedUser ?? MockUser.fakeUser, updateCardView: true)
        }
        .blur(radius: mapViewModel.showCardViewSheet ? 6 : 0)
        
        
    }
}

#Preview {
    mapView(mapViewModel: MapViewModel())
}
