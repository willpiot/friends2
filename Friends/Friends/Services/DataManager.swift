//
//  DataManager.swift
//  Friends
//
//  Created on 2025-12-25.
//

import Foundation
import Combine

class DataManager: ObservableObject {
    @Published var currentUser: User?
    @Published var hasSeenWelcome: Bool = false
    @Published var hasCompletedQuestionnaire: Bool = false
    @Published var hasCompletedPreferences: Bool = false
    @Published var matches: [Match] = []
    
    private let userDefaultsKey = "currentUser"
    private let welcomeKey = "hasSeenWelcome"
    
    init() {
        loadUser()
    }
    
    func markWelcomeSeen() {
        hasSeenWelcome = true
        UserDefaults.standard.set(true, forKey: welcomeKey)
    }
    
    func createUser(name: String, age: Int, gender: User.Gender, email: String? = nil, phone: String? = nil) {
        let user = User(
            name: name,
            age: age,
            gender: gender,
            email: email,
            phoneNumber: phone,
            photoURLs: ["person.fill", "person.fill", "person.fill", "person.fill", "person.fill", "person.fill"]
        )
        currentUser = user
        saveUser()
    }
    
    func saveAnswers(_ answers: [Answer]) {
        guard var user = currentUser else { return }
        user.answers = answers
        user.lastQuestionnaireUpdate = Date()
        currentUser = user
        hasCompletedQuestionnaire = true
        saveUser()
    }
    
    func savePreferences(_ preferences: Preferences) {
        guard var user = currentUser else { return }
        user.preferences = preferences
        currentUser = user
        hasCompletedPreferences = true
        saveUser()
        
        // Generate sample matches
        generateSampleMatches()
    }
    
    func updatePreferences(_ preferences: Preferences) {
        guard var user = currentUser else { return }
        user.preferences = preferences
        currentUser = user
        saveUser()
    }
    
    func canUpdateQuestionnaire() -> Bool {
        guard let user = currentUser else { return true }
        let daysSinceLastUpdate = Calendar.current.dateComponents([.day], from: user.lastQuestionnaireUpdate, to: Date()).day ?? 0
        return daysSinceLastUpdate >= 30
    }
    
    func acceptMatch(_ match: Match) {
        if let index = matches.firstIndex(where: { $0.id == match.id }) {
            matches[index].status = .accepted
        }
    }
    
    func declineMatch(_ match: Match) {
        if let index = matches.firstIndex(where: { $0.id == match.id }) {
            matches[index].status = .declined
        }
    }
    
    private func loadUser() {
        hasSeenWelcome = UserDefaults.standard.bool(forKey: welcomeKey)
        
        if let data = UserDefaults.standard.data(forKey: userDefaultsKey),
           let user = try? JSONDecoder().decode(User.self, from: data) {
            currentUser = user
            hasCompletedQuestionnaire = !user.answers.isEmpty
            hasCompletedPreferences = user.preferences != nil
            
            if hasCompletedPreferences {
                generateSampleMatches()
            }
        }
    }
    
    private func saveUser() {
        guard let user = currentUser,
              let data = try? JSONEncoder().encode(user) else { return }
        UserDefaults.standard.set(data, forKey: userDefaultsKey)
    }
    
    private func generateSampleMatches() {
        guard let currentUser = currentUser else { return }
        
        // Generate 3 sample matches with different profiles
        let sampleUsers = [
            User(
                name: "Emma Wilson",
                age: 28,
                gender: .female,
                hometown: "San Francisco, CA",
                education: "Master's in Psychology",
                spiritualBeliefs: "Spiritual but not religious",
                politicalBeliefs: "Moderate",
                photoURLs: ["person.fill", "person.fill", "person.fill", "person.fill", "person.fill", "person.fill"]
            ),
            User(
                name: "Michael Chen",
                age: 30,
                gender: .male,
                hometown: "Seattle, WA",
                education: "Bachelor's in Engineering",
                spiritualBeliefs: "Atheist",
                politicalBeliefs: "Liberal",
                photoURLs: ["person.fill", "person.fill", "person.fill", "person.fill", "person.fill", "person.fill"]
            ),
            User(
                name: "Sarah Johnson",
                age: 26,
                gender: .female,
                hometown: "Portland, OR",
                education: "PhD in Biology",
                spiritualBeliefs: "Christian",
                politicalBeliefs: "Conservative",
                photoURLs: ["person.fill", "person.fill", "person.fill", "person.fill", "person.fill", "person.fill"]
            )
        ]
        
        matches = sampleUsers.map { user in
            let score = MatchingService.calculateSimilarity(user1: currentUser, user2: user)
            let date = Calendar.current.date(byAdding: .day, value: Int.random(in: 1...7), to: Date()) ?? Date()
            let locations = ["Blue Bottle Coffee", "The Park Cafe", "Riverside Bistro"]
            
            return Match(
                user: user,
                similarityScore: score,
                suggestedDate: DateProposal(
                    date: date,
                    location: locations.randomElement() ?? "Local Coffee Shop",
                    duration: 30
                )
            )
        }
    }
}
