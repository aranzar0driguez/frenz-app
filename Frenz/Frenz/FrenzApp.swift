//
//  FrenzApp.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 10/14/24.
//

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseMessaging


@main
struct FrenzApp: App {
    
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @AppStorage("signed_in") var currentUserSignedIn: Bool?
    
    var body: some Scene {
        WindowGroup {
            
            RootView()
                .preferredColorScheme(.dark)
        }
    }
}


class AppDelegate: NSObject, UIApplicationDelegate {
    
    
    
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    
      FirebaseApp.configure()
     
            
      //    Setting up permissions to send notifications
      UNUserNotificationCenter.current().delegate = self

      let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
      UNUserNotificationCenter.current().requestAuthorization(
        options: authOptions,
        completionHandler: { _, _ in }
      )

      application.registerForRemoteNotifications()
      
      //    To receive registration tokens
      Messaging.messaging().delegate = self

      
      print("Configured Firebase")


    return true
  }
    // This manually links the APNs token to Firebase's FCM token + is needed for swift apps
      func application(_ application: UIApplication,
                       didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
          // Map the APNs token to Firebase
          Messaging.messaging().apnsToken = deviceToken
          print("APNs device token mapped to FCM.")
      }
   
}

//  Handles alert notifications
extension AppDelegate: UNUserNotificationCenterDelegate {
  // Receive displayed notifications for iOS 10 devices.
  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              willPresent notification: UNNotification) async
    
    //  Presents a notification whenever we get a notification from our firebase server ^^
    
    -> UNNotificationPresentationOptions {
    let userInfo = notification.request.content.userInfo
        
    //  Gets notification contents ^^

    // With swizzling disabled you must let Messaging know about the message, for Analytics
    // Messaging.messaging().appDidReceiveMessage(userInfo)

    // ...

    // Print full message.
    print(userInfo)

    // Change this to your preferred presentation option
        
//    return [[.alert, .sound]]
    return []

  }

  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              didReceive response: UNNotificationResponse) async {
    let userInfo = response.notification.request.content.userInfo

    // ...

    // With swizzling disabled you must let Messaging know about the message, for Analytics
    // Messaging.messaging().appDidReceiveMessage(userInfo)

    // Print full message.
    print(userInfo)
  }
    
    //  Silent notifications
    
    func application(_ application: UIApplication,
                     didReceiveRemoteNotification userInfo: [AnyHashable: Any]) async
      -> UIBackgroundFetchResult {
      // If you are receiving a notification message while your app is in the background,
      // this callback will not be fired till the user taps on the notification launching the application.
      // TODO: Handle data of notification

      // With swizzling disabled you must let Messaging know about the message, for Analytics
      // Messaging.messaging().appDidReceiveMessage(userInfo)

      // Print message ID.
      

      // Print full message.
      print(userInfo)

      return UIBackgroundFetchResult.newData
    }
}

//
extension AppDelegate: MessagingDelegate {
 
    //  Sends notification whenever the token is updated + this is called when a notification needs to be created
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        //  fcmToken won't change very often but it's used to identify the device it is running on to send message
//        print("Firebase registration token: \(String(describing: fcmToken))")
        
        KeychainHelper.shared.save(key: "fcmToken", value: fcmToken ?? "")

      let dataDict: [String: String] = ["token": fcmToken ?? ""]
      NotificationCenter.default.post(
        name: Notification.Name("FCMToken"),
        object: nil,
        userInfo: dataDict
      )
      // TODO: If necessary send token to application server.
      // Note: This callback is fired at each app startup and whenever a new token is generated.
                
    }
    
}

extension Bundle {
    public var appName: String           { getInfo("CFBundleName") }
    public var displayName: String       { getInfo("CFBundleDisplayName") }
    public var language: String          { getInfo("CFBundleDevelopmentRegion") }
    public var identifier: String        { getInfo("CFBundleIdentifier") }
    public var copyright: String         { getInfo("NSHumanReadableCopyright").replacingOccurrences(of: "\\\\n", with: "\n") }
    
    public var appBuild: String          { getInfo("CFBundleVersion") }
    public var appVersionLong: String    { getInfo("CFBundleShortVersionString") }
    //public var appVersionShort: String { getInfo("CFBundleShortVersion") }
    
    fileprivate func getInfo(_ str: String) -> String { infoDictionary?[str] as? String ?? "⚠️" }
}
