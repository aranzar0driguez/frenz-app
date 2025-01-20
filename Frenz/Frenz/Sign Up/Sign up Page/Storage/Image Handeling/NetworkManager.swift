//
//  NetworkManager.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 10/22/24.
//

import Foundation
import UIKit

final class NetworkManager {
    
    static let shared = NetworkManager()
    private let cache = NSCache<NSString, UIImage>()
    
    private init() { }

    func getImage(fromURLString urlString: String, completed: @escaping (UIImage?) -> Void) {
        
        //  Creates a document with a string
        let cacheKey = NSString(string: urlString)
        
        //  if it is able to create an image (meaning it's already in the cache key, it goes ahead and returns a completed image)
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }
        
        //  Converts the string into a URL
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        
        //  Downloads the image and converts it into data
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            
            //  Attempts to create data and then creates an image with that data
            guard let data = data, let image = UIImage(data: data) else {
                completed(nil)
                return
            }
            
            //  Adds both the key and the string to the cache
            self.cache.setObject(image, forKey: cacheKey)
            completed(image)
        }
        
        task.resume()
    }
    
}
