//
//  Answer.swift
//  Friends
//
//  Created on 2025-12-25.
//

import Foundation

struct Answer: Codable, Identifiable {
    var id: Int { questionId }
    let questionId: Int
    let response: LikertResponse
    
    enum LikertResponse: Int, Codable, CaseIterable {
        case stronglyDisagree = 1
        case disagree = 2
        case neutral = 3
        case agree = 4
        case stronglyAgree = 5
        
        var displayText: String {
            switch self {
            case .stronglyDisagree: return "Strongly Disagree"
            case .disagree: return "Disagree"
            case .neutral: return "Neutral"
            case .agree: return "Agree"
            case .stronglyAgree: return "Strongly Agree"
            }
        }
        
        var weight: Int {
            switch self {
            case .stronglyDisagree, .stronglyAgree: return 5
            case .disagree, .agree: return 3
            case .neutral: return 1
            }
        }
    }
}
