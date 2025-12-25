//
//  User.swift
//  Friends
//
//  Created on 2025-12-25.
//

import Foundation

struct User: Codable, Identifiable {
    let id: UUID
    var name: String
    var age: Int
    var gender: Gender
    var hometown: String
    var education: String
    var spiritualBeliefs: String
    var politicalBeliefs: String
    var email: String?
    var phoneNumber: String?
    var photoURLs: [String] // URLs or asset names for 6 photos
    var answers: [Answer]
    var preferences: Preferences?
    var lastQuestionnaireUpdate: Date
    
    init(id: UUID = UUID(), 
         name: String = "",
         age: Int = 25,
         gender: Gender = .other,
         hometown: String = "",
         education: String = "",
         spiritualBeliefs: String = "",
         politicalBeliefs: String = "",
         email: String? = nil,
         phoneNumber: String? = nil,
         photoURLs: [String] = [],
         answers: [Answer] = [],
         preferences: Preferences? = nil,
         lastQuestionnaireUpdate: Date = Date()) {
        self.id = id
        self.name = name
        self.age = age
        self.gender = gender
        self.hometown = hometown
        self.education = education
        self.spiritualBeliefs = spiritualBeliefs
        self.politicalBeliefs = politicalBeliefs
        self.email = email
        self.phoneNumber = phoneNumber
        self.photoURLs = photoURLs
        self.answers = answers
        self.preferences = preferences
        self.lastQuestionnaireUpdate = lastQuestionnaireUpdate
    }
    
    enum Gender: String, Codable, CaseIterable {
        case male = "Male"
        case female = "Female"
        case other = "Other"
    }
}
