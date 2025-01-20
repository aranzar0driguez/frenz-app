# Frenz - Cloud Functions 
This script utilizes the Express framework and Firebase Cloud functions to define endpoints that perform various operations, such as sending push notifications, checking app version compatibility, and fetching random users based on specific criteria. 


Please read on for more detailed information regarding each request. 

## Usage
To execute the code, make sure you are in the functions folder. To test each function locally before deployment, start the emulator by running the following command:
```bash
npm run dev
```
If the emulator has been successfully started, you should see three different URL endpoints for each of the aforementioned http functions. They should have the following structure.
```bash
✔  functions[us-central1-sendNotif]: http function initialized (http://127.0.0.1:5002/frenz-21ae2/us-central1/functionName).
```
To test each request, copy and paste the endpoint URL on postman. 

### sendNotif function
This HTTP request allows push notifications to be sent to a target device, and it requires the following parameters:

- **Firebase Authentication Token (FAT)**: Obtainable by running the Frenz app and using the provided Swift code snippet (see below).
- **FCM Token (fcmToken)**: Used for identifying the recipient device.
- **Message Title**: The title of the notification.
- **Message Body**: The content of the notification.

The FAT must be included in the request headers with the key set to "Authorization" and the value formatted as:
```bash
Bearer YOUR_FIREBASE_AUTH_TOKEN
```
The fcmToken can be accessed in Swift via the following code:
```swift
KeychainHelper.shared.save(key: "fcmToken", value: fcmToken ?? "")
```

### getUserAppVersion function
This HTTP request obtains the user's current app version and showcases a warning screen on the user's screen if needed. The following parameter is required:
- **userAppVersion**: user's app version (ex: 1.0.0)

### getRandomUsers function
This HTTP request obtains a random set of users depending on the user's preferences. It takes the following parameters:
- **userEmail**: User's email
- **userGender**: User's sex ("female" or "male)
- **userSexuality**: Sex user is attracted to ("Females", "Males", or "Both")
- **fetchRomanticUsers**: A boolean value that indicates whether the set of users to obtain are friends or admirers (bool)

## Function Deployment
Once a function is ready for deployment, run the following command:
```
firebase deploy --only functions:insertfunctionname
```
## Support

If you need additional help and/or would like to access the service Account Key, please contact me at: rodriguez.aranza.9801@gmail.com.


### Firebase Permission Issues
If you are experiencing Firebase permission issues when running this script, this means that the security rules must be changed. Currently, the rules are set so that the "university" collection can only be read. To change this, go to Cloud Firestore > Rules > and replace the following:

```
    match /universities/{document=**} {
    	
      allow read: if request.auth != null && 
      hasAllowedDomainOrException(request.auth.token.email);
      
    }
```
to this: 

```
    match /universities/{document=**} {
    	
      allow update;
      
    }
```
**Important Note**: Immediately after a new university has been successfully uploaded to the Firebase collection, please ensure to revert the permission rules back to the original rule. 