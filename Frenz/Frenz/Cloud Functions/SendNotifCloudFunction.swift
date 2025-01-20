//
//  SendNotifCloudFunction.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 11/27/24.
//

import Foundation
import FirebaseAuth

class SendNotifCloudFunction: ObservableObject {
    
    
    static let shared = SendNotifCloudFunction()

    
    func sendNotif(fcmToken: [String], title: String, message: String) async {
        
        do {
            
            let sendNotifURL: String = try Configuration.value(for: "SEND_NOTIF_FUNC")

            guard let user = Auth.auth().currentUser else {
                print("No user currently signed in")
                return
            }
            
            guard let token = try? await user.getIDToken() else {
                print("Error retrieving the ID token")
                return
            }
            //  Uncomment this to view the firebase auth key of the user signed in
            //        print("The user's token is:  \(token)")
            
            guard let url = URL(string: "https://\(sendNotifURL)") else {
                print("There was an error retrieving the function's URL")
                return
            }
            
            var request = URLRequest(url: url)
            
            //  Tells the server that the client intends to send data to the end point
            request.httpMethod = "POST"
            
            //  The value that is being set for the header field + request body will be formatted as JSON
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            //  Set the Authorization header w/ the bearer token
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            
            let parameters = [
                "fcmToken" : fcmToken,
                "title" : title,
                "body" : message
            ] as [String : Any]
            
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
            
            do {
                let (data, response) =  try await URLSession.shared.data(for: request)
                
                if let responseString = String(data: data, encoding: .utf8) {
                    print("RAW RESPONSE: \(responseString)")
                }
                
                guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                        
                else {
                    throw NSError(domain: "JSONError", code: 0, userInfo: [NSLocalizedDescriptionKey : "Invalid JSON Response"])
                }
                
                print("Message was successfully sent!")
                
            } catch {
                print("Error: \(error)")
            }
            
        } catch {
            print(error)
        }
        
    }
}
