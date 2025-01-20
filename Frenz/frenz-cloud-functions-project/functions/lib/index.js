"use strict";
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    var desc = Object.getOwnPropertyDescriptor(m, k);
    if (!desc || ("get" in desc ? !m.__esModule : desc.writable || desc.configurable)) {
      desc = { enumerable: true, get: function() { return m[k]; } };
    }
    Object.defineProperty(o, k2, desc);
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __importStar = (this && this.__importStar) || function (mod) {
    if (mod && mod.__esModule) return mod;
    var result = {};
    if (mod != null) for (var k in mod) if (k !== "default" && Object.prototype.hasOwnProperty.call(mod, k)) __createBinding(result, mod, k);
    __setModuleDefault(result, mod);
    return result;
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.getRandomUsers = exports.getUserAppVersion = exports.sendNotif = void 0;
// import * as dotenv from "dotenv"
const functions = __importStar(require("firebase-functions/v1"));
const admin = __importStar(require("firebase-admin"));
// import {QuerySnapshot} from "firebase-admin/firestore"
const express_1 = __importDefault(require("express"));
const sendNotification_1 = require("./sendNotification");
// - - - - - - - -  IGNORE CODE FROM ABOVE!! - - - - - - -
const app = (0, express_1.default)();
app.use(express_1.default.json());
//  Initializes Firebase SDK
admin.initializeApp();
const db = admin.firestore();
app.post("/send-notification", async (req, res) => {
    const { fcmToken, title, body, data } = req.body;
    if (!fcmToken || !title || !body) {
        return res
            .status(400)
            .json({ error: "fcmToken, title, and body are required" });
    }
    const authHeader = req.headers.authorization;
    if (!authHeader || !authHeader.startsWith("Bearer ")) {
        return res.status(401).json({ error: "Unauthorized: Missing firebase authentication token!" });
    }
    //  Validates to ensure a firebase token was passed in the header
    const idToken = authHeader.split("Bearer ")[1];
    const decodedToken = await admin.auth().verifyIdToken(idToken);
    if (!decodedToken) {
        return res
            .status(401)
            .json({ error: "Authentication Error" });
    }
    try {
        const payload = {
            title,
            body,
            data,
        };
        const response = await (0, sendNotification_1.sendNotification)(fcmToken, payload);
        if (response) {
            return res
                .status(200)
                .json({ message: "Notification sent successfully", response });
        }
        else {
            return res
                .status(400)
                .json({ message: "Failed to send notification due to auth error" });
        }
    }
    catch (error) {
        console.error("Error: ", error);
        return res.status(500).json({ error: "Internal Server Error" });
    }
});
exports.sendNotif = functions.https.onRequest(app);
// endpoint: /getUserAppVersion
exports.getUserAppVersion = functions.https.onRequest(async (request, response) => {
    try {
        const userAppVersion = request.body.userAppVersion;
        // Screen that will pop up regardless if user is signed in
        // This screen will pop up if the user does not have the min app version installed
        let showMainWarningScreen;
        // If this varibale = true, a screen will pop up if the user has already created an account
        // This should be set to true for cases such as, "fixing a bug, we'll be up soon", "beta testing has ended", etc.
        let showSubWarningScreen;
        const docRef = await db.collection("version").doc("frenz").get();
        const minAppVersion = docRef.get("min_version");
        const showMainFullScreen = docRef.get("show_main_full_screen");
        const showSubFullScreen = docRef.get("show_sub_full_screen");
        const mainMessage = docRef.get("main_message");
        const subMessage = docRef.get("sub_message");
        //  If the user's app version < min app version OR if the showMainFullScreen in the database = true, it will show
        // the main warning screen
        if (userAppVersion < minAppVersion || showMainFullScreen == true) {
            showMainWarningScreen = true;
        }
        else {
            showMainWarningScreen = false;
        }
        if (showSubFullScreen == true) {
            showSubWarningScreen = true;
        }
        else {
            showSubWarningScreen = false;
        }
        response.json({
            showMainFullScreen: showMainWarningScreen,
            showSubWarningScreen: showSubWarningScreen,
            mainMessage: mainMessage,
            subMessage: subMessage,
        });
    }
    catch (error) {
        console.error("Error fetching users:", error);
    }
});
exports.getRandomUsers = functions.https.onRequest(async (request, response) => {
    try {
        const userEmail = request.body.userEmail;
        const userGender = request.body.userGender;
        const userSexuality = request.body.userSexuality;
        const fetchRomanticUsers = request.body.fetchRomanticUsers;
        const numOfUsersToFetch = 6; //  Max num of users to fetch/display when the user clikc "new users"
        const totalUsersDoc = await db.collection("quantity").doc("total_num_of_users").get();
        const totalUsers = totalUsersDoc.get("users");
        const userEmails = new Set();
        const buildQueries = (randomNum) => {
            const queries = [];
            // If we're only fetching romantic users, select the users who have the "app_utilization_purpose" varibale set to either
            // of the two first array. Otherwise, select users who have their "app_utilization_purpose" set to either of the second array
            const appPurposes = fetchRomanticUsers ?
                ["Meeting romantic suitors", "Making new friends & meeting romantic suitors"] :
                ["Making new friends", "Making new friends & meeting romantic suitors"];
            if (fetchRomanticUsers) {
                if (userGender === "female") {
                    if (userSexuality === "Females") {
                        // Female attracted to females
                        queries.push({ sex: "female", attracted_sex: "Females" }, { sex: "female", attracted_sex: "Both" });
                    }
                    else if (userSexuality === "Males") {
                        // Female attracted to males
                        queries.push({ sex: "male", attracted_sex: "Females" }, { sex: "male", attracted_sex: "Both" });
                    }
                    else if (userSexuality === "Both") {
                        // Female attracted to both
                        queries.push({ sex: "female", attracted_sex: "Females" }, { sex: "female", attracted_sex: "Both" }, { sex: "male", attracted_sex: "Females" }, { sex: "male", attracted_sex: "Both" });
                    }
                }
                else if (userGender === "male") {
                    if (userSexuality === "Females") {
                        // Male attracted to females
                        queries.push({ sex: "female", attracted_sex: "Males" }, { sex: "female", attracted_sex: "Both" });
                    }
                    else if (userSexuality === "Males") {
                        // Male attracted to males
                        queries.push({ sex: "male", attracted_sex: "Males" }, { sex: "male", attracted_sex: "Both" });
                    }
                    else if (userSexuality === "Both") {
                        // Male attracted to both
                        queries.push({ sex: "female", attracted_sex: "Both" }, { sex: "female", attracted_sex: "Males" }, { sex: "male", attracted_sex: "Both" }, { sex: "male", attracted_sex: "Males" });
                    }
                }
                //  Returns back a user who meets the query requirements
                return queries.flatMap(query => appPurposes.map(purpose => db.collection("users")
                    .where("random_num", "==", randomNum)
                    .where("app_utilization_purpose", "==", purpose)
                    .where("sex", "==", query.sex)
                    .where("attracted_sex", "==", query.attracted_sex)));
            }
            else {
                //  If we're fetching for friends...
                return appPurposes.map(purpose => db
                    .collection("users")
                    .where("random_num", "==", randomNum)
                    .where("app_utilization_purpose", "==", purpose));
            }
        };
        //  Executes the queries
        const fetchRandomUserSnapshots = async (randomNum) => {
            const queries = buildQueries(randomNum);
            const snapshots = await Promise.all(queries.map(query => query.get()));
            return snapshots.filter(snapshot => !snapshot.empty);
        };
        const startTime = Date.now();
        const timeLimit = 7 * 1000; // 7 seconds //  Times out after 7 seconds if num of users to fetch hasn't been reached
        //  While we still haven't al of the users necessary...
        while (userEmails.size < numOfUsersToFetch) {
            const elapsedTime = Date.now() - startTime;
            if (elapsedTime > timeLimit) {
                console.log("Loop exited due to timeout");
                break;
            }
            //  Generates random num to fetch user
            const randomNum = Math.floor(Math.random() * totalUsers) + 1;
            console.log(randomNum);
            const snapshots = await fetchRandomUserSnapshots(randomNum);
            //  If there is a valid snapshots, it will process it and add it
            snapshots.forEach(snapshot => snapshot.forEach(doc => {
                const email = doc.get("email");
                console.log(email);
                if (!userEmails.has(email) && email != userEmail) {
                    userEmails.add(email);
                }
            }));
        }
        response.json({ useremails: Array.from(userEmails) });
    }
    catch (error) {
        console.error("Error fetching users:", error);
        response.status(500).send({ error: "Internal Server Error" });
    }
});
//# sourceMappingURL=index.js.map