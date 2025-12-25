//
//  Question.swift
//  Friends
//
//  Created on 2025-12-25.
//

import Foundation

struct Question: Identifiable, Codable {
    let id: Int
    let text: String
    let category: Category
    
    enum Category: String, Codable {
        case personality
        case attitudes
        case beliefs
        case interests
        case dealBreakers
    }
}
