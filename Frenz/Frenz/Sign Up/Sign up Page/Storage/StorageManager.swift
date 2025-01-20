//
//  StorageManager.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 10/19/24.
//

import Foundation
import FirebaseStorage

final class StorageManager {
    
    static let shared = StorageManager()
    private init() { }
    
    private let storage = Storage.storage().reference()
    
    private func userReference(userEmail: String) -> StorageReference {
        storage.child(userEmail)
    }
    
    func getData(userEmail: String, path: String) async throws -> Data{
        
        let data = try await storage.child(path).data(maxSize: 3 * 1024 * 1024)
                
        return data
    }
    
    func getPathForImage(path: String) -> StorageReference {
        Storage.storage().reference(withPath: path)
        
    }
    
    func saveImage(data: Data, userEmail: String) async throws -> (path: String, name: String){
        do {
                let meta = StorageMetadata()
                
                meta.contentType = "image/jpeg"

                let path = "\(UUID().uuidString).jpeg"
                
                let returnedMetaData = try await userReference(userEmail: userEmail).child(path).putDataAsync(data, metadata: meta)
                
                guard let returnedImagePath = returnedMetaData.path, let returnedImageName = returnedMetaData.name else {
                    throw URLError(.badServerResponse)
                }
                
                return (returnedImagePath, returnedImageName)
            
            } catch {
                print("Error in saveImage: \(error)")
                throw error
            }
    }
    
    func deleteImage(path: String) async throws{
        
        try await getPathForImage(path: path).delete()
        
    }
    
    //  Will help us gain access to the 
    func returnURLForImage(path: String) async throws -> URL {
        
        let url = try await Storage.storage().reference(withPath: path).downloadURL()
        
        return url
        
    }

    
}
