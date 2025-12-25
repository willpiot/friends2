//
//  Match.swift
//  Friends
//
//  Created on 2025-12-25.
//

import Foundation

struct Match: Identifiable, Codable {
    let id: UUID
    let user: User
    let similarityScore: Double
    let suggestedDate: DateProposal
    var status: MatchStatus
    
    enum MatchStatus: String, Codable {
        case pending
        case accepted
        case declined
    }
    
    init(id: UUID = UUID(), 
         user: User,
         similarityScore: Double,
         suggestedDate: DateProposal,
         status: MatchStatus = .pending) {
        self.id = id
        self.user = user
        self.similarityScore = similarityScore
        self.suggestedDate = suggestedDate
        self.status = status
    }
}

struct DateProposal: Codable {
    let date: Date
    let location: String
    let duration: Int // in minutes
}
