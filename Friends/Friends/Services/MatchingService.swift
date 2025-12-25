//
//  MatchingService.swift
//  Friends
//
//  Created on 2025-12-25.
//

import Foundation

struct MatchingService {
    
    /// Calculate similarity score between two users based on their questionnaire answers
    /// Uses weighted scoring: Strongly Agree/Disagree = 5 points, Agree/Disagree = 3 points, Neutral = 1 point
    static func calculateSimilarity(user1: User, user2: User) -> Double {
        guard !user1.answers.isEmpty && !user2.answers.isEmpty else {
            return 0.0
        }
        
        var totalScore = 0.0
        var maxPossibleScore = 0.0
        
        for answer1 in user1.answers {
            if let answer2 = user2.answers.first(where: { $0.questionId == answer1.questionId }) {
                let weight1 = Double(answer1.response.weight)
                let weight2 = Double(answer2.response.weight)
                
                // Calculate similarity for this question
                let difference = abs(answer1.response.rawValue - answer2.response.rawValue)
                
                // If answers match exactly, add full weight
                if difference == 0 {
                    totalScore += max(weight1, weight2)
                }
                // If answers are adjacent (e.g., Agree and Strongly Agree), add partial credit
                else if difference == 1 {
                    totalScore += max(weight1, weight2) * 0.75
                }
                // If answers are 2 steps apart (e.g., Neutral and Strongly Agree), add some credit
                else if difference == 2 {
                    totalScore += max(weight1, weight2) * 0.5
                }
                // If answers are 3+ steps apart, minimal credit
                else {
                    totalScore += max(weight1, weight2) * 0.25
                }
                
                maxPossibleScore += max(weight1, weight2)
            }
        }
        
        return maxPossibleScore > 0 ? (totalScore / maxPossibleScore) * 100 : 0.0
    }
    
    /// Filter potential matches based on age preferences
    static func filterByAgePreference(user: User, potentialMatches: [User]) -> [User] {
        guard let preferences = user.preferences else { return potentialMatches }
        
        return potentialMatches.filter { match in
            // Men typically match with same age or younger women
            if user.gender == .male && match.gender == .female {
                return match.age >= preferences.minAge && match.age <= user.age
            }
            // Women typically match with same age or older men
            else if user.gender == .female && match.gender == .male {
                return match.age >= user.age && match.age <= preferences.maxAge
            }
            // For other combinations, use standard age range
            else {
                return match.age >= preferences.minAge && match.age <= preferences.maxAge
            }
        }
    }
    
    /// Suggest dates based on user preferences
    static func suggestDate(user1Prefs: Preferences, user2Prefs: Preferences) -> DateProposal? {
        // Find common days
        let commonDays = Set(user1Prefs.availableDays).intersection(Set(user2Prefs.availableDays))
        guard !commonDays.isEmpty else { return nil }
        
        // Find common time slots
        let commonTimes = Set(user1Prefs.preferredTimes).intersection(Set(user2Prefs.preferredTimes))
        guard !commonTimes.isEmpty else { return nil }
        
        // Find common location types
        let commonLocations = Set(user1Prefs.preferredLocations).intersection(Set(user2Prefs.preferredLocations))
        guard !commonLocations.isEmpty else { return nil }
        
        // Create a date proposal
        let randomDay = commonDays.randomElement()!
        let randomTime = commonTimes.randomElement()!
        let randomLocation = commonLocations.randomElement()!
        
        // Calculate next occurrence of the selected day
        var date = Date()
        let calendar = Calendar.current
        let currentWeekday = calendar.component(.weekday, from: date)
        let targetWeekday = weekdayNumber(for: randomDay)
        
        var daysToAdd = targetWeekday - currentWeekday
        if daysToAdd <= 0 {
            daysToAdd += 7
        }
        date = calendar.date(byAdding: .day, value: daysToAdd, to: date) ?? date
        
        // Set time based on time slot
        let hour = hourForTimeSlot(randomTime)
        date = calendar.date(bySettingHour: hour, minute: 0, second: 0, of: date) ?? date
        
        return DateProposal(
            date: date,
            location: locationName(for: randomLocation),
            duration: 30
        )
    }
    
    private static func weekdayNumber(for day: Preferences.WeekDay) -> Int {
        switch day {
        case .sunday: return 1
        case .monday: return 2
        case .tuesday: return 3
        case .wednesday: return 4
        case .thursday: return 5
        case .friday: return 6
        case .saturday: return 7
        }
    }
    
    private static func hourForTimeSlot(_ slot: Preferences.TimeSlot) -> Int {
        switch slot {
        case .morning: return 10
        case .afternoon: return 14
        case .evening: return 18
        }
    }
    
    private static func locationName(for type: Preferences.LocationType) -> String {
        switch type {
        case .coffeeShop: return "Blue Bottle Coffee"
        case .restaurant: return "The Garden Bistro"
        case .park: return "Central Park"
        case .bar: return "The Rooftop Lounge"
        case .museum: return "City Art Museum"
        }
    }
}
