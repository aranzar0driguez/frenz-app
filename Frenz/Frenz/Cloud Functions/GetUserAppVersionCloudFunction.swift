//
//  GetUserAppVersionCloudFunction.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 12/2/24.
//

import Foundation
import FirebaseFunctions

class GetUserAppVersionCloudFunction: ObservableObject {
    
    
    func getUserAppVersion() async -> (mainMessage: String, showMainWarningScreen: Bool, subMessage: String, showSubWarningScreen: Bool)? {

        do {
            let getAppVersionURL: String = try Configuration.value(for: "GET_USER_APP_VERSION_FUNC")
            
            
            let appVersion = Double(Bundle.main.appVersionLong)
            
            guard let url = URL(string: "https://\(getAppVersionURL)") else {
                print("There was an error retrieving the user's current app version")
                return nil
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let parameters = [
                "userAppVersion" : appVersion
            ] as [String : Any]
            
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
            
            do {
                
                let (data, response) = try await URLSession.shared.data(for: request)
                
                guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                      let showMainWarningScreen = json["showMainFullScreen"] as? Bool,
                      let showSubWarningScreen = json["showSubWarningScreen"] as? Bool,
                      let mainMessage = json["mainMessage"] as? String,
                      let subMessage = json["subMessage"] as? String
                        
                        
                else {
                    throw NSError(domain: "JSONError", code: 0, userInfo: [NSLocalizedDescriptionKey : "Invalid JSON Response"])
                }
                
                print("Show full screen?: \(showMainWarningScreen)\nThe warning main message: \(mainMessage)")
                print("Show sub screen?: \(showSubWarningScreen)\nThe warning main message: \(subMessage)")
                
                
                return (mainMessage : mainMessage, showMainWarningScreen: showMainWarningScreen, subMessage: subMessage, showSubWarningScreen: showSubWarningScreen)
                
            } catch {
                print("There was an error fetching the user's app version")
            }
        } catch {
            print(error)
        }
        return nil
        
    }
    
}
