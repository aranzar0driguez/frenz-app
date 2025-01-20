//
//  University.swift
//  Frenz
//
//  Created by Aranza Rodriguez on 10/16/24.
//

import Foundation
import SwiftUI

struct University: Codable {
    
    
    //  Update the university components to firebase *DONE*
    //  When the user signs up, have a field equal the university ID
    //  When they begin creating their account, create an environemnt variable that fetches the university ID and makes it =
    //  Change components to reflect univeresity specific factors
    var id = UUID()
    var universityName: String
    var majors: [String]
    var interests: [interest]
    var picPrompts: [String]
    var commentPrompts: [String]
    var emailEnding: String
    var campusCenterCoordinateLatitude: Double
    var campusCenterCoordinateLongitude: Double
    var dormNames: [String]?
    
    init(
        universityName: String,
        majors: [String],
        interests: [interest],
        picPrompts: [String],
        commentPrompts: [String],
        emailEnding: String,
        campusCenterCoordinateLatitude: Double,
        campusCenterCoordinateLongitude: Double,
        dormNames: [String]?
    ) {
        self.universityName = universityName
        self.majors = majors
        self.interests = interests
        self.picPrompts = picPrompts
        self.commentPrompts = commentPrompts
        self.emailEnding = emailEnding
        self.campusCenterCoordinateLatitude = campusCenterCoordinateLatitude
        self.campusCenterCoordinateLongitude = campusCenterCoordinateLongitude
        self.dormNames = dormNames
    }
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case universityName = "university_name"
        case majors = "majors"
        case interests = "interests"
        case picPrompts = "pic_prompts"
        case commentPrompts = "comment_prompts"
        case emailEnding = "email_ending"
        case campusCenterCoordinateLatitude = "campus_center_coordinate_latitude"
        case campusCenterCoordinateLongitude = "campus_center_coordinate_longitude"
        case dormNames = "dorm_names"
        
    }
    
    init (from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.universityName = try container.decode(String.self, forKey: .universityName)
        self.majors = try container.decode([String].self, forKey: .majors)
        self.interests = try container.decode([interest].self, forKey: .interests)
        self.picPrompts = try container.decode([String].self, forKey: .picPrompts)
        self.commentPrompts = try container.decode([String].self, forKey: .commentPrompts)
        self.emailEnding = try container.decode(String.self, forKey: .emailEnding)
        self.campusCenterCoordinateLatitude = try container.decode(Double.self, forKey: .campusCenterCoordinateLatitude)
        self.campusCenterCoordinateLongitude = try container.decode(Double.self, forKey: .campusCenterCoordinateLongitude)
        self.dormNames = try container.decodeIfPresent([String].self, forKey: .dormNames)
        
    }
    
}

struct interest: Codable {
    
    var interestType: String
    var interests : [String]
    
    enum CodingKeys: String, CodingKey {
        
        case interestType = "interest_type"
        case interests = "interests"
        
    }
    
    init(interestType: String, interests: [String]) {
        
        self.interestType = interestType
        self.interests = interests 
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.interestType = try container.decode(String.self, forKey: .interestType)
        self.interests = try container.decode([String].self, forKey: .interests)
    }
    
}





struct Yale {
    static let yaleUniversity = University(universityName: "Yale University", majors: [
        "African American Studies",
        "African Studies",
        "American Studies",
        "Anthropology",
        "Applied Mathematics",
        "Applied Physics",
        "Archaeological Studies",
        "Architecture",
        "Art",
        "Astronomy",
        "Astrophysics",
        "Biomedical Engineering",
        "Chemical Engineering",
        "Chemistry",
        "Classical Civilization",
        "Classics",
        "Cognitive Science",
        "Comparative Literature",
        "Computer Science",
        "Computer Science and Economics",
        "Computer Science and Mathematics",
        "Computer Science and Psychology",
        "Computing and Linguistics",
        "Computing and the Arts",
        "Earth and Planetary Sciences",
        "East Asian Languages and Literatures",
        "East Asian Studies",
        "Ecology and Evolutionary Biology",
        "Economics",
        "Economics and Mathematics",
        "Electrical Engineering",
        "Electrical Engineering and Computer Science",
        "Engineering Sciences (Chemical)",
        "Engineering Sciences (Electrical)",
        "Engineering Sciences (Environmental)",
        "Engineering Sciences (Mechanical)",
        "English",
        "Environmental Engineering",
        "Environmental Studies",
        "Ethics, Politics, and Economics",
        "Ethnicity, Race, and Migration",
        "Film and Media Studies",
        "French",
        "German Studies",
        "Global Affairs",
        "Greek, Ancient and Modern",
        "History",
        "History of Art",
        "History of Science, Medicine, and Public Health",
        "Humanities",
        "Italian Studies",
        "Jewish Studies",
        "Latin American Studies",
        "Linguistics",
        "Mathematics",
        "Mathematics and Philosophy",
        "Mathematics and Physics",
        "Mechanical Engineering",
        "Modern Middle East Studies",
        "Molecular Biophysics and Biochemistry",
        "Molecular, Cellular, and Developmental Biology",
        "Music",
        "Near Eastern Languages and Civilizations",
        "Neuroscience",
        "Philosophy",
        "Physics",
        "Physics and Geosciences",
        "Physics and Philosophy",
        "Political Science",
        "Portuguese",
        "Psychology",
        "Religious Studies",
        "Russian",
        "Russian, East European, and Eurasian Studies",
        "Sociology",
        "South Asian Studies (second major only)",
        "Spanish",
        "Special Divisional Major",
        "Statistics and Data Science",
        "Theater, Dance, and Performance Studies",
        "Urban Studies",
        "Women's, Gender, and Sexuality Studies"
    ], interests: [
        interest(
            interestType: "Sports and Fitness",
            
            interests: [
                "Gym", "Football", "Rugby", "Tennis", "Swimming", "Running", "Cycling",
                "Yoga", "Military-style bootcamps", "Hiking", "Rock climbing", "Martial arts",
                "Basketball", "Volleyball", "Golf", "Skiing/Snowboarding"
            ]
        ),
        interest(
            interestType: "Travel and Adventure",
            
            interests: [
                "Travelling", "Living abroad", "Working abroad", "Backpacking", "Road trips",
                "Camping", "Skydiving", "Scuba diving", "Bungee jumping", "Exploring new cultures"
            ]
        ),
        interest(
            interestType: "Arts and Culture",
            
            interests: [
                "Theatre", "Art", "Photography", "Museums", "Galleries", "Reading", "Writing",
                "Poetry", "Painting", "Sculpture", "Film/Cinema", "Foreign languages"
            ]
        ),
        interest(
            interestType: "Music and Dance",
            interests: [
                "Listening to music", "Playing instruments", "Singing", "Dancing",
                "Attending concerts", "DJing", "Composing music"
            ]
        ),
        interest(
            interestType: "Food and Drink",
            
            interests: [
                "Cooking", "Trying new restaurants", "Wine tasting", "Craft beer", "Coffee",
                "Baking", "Vegetarian/Vegan cuisine", "Food photography"
            ]
        ),
        interest(
            interestType: "Entertainment and Media",
            
            interests: [
                "Netflix", "TV shows", "Movies", "Video games", "Board games", "Podcasts",
                "Comic books", "Anime/Manga"
            ]
        ),
        interest(
            interestType: "Social Activities and Lifestyle",
            
            interests: [
                "Nightlife", "Going out with friends", "Volunteering", "Politics", "Activism",
                "Meditation", "Mindfulness", "Sustainability", "Minimalism"
            ]
        ),
        interest(
            interestType: "Pets and Animals",
            
            interests: [
                "Dog lover", "Cat lover", "Horseback riding", "Animal rights", "Bird watching",
                "Marine life"
            ]
        ),
        interest(
            interestType: "Technology and Science",
            
            interests: [
                "Coding/Programming", "Artificial Intelligence", "Space exploration", "Gadgets",
                "Robotics", "Astronomy", "Environmental science"
            ]
        ),
        interest(
            interestType: "Education and Personal Development",
            
            interests: [
                "Learning new skills", "Languages", "Personal growth", "Public speaking",
                "Entrepreneurship", "Investing", "Reading non-fiction"
            ]
        ),
        interest(
            interestType: "Fashion and Beauty",
            
            interests: [
                "Shopping", "Fashion design", "Makeup artistry", "Skincare", "Hairstyling",
                "Tattoos", "Modeling"
            ]
        ),
        interest(
            interestType: "Outdoor Activities",
            
            interests: [
                "Gardening", "Fishing", "Hunting", "Bird watching", "Stargazing",
                "Beach activities", "Picnicking"
            ]
        ),
        interest(
            interestType: "Creative Hobbies",
            
            interests: [
                "DIY projects", "Crafting", "Knitting/Crocheting", "Woodworking", "Pottery",
                "Jewelry making", "Cosplay"
            ]
        ),
        interest(
            interestType: "Spiritual and Philosophical Interests",
            
            interests: [
                "Meditation", "Yoga (as a spiritual practice)", "Religious studies",
                "Philosophy", "Astrology", "Tarot reading"
            ]
        ),
        interest(
            interestType: "Collecting",
            
            interests: [
                "Stamps", "Coins", "Antiques", "Vinyl records", "Action figures", "Trading cards"
            ]
        )
    ], picPrompts: ["Me with Handsom Dan", "Me after leaving High St.", "I be going to woads looking like...", "Me after being stuck in Bass", "Going to NY like...", "After sneaking into the DHall...", "TD is #1...fight me", "After that 7 pm seminar", "Cross Campus brochure material", "Getting that MBB interview", "Late night dorm talks got me like...", "Start-up millionaire right here", "When I'm running late to class, at least I look like this", "Hungover, but at least I still cute", "Before heading to Bass, I look like this", "Right before sneaking to-go dhall food", "Mother's brisket got me like...", "Comitting crimes at the Bow Wow got me like..."],
                                           
                                           commentPrompts: ["When I go to Bass, I make sure to always bring:", "The best resco is:", "Best study spot is at:", "Favorite dining hall food is:", "Worst class at Yale I've taken:", "Best place to watch sunsets:", "Fun fact about me is:", "I always pay the Bow Wow, which means:"],
                                           
                                           emailEnding: "@yale.edu",
                                           campusCenterCoordinateLatitude: 0.0,
                                           campusCenterCoordinateLongitude: 0.0,
                                           dormNames: ["Benjamin Franklin", "Berkeley", "Branford", "Davenport", "Ezra Stiles", "Grace Hopper", "Jonathan Edwards",
                                                       "Morse", "Pauli Murray", "Pierson", "Saybrook", "Silliman", "Timothy Dwight", "Trumbull"]
    )
    
}
