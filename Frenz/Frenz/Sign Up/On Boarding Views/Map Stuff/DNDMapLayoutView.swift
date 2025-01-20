//
//  DNDMapLayoutView.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 11/19/24.
//

import SwiftUI
import MapKit

struct DNDMapLayoutView: UIViewRepresentable {
    
    @Binding var centerCoordinate: CLLocationCoordinate2D
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: UIViewRepresentableContext<DNDMapLayoutView>) -> MKMapView {
        
        
        let coordinate = CLLocationCoordinate2D(latitude: 41.311138, longitude: -72.928108)
        
        let map = MKMapView()
        map.region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        map.delegate = context.coordinator
        
        
        return map
        
    }
    //  Does nothing
    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<DNDMapLayoutView>) {
    }
}


class Coordinator : NSObject, MKMapViewDelegate {
    var parent : DNDMapLayoutView
    
    //  This is the initializer of the Coordinator class
    init(_ mViewParent : DNDMapLayoutView) {
        self.parent = mViewParent
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        parent.centerCoordinate = mapView.centerCoordinate
    }
}


