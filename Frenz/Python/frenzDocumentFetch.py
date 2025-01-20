import firebase_admin
import uuid
from firebase_admin import credentials, firestore

# Please contact me for key (rodriguez.aranza.9801@gmail.com)
cred = credentials.Certificate("/Users/aranzarodriguez/Desktop/Swift Practice Projects/Frenz/Python/serviceAccountKey.json")
firebase_admin.initialize_app(cred)

db = firestore.client()
randomID = uuid.uuid4()


def add_new_university_to_collection():

    collection_ref = db.collection("universities")

    university_data = {
    "id" : randomID,
    "university_name": "Yale",
    "majors": [
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
    ],
    "interests": [
        {
            "interest_type": "Sports and Fitness",
            "interests": [
                "Gym", "Football", "Rugby", "Tennis", "Swimming", "Running", "Cycling",
                "Yoga", "Military-style bootcamps", "Hiking", "Rock climbing", "Martial arts",
                "Basketball", "Volleyball", "Golf", "Skiing/Snowboarding"
            ]
        },
        {
            "interest_type": "Travel and Adventure",
            "interests": [
                "Travelling", "Living abroad", "Working abroad", "Backpacking", "Road trips",
                "Camping", "Skydiving", "Scuba diving", "Bungee jumping", "Exploring new cultures"
            ]
        },
        {
            "interest_type": "Arts and Culture",
            "interests": [
                "Theatre", "Art", "Photography", "Museums", "Galleries", "Reading", "Writing",
                "Poetry", "Painting", "Sculpture", "Film/Cinema", "Foreign languages"
            ]
        },
        {
            "interest_type": "Music and Dance",
            "interests": [
                "Listening to music", "Playing instruments", "Singing", "Dancing",
                "Attending concerts", "DJing", "Composing music"
            ]
        },
        {
            "interest_type": "Food and Drink",
            "interests": [
                "Cooking", "Trying new restaurants", "Wine tasting", "Craft beer", "Coffee",
                "Baking", "Vegetarian/Vegan cuisine", "Food photography"
            ]
        },
        {
            "interest_type": "Entertainment and Media",
            "interests": [
                "Netflix", "TV shows", "Movies", "Video games", "Board games", "Podcasts",
                "Comic books", "Anime/Manga"
            ]
        },
        {
            "interest_type": "Social Activities and Lifestyle",
            "interests": [
                "Nightlife", "Going out with friends", "Volunteering", "Politics", "Activism",
                "Meditation", "Mindfulness", "Sustainability", "Minimalism"
            ]
        },
        {
            "interest_type": "Pets and Animals",
            "interests": [
                 "Dog lover", "Cat lover", "Horseback riding", "Animal rights", "Bird watching",
                "Marine life"
            ]
        },
        {
            "interest_type": "Technology and Science",
            "interests": [
                "Coding/Programming", "Artificial Intelligence", "Space exploration", "Gadgets",
                "Robotics", "Astronomy", "Environmental science"
            ]
        },
        {
            "interest_type": "Education and Personal Development",
            "interests": [
                "Learning new skills", "Languages", "Personal growth", "Public speaking",
                "Entrepreneurship", "Investing", "Reading non-fiction"
            ]
        },
        {
            "interest_type": "Fashion and Beauty",
            "interests": [
                "Shopping", "Fashion design", "Makeup artistry", "Skincare", "Hairstyling",
                "Tattoos", "Modeling"
            ]
        },
        {
            "interest_type": "Outdoor Activities",
            "interests": [
                "Gardening", "Fishing", "Hunting", "Bird watching", "Stargazing",
                "Beach activities", "Picnicking"
            ]
        },
        {
            "interest_type": "Creative Hobbies",
            "interests": [
                "DIY projects", "Crafting", "Knitting/Crocheting", "Woodworking", "Pottery",
                "Jewelry making", "Cosplay"
            ]
        },
        {
            "interest_type": "Spiritual and Philosophical Interests",
            "interests": [
                "Meditation", "Yoga (as a spiritual practice)", "Religious studies",
                "Philosophy", "Astrology", "Tarot reading"
            ]
        },
        {
            "interest_type": "Collecting",
            "interests": [
                "Stamps", "Coins", "Antiques", "Vinyl records", "Action figures", "Trading cards"
            ]
        },
        # Add other interest categories here
    ],
    "pic_prompts": ["Me with Handsom Dan", 
                    "Me after leaving High St.", 
                    "I be going to woads looking like...", 
                    "Me after being stuck in Bass", 
                    "Going to NY like...", 
                    "After sneaking into the DHall...", 
                    "TD is #1...fight me", 
                    "After that 7 pm seminar", 
                    "Cross Campus brochure material", 
                    "Getting that MBB interview", 
                    "Late night dorm talks got me like...", 
                    "Start-up millionaire right here", 
                    "When I'm running late to class, at least I look like this", 
                    "Hungover, but at least I still cute", 
                    "Before heading to Bass, I look like this",
                    "Right before sneaking to-go dhall food",
                    "Mother's brisket got me like...", 
                    "Comitting crimes at the Bow Wow got me like..."],

    "comment_prompts": ["When I go to Bass, I make sure to always bring:", 
                        "The best resco is:", 
                        "Best study spot is at:", 
                        "Favorite dining hall food is:", 
                        "Worst class at Yale I've taken:", 
                        "Best place to watch sunsets:", 
                        "Fun fact about me is:", 
                        "I always pay the Bow Wow, which means:"],

    "email_ending": "yale.edu",
    "campus_center_coordinate_latitude": 41.311138,
    "campus_center_coordinate_longitude":  -72.928108,
    # Every college much have at least ONE empty string in this array 
    "dorm_names": ["Benjamin Franklin", "Berkeley", "Branford", "Davenport", "Ezra Stiles", "Grace Hopper", "Jonathan Edwards",
                  "Morse", "Pauli Murray", "Pierson", "Saybrook", "Silliman", "Timothy Dwight", "Trumbull"],
    "id" : str(uuid.uuid4()),

    }

    doc_ref = collection_ref.document(university_data["id"])
    doc_ref.set(university_data)
    print("DocumentID: ", randomID)

print(f"A new university has been added to the firebase University collection!")

add_new_university_to_collection()