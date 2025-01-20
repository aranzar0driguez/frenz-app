//
//  ImageLoader.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 10/22/24.
//

import Foundation
import SwiftUI

final class ImageLoader: ObservableObject {
    
    @Published var image: Image? = nil
    
    func loadImage(fromURLString urlString: String) {
        
        NetworkManager.shared.getImage(fromURLString: urlString) { uiImage in
            
            guard let uiImage = uiImage else { return }
            
            DispatchQueue.main.async {
                self.image = Image(uiImage: uiImage)
            }
            
        }
        
    }
    
}

struct RemoteImage: View {
    var image: Image?
    
    var body: some View {
        
        image?.resizable() ?? Image(.no)
        
    }
    
    
}

struct EventRemoteImage: View {
    
    @StateObject var imageLoader = ImageLoader()
    let urlString: URL

    var body: some View {
        
        RemoteImage(image: imageLoader.image)
            .onAppear{
                imageLoader.loadImage(fromURLString: urlString.absoluteString)
            }
        
    }
    
}
