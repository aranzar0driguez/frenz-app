//
//  GetRandomUsersCloudFunction.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 11/24/24.
//

import Foundation
import FirebaseFunctions

class GetRandomUsersCloudFunction: ObservableObject {
    
    
    func getRandomUsers(userEmail: String, userGender: String, userSexuality: String, fetchRomanticUsers: Bool) async -> [String]? {
        do {
            
            let getRandomUsersURL: String = try Configuration.value(for: "GET_RANDOM_USERS_FUNC")
            print("The config file URL: \(getRandomUsersURL)")
            
            guard let url = URL(string: "https://\(getRandomUsersURL)") else {
                print("There was an error retrieving the price")
                return nil
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let parameters = [
                "userEmail" : userEmail,
                "userGender" : userGender,
                "userSexuality" : userSexuality,
                "fetchRomanticUsers" : fetchRomanticUsers] as [String : Any]
            
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
            
            do {
                let (data, response) = try await URLSession.shared.data(for: request)
                
                guard let json = try? JSONSerialization.jsonObject(with: data, options:[]) as? [String: Any],
                      let emails = json["useremails"] as? [String]
                else {
                    throw NSError(domain: "JSONError", code: 0, userInfo: [NSLocalizedDescriptionKey : "Invalid JSON Response"])
                }
                print(emails)
                return emails
            } catch {
                
                print("there was an error fetching users")
                
            }
            
        } catch { 
            print(error)
        }
        return nil
    }
    
}
