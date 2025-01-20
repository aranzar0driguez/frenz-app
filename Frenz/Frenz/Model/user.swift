//
//  user.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 10/14/24.
//

import Foundation

struct user: Codable, Hashable, Identifiable, Equatable {
    
    var id = UUID()
    
    var firstName: String
    var lastName: String
    var email: String
    var age: Int
    var birthday: Date
    var interests: [String]
    var friendBio: String
    var admirerBio: String
    var major: String
    var paths: [String]
    var imagesURL: [String]
    var latitude: Double
    var longitude: Double
    var attractedSex: AttractedSex?
    var appUtilizationPurpose: AppUtilizationPurpose?
    var lookingFor: LookingFor?
    var selectedPicturePrompts: [String]
    var selectedWrittenPrompts: [String]
    var answeredWrittenPrompts: [String]
    var keywordsForLookup: [String] {
        [self.firstName.generateStringSequence(), self.lastName.generateStringSequence(), self.email.generateStringSequence(), "\(self.firstName) \(self.lastName)".generateStringSequence()].flatMap{ $0 }
    }
    var randomNum: Int
    var giftsReceived: [GiftReceived]
    var messages: [String]
    var sex: Sex?
    var universityID: String
    var customField: String? // ex: dorm name
    //  24 hours before today, so that the user can press the button and refresh new users
    var newFriendsUsersCards = Calendar.current.date(byAdding: .hour, value: -24, to: Date())!
    var newAdmirersUsersCards = Calendar.current.date(byAdding: .hour, value: -24, to: Date())!
    var newFriendUsersMap = Calendar.current.date(byAdding: .hour, value: -24, to: Date())!
    var newAdmirersUsersMap = Calendar.current.date(byAdding: .hour, value: -24, to: Date())!
    var admirersMapEmails: [String]
    var admirersCardsEmails: [String]
    var friendsMapEmails: [String]
    var friendsCardsEmails: [String]
    var fcmToken: String
    
    init(
        firstName: String,
        lastName: String,
        email: String,
        age: Int,
        birthday: Date,
        interests: [String],
        friendBio: String,
        admirerBio: String,
        major: String,
        paths: [String],
        imagesURL: [String],
        latitude: Double,
        longitude: Double,
        attractedSex: AttractedSex?,
        appUtilizationPurpose: AppUtilizationPurpose?,
        lookingFor: LookingFor?,
        selectedPicturePrompts: [String],
        selectedWrittenPrompts: [String],
        answeredWrittenPrompts: [String],
        randomNum: Int,
        giftsReceived: [GiftReceived],
        messages: [String],
        sex: Sex?,
        universityID: String,
        customField: String,
        admirersMapEmails: [String],
        admirersCardsEmails: [String],
        friendsMapEmails: [String],
        friendsCardsEmails: [String],
        fcmToken: String
    ) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.age = age
        self.birthday = birthday
        self.interests = interests
        self.friendBio = friendBio
        self.admirerBio = admirerBio
        self.major = major
        self.paths = paths
        self.imagesURL = imagesURL
        self.latitude = latitude
        self.longitude = longitude
        self.attractedSex = attractedSex
        self.appUtilizationPurpose = appUtilizationPurpose
        self.lookingFor = lookingFor
        self.selectedPicturePrompts = selectedPicturePrompts
        self.selectedWrittenPrompts = selectedWrittenPrompts
        self.answeredWrittenPrompts = answeredWrittenPrompts
        self.randomNum = randomNum
        self.giftsReceived = giftsReceived
        self.messages = messages
        self.sex = sex
        self.universityID = universityID
        self.customField = customField
        self.admirersMapEmails = admirersMapEmails
        self.admirersCardsEmails = admirersCardsEmails
        self.friendsMapEmails = friendsMapEmails
        self.friendsCardsEmails = friendsCardsEmails
        self.fcmToken = fcmToken
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "user_id"
        case firstName = "first_name"
        case lastName = "last_name"
        case email = "email"
        case age = "age"
        case birthday = "birthday"
        case interests = "interests"
        case friendBio = "friend_bio"
        case admirerBio = "admirer_bio"
        case major = "major"
        case paths = "paths"
        case imagesURL = "images_url"
        case latitude = "latitude"
        case longitude = "longitude"
        case attractedSex = "attracted_sex"
        case appUtilizationPurpose = "app_utilization_purpose"
        case lookingFor = "looking_for"
        case selectedPicturePrompts = "selected_picture_prompts"
        case selectedWrittenPrompts = "selected_written_prompts"
        case answeredWrittenPrompts = "answered_written_prompts"
        case keywordsForLookup = "keywords_for_lookup"
        case randomNum = "random_num"
        case giftsReceived = "gifts_received"
        case messages = "messages"
        case sex = "sex"
        case universityID = "uni_id"
        case customField = "custom_field"
        case newFriendsUsersCards = "new_friends_users_cards"
        case newAdmirersUsersCards = "new_admirers_users_cards"
        case newFriendUsersMap = "new_friends_users_map"
        case newAdmirersUsersMap = "new_admirers_users_map"
        case admirersMapEmails = "admirers_map_emails"
        case admirersCardsEmails = "admirers_cards_emails"
        case friendsMapEmails = "friends_map_emails"
        case friendsCardsEmails = "friends_cards_emails"
        case fcmToken = "fcm_token"
    }
    
    init (from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(UUID.self, forKey: .id)
        self.firstName = try container.decode(String.self, forKey: .firstName)
        self.lastName = try container.decode(String.self, forKey: .lastName)
        self.email = try container.decode(String.self, forKey: .email)
        self.age = try container.decode(Int.self, forKey: .age)
        self.birthday = try container.decode(Date.self, forKey: .birthday)
        self.interests = try container.decode([String].self, forKey: .interests)
        self.friendBio = try container.decode(String.self, forKey: .friendBio)
        self.admirerBio = try container.decode(String.self, forKey: .admirerBio)
        self.major = try container.decode(String.self, forKey: .major)
        self.paths = try container.decode([String].self, forKey: .paths)
        self.imagesURL = try container.decode([String].self, forKey: .imagesURL)
        self.latitude = try container.decode(Double.self, forKey: .latitude)
        self.longitude = try container.decode(Double.self, forKey: .longitude)
        self.attractedSex = try container.decodeIfPresent(AttractedSex.self, forKey: .attractedSex)
        self.appUtilizationPurpose = try container.decodeIfPresent(AppUtilizationPurpose.self, forKey: .appUtilizationPurpose)
        self.lookingFor = try container.decodeIfPresent(LookingFor.self, forKey: .lookingFor)
        self.selectedPicturePrompts = try container.decode([String].self, forKey: .selectedPicturePrompts)
        self.selectedWrittenPrompts = try container.decode([String].self, forKey: .selectedWrittenPrompts)
        self.answeredWrittenPrompts = try container.decode([String].self, forKey: .answeredWrittenPrompts)
        self.randomNum = try container.decode(Int.self, forKey: .randomNum)
        self.giftsReceived = try container.decode([GiftReceived].self, forKey: .giftsReceived)
        self.messages = try container.decode([String].self, forKey: .messages)
        self.sex = try container.decodeIfPresent(Sex.self, forKey: .sex)
        self.universityID = try container.decode(String.self, forKey: .universityID)
        self.customField = try container.decodeIfPresent(String.self, forKey: .customField)
        self.newFriendsUsersCards = try container.decode(Date.self, forKey: .newFriendsUsersCards)
        self.newAdmirersUsersCards = try container.decode(Date.self, forKey: .newAdmirersUsersCards)
        self.newFriendUsersMap = try container.decode(Date.self, forKey: .newFriendUsersMap)
        self.newAdmirersUsersMap = try container.decode(Date.self, forKey: .newAdmirersUsersMap)
        self.admirersMapEmails = try container.decode([String].self, forKey: .admirersMapEmails)
        self.admirersCardsEmails = try container.decode([String].self, forKey: .admirersCardsEmails)
        self.friendsMapEmails = try container.decode([String].self, forKey: .friendsMapEmails)
        self.friendsCardsEmails = try container.decode([String].self, forKey: .friendsCardsEmails)
        self.fcmToken = try container.decode(String.self, forKey: .fcmToken)
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.firstName, forKey: .firstName)
        try container.encode(self.lastName, forKey: .lastName)
        try container.encode(self.email, forKey: .email)
        try container.encode(self.age, forKey: .age)
        try container.encode(self.birthday, forKey: .birthday)
        try container.encode(self.interests, forKey: .interests)
        try container.encode(self.friendBio, forKey: .friendBio)
        try container.encode(self.admirerBio, forKey: .admirerBio)
        try container.encode(self.major, forKey: .major)
        try container.encode(self.paths, forKey: .paths)
        try container.encode(self.imagesURL, forKey: .imagesURL)
        try container.encode(self.latitude, forKey: .latitude)
        try container.encode(self.longitude, forKey: .longitude)
        try container.encodeIfPresent(self.attractedSex, forKey: .attractedSex)
        try container.encodeIfPresent(self.appUtilizationPurpose, forKey: .appUtilizationPurpose)
        try container.encodeIfPresent(self.lookingFor, forKey: .lookingFor)
        try container.encode(self.selectedPicturePrompts, forKey: .selectedPicturePrompts)
        try container.encode(self.selectedWrittenPrompts, forKey: .selectedWrittenPrompts)
        try container.encode(self.answeredWrittenPrompts, forKey: .answeredWrittenPrompts)
        try container.encode(self.randomNum, forKey: .randomNum)
        try container.encode(self.giftsReceived, forKey: .giftsReceived)
        try container.encode(self.messages, forKey: .messages)
        try container.encodeIfPresent(self.sex, forKey: .sex)
        try container.encode(self.universityID, forKey: .universityID)
        try container.encodeIfPresent(self.customField, forKey: .customField)
        try container.encode(self.newFriendsUsersCards, forKey: .newFriendsUsersCards)
        try container.encode(self.newAdmirersUsersCards, forKey: .newAdmirersUsersCards)
        try container.encode(self.newFriendUsersMap, forKey: .newFriendUsersMap)
        try container.encode(self.newAdmirersUsersMap, forKey: .newAdmirersUsersMap)
        try container.encode(self.admirersCardsEmails, forKey: .admirersCardsEmails)
        try container.encode(self.admirersMapEmails, forKey: .admirersMapEmails)
        try container.encode(self.friendsCardsEmails, forKey: .friendsCardsEmails)
        try container.encode(self.friendsMapEmails, forKey: .friendsMapEmails)
        try container.encode(self.fcmToken, forKey: .fcmToken)
    }
    
    static func == (lhs: user, rhs: user) -> Bool {
        return lhs.id == rhs.id
    }
    
}

extension String {
    
    func generateStringSequence() -> [String] {
       //   "Mark" => ["M", "Ma", "Mar", "Mark"]
        
        guard self.count > 0 else { return [] }
        
        var sequence: [String] = []
        
        for i in 1...self.count {
            sequence.append(String(self.prefix(i)))
        }
        
        return sequence
    }
    
}

enum AttractedSex: String, CaseIterable, Codable {
    
    case female = "Females"
    case male = "Males"
    case both = "Both"
}


enum AppUtilizationPurpose: String, CaseIterable, Codable {
    
    case friends = "Making new friends"
    case romantic = "Meeting romantic suitors"
    case friendsAndRomantic = "Making new friends & meeting romantic suitors"
}

enum Sex: String, CaseIterable, Codable {
    
    case female = "female"
    case male = "male"
}

enum LookingFor: String, CaseIterable, Codable {
    case longTermPartner = "Long-term partner"
    case longTermShort = "Long-term, open to short"
    case shortTermLong = "Short-term, open to long"
    case shortTermFun = "Short-term fun"
    case figuringItOut = "Still figuring it out"
}

enum GiftType: String, CaseIterable, Codable {
    
    case heart = "heart"
    case chocolate = "chocolate"
    case rose = "rose"
    case teddyBear = "teddyBear"
    case wine = "wine"
    case cake = "cake"
    case coffee = "coffee"
    case note = "letter"
    case dinner = "dinner"
    case plant = "plant"
    case cool = "cool"
    case cookie = "cookie"
    case bulldog = "bulldog"
    case pizza = "pizza"
    case peace = "peace"
    case hat = "hat"
    
}

enum GiftSentPurpose: String, CaseIterable, Codable {
    
    case romantic = "romantic"
    case friends = "friends"
    
}

enum GiftAction: String, CaseIterable, Codable, CodingKey {
    
    case sent = "sent"
    case received = "received"
    
}

struct GiftReceived: Hashable, Codable {
    
    var otherUser: String
    var giftSentPurpose: GiftSentPurpose
    var giftType: GiftType
    var giftAction: GiftAction
    var acceptedGift: Bool
    var messageID: String

    
    enum CodingKeys: String, CodingKey {
        
            case otherUser = "other_user"
            case giftType = "gift_type"  // Ensure exact match with Firebase field name
            case giftSentPurpose = "gift_sent_purpose"
            case giftAction = "gift_action"
            case acceptedGift = "accepted_gift"
            case messageID = "message_id"
        
        }
    
    init (otherUser: String, giftType: GiftType, giftSentPurpose: GiftSentPurpose, giftAction: GiftAction, acceptedGift: Bool, messageID: String) {
    
        self.otherUser = otherUser
        self.giftType = giftType
        self.giftSentPurpose = giftSentPurpose
        self.giftAction = giftAction
        self.acceptedGift = acceptedGift
        self.messageID = messageID
        
    }
    
    // Add custom encoding method
       func encode(to encoder: Encoder) throws {
           var container = encoder.container(keyedBy: CodingKeys.self)
           
           try container.encode(self.otherUser, forKey: .otherUser)
           try container.encode(self.giftType, forKey: .giftType)
           try container.encode(self.giftSentPurpose, forKey: .giftSentPurpose)
           try container.encode(self.giftAction, forKey: .giftAction)
           try container.encode(self.acceptedGift, forKey: .acceptedGift)
           try container.encode(self.messageID, forKey: .messageID)
           
       }
       
       // Add custom decoding initializer
       init(from decoder: Decoder) throws {
           
           let container = try decoder.container(keyedBy: CodingKeys.self)
           
           self.otherUser = try container.decode(String.self, forKey: .otherUser)
           self.giftType = try container.decodeIfPresent(GiftType.self, forKey: .giftType) ?? .cake
           self.giftSentPurpose = try container.decodeIfPresent(GiftSentPurpose.self, forKey: .giftSentPurpose) ?? .friends
           self.giftAction = try container.decodeIfPresent(GiftAction.self, forKey: .giftAction) ?? .received
           self.acceptedGift = try container.decode(Bool.self, forKey: .acceptedGift)
           self.messageID = try container.decode(String.self, forKey: .messageID)
       }
    
}

struct MockUser {
    static let fakeUser = user(firstName: "Aranza", lastName: "Rodriguez", email: "aranza.rodriguez@yale.edu", age: 23, birthday: Date(), interests: ["Dancing", "Cooking", "Reading", "Thrifting"], friendBio: "Hello! I really like dogs and cats and all the other cool things. This is a short bio where people can include information about themselves.", admirerBio: "Hello! I really like dogs and cats and all the other cool things. This is a short bio where people can include information about themselves.", major: "Psychology", paths: [], imagesURL: ["one", "two", "three"], latitude: 41.311291, longitude: -72.931763, attractedSex: .male, appUtilizationPurpose: .friendsAndRomantic, lookingFor: .figuringItOut, selectedPicturePrompts: ["This is the first prompt", "This is the second prompt", "This is the thrid prompt"], selectedWrittenPrompts: ["First written prompt:", "Second written prompt"], answeredWrittenPrompts: ["Answer to first written prompt,", "Answer to second written prompt"], randomNum: 1, giftsReceived: [], messages: [], sex: .female, universityID: "", customField: "Morse", admirersMapEmails: [], admirersCardsEmails: [], friendsMapEmails: [], friendsCardsEmails: [], fcmToken: "")
    
    
    static let fakeUsers = [
        
        user(firstName: "Bob", lastName: "Doe", email: "aranza.rodriguez@yale.edu", age: 23, birthday: Date(), interests: ["Dancing", "Cooking", "Reading", "Thrifting"],  friendBio: "Hello! I really like dogs and cats and all the other cool things. This is a short bio where people can include information about themselves.", admirerBio: "Hello! I really like dogs and cats and all the other cool things. This is a short bio where people can include information about themselves.", major: "Psychology", paths: [], imagesURL: [], latitude: 41.311581, longitude: -72.929451, attractedSex: .male, appUtilizationPurpose: .friendsAndRomantic, lookingFor: .figuringItOut, selectedPicturePrompts: [], selectedWrittenPrompts: [], answeredWrittenPrompts: [], randomNum: 1, giftsReceived: [], messages: [], sex: .female, universityID: "", customField: "", admirersMapEmails: [], admirersCardsEmails: [], friendsMapEmails: [], friendsCardsEmails: [], fcmToken: ""),
        
        
        user(firstName: "Jane", lastName: "Doe", email: "aranza.rodriguez@yale.edu", age: 23, birthday: Date(), interests: ["Dancing", "Cooking", "Reading", "Thrifting"], friendBio: "Hello! I really like dogs and cats and all the other cool things. This is a short bio where people can include information about themselves.", admirerBio: "Hello! I really like dogs and cats and all the other cool things. This is a short bio where people can include information about themselves.", major: "Psychology", paths: [], imagesURL: [], latitude: 41.310471, longitude: -72.923927, attractedSex: .male, appUtilizationPurpose: .friendsAndRomantic, lookingFor: .figuringItOut, selectedPicturePrompts: [], selectedWrittenPrompts: [], answeredWrittenPrompts: [], randomNum: 2, giftsReceived: [], messages: [], sex: .female, universityID: "", customField: "", admirersMapEmails: [], admirersCardsEmails: [], friendsMapEmails: [], friendsCardsEmails: [], fcmToken: ""),
        
        user(firstName: "Aranza", lastName: "Rodriguez", email: "aranza.rodriguez@yale.edu", age: 23, birthday: Date(), interests: ["Dancing", "Cooking", "Reading", "Thrifting"],  friendBio: "Hello! I really like dogs and cats and all the other cool things. This is a short bio where people can include information about themselves.", admirerBio: "Hello! I really like dogs and cats and all the other cool things. This is a short bio where people can include information about themselves.", major: "Psychology", paths: [], imagesURL: [], latitude: 41.311291, longitude: -72.931763, attractedSex: .male, appUtilizationPurpose: .friendsAndRomantic, lookingFor: .figuringItOut, selectedPicturePrompts: [], selectedWrittenPrompts: [], answeredWrittenPrompts: [], randomNum: 3, giftsReceived: [], messages: [], sex: .male, universityID: "", customField: "", admirersMapEmails: [], admirersCardsEmails: [], friendsMapEmails: [], friendsCardsEmails: [], fcmToken: ""),
        
        user(firstName: "Valentina", lastName: "Sanchez", email: "aranza.rodriguez@yale.edu", age: 23, birthday: Date(), interests: ["Dancing", "Cooking", "Reading", "Thrifting"], friendBio: "Hello! I really like dogs and cats and all the other cool things. This is a short bio where people can include information about themselves.", admirerBio: "Hello! I really like dogs and cats and all the other cool things. This is a short bio where people can include information about themselves.", major: "Psychology", paths: [], imagesURL: [], latitude: 41.305790, longitude: -72.927399, attractedSex: .male, appUtilizationPurpose: .friendsAndRomantic, lookingFor: .figuringItOut, selectedPicturePrompts: [], selectedWrittenPrompts: [], answeredWrittenPrompts: [], randomNum: 4, giftsReceived: [], messages: [], sex: .male, universityID: "", customField: "", admirersMapEmails: [], admirersCardsEmails: [], friendsMapEmails: [], friendsCardsEmails: [], fcmToken: "")
        
        
    ]
}
