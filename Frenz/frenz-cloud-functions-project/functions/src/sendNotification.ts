import * as admin from "firebase-admin"


type NotificationPayload = {
    title: string;
    body: string;
    data?: {[key: string]: string}
}

export const sendNotification = async (
  fcmToken: string[],
  payload: NotificationPayload,
): Promise<any> => {
  try {
    const response = await admin.messaging().sendEachForMulticast({
      tokens: fcmToken,
      notification: {
        title: payload.title,
        body: payload.body,
      },
      apns: {
        headers: {
          "apns-push-type": "alert",
          "apns-priority": "10",
          "apns-expiration": "0",
        },
        payload: {
          aps: {
            sound: "default",
          },
        },
      },
    })
    console.log("Sent response: ", response)
    return response
  } catch (error) {
    console.error("Error sending message: ", error)
    throw new Error("Failed to send notification!")
  }
}

