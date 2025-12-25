//
//  QuestionBank.swift
//  Friends
//
//  Created on 2025-12-25.
//

import Foundation

struct QuestionBank {
    static let questions: [Question] = [
        // Personality (Big Five Traits) - Questions 1-15
        Question(id: 1, text: "I am outgoing and sociable at social gatherings.", category: .personality),
        Question(id: 2, text: "I prefer quiet, intimate settings over large parties.", category: .personality),
        Question(id: 3, text: "I am organized and like to plan things in advance.", category: .personality),
        Question(id: 4, text: "I am spontaneous and enjoy going with the flow.", category: .personality),
        Question(id: 5, text: "I am emotionally stable and rarely feel anxious.", category: .personality),
        Question(id: 6, text: "I am open to trying new experiences and adventures.", category: .personality),
        Question(id: 7, text: "I am agreeable and avoid conflicts whenever possible.", category: .personality),
        Question(id: 8, text: "I enjoy intellectual discussions and debates.", category: .personality),
        Question(id: 9, text: "I am empathetic and sensitive to others' feelings.", category: .personality),
        Question(id: 10, text: "I am ambitious and driven to achieve my goals.", category: .personality),
        Question(id: 11, text: "I prefer routine and predictability in my daily life.", category: .personality),
        Question(id: 12, text: "I am creative and enjoy artistic pursuits.", category: .personality),
        Question(id: 13, text: "I am optimistic about the future.", category: .personality),
        Question(id: 14, text: "I am comfortable being the center of attention.", category: .personality),
        Question(id: 15, text: "I am detail-oriented and thorough in my work.", category: .personality),
        
        // Attitudes on Relationships & Life Goals - Questions 16-25
        Question(id: 16, text: "Marriage is an important life goal for me.", category: .attitudes),
        Question(id: 17, text: "I want to have children in the future.", category: .attitudes),
        Question(id: 18, text: "I believe in traditional gender roles in relationships.", category: .attitudes),
        Question(id: 19, text: "Communication is the most important aspect of a relationship.", category: .attitudes),
        Question(id: 20, text: "I prioritize career success over personal relationships.", category: .attitudes),
        Question(id: 21, text: "I believe partners should share similar hobbies and interests.", category: .attitudes),
        Question(id: 22, text: "Physical intimacy is essential for a healthy relationship.", category: .attitudes),
        Question(id: 23, text: "I value independence and personal space in a relationship.", category: .attitudes),
        Question(id: 24, text: "Financial stability is crucial before starting a family.", category: .attitudes),
        Question(id: 25, text: "I believe in love at first sight.", category: .attitudes),
        
        // Beliefs (Spirituality & Politics) - Questions 26-35
        Question(id: 26, text: "Religion or spirituality plays an important role in my life.", category: .beliefs),
        Question(id: 27, text: "I attend religious services regularly.", category: .beliefs),
        Question(id: 28, text: "It's important that my partner shares my spiritual beliefs.", category: .beliefs),
        Question(id: 29, text: "I am politically engaged and have strong political views.", category: .beliefs),
        Question(id: 30, text: "My political views align more with progressive/liberal policies.", category: .beliefs),
        Question(id: 31, text: "Environmental conservation is a top priority for me.", category: .beliefs),
        Question(id: 32, text: "I believe in traditional family values.", category: .beliefs),
        Question(id: 33, text: "Social justice and equality are core values for me.", category: .beliefs),
        Question(id: 34, text: "I believe personal responsibility is more important than government support.", category: .beliefs),
        Question(id: 35, text: "My partner and I should have similar political views.", category: .beliefs),
        
        // Interests & Hobbies - Questions 36-43
        Question(id: 36, text: "I enjoy outdoor activities like hiking and camping.", category: .interests),
        Question(id: 37, text: "I prefer staying in and watching movies over going out.", category: .interests),
        Question(id: 38, text: "I am passionate about fitness and exercise.", category: .interests),
        Question(id: 39, text: "I enjoy traveling and exploring new cultures.", category: .interests),
        Question(id: 40, text: "I like attending live music concerts and events.", category: .interests),
        Question(id: 41, text: "Reading books is one of my favorite pastimes.", category: .interests),
        Question(id: 42, text: "I enjoy cooking and trying new recipes.", category: .interests),
        Question(id: 43, text: "Sports and athletic activities are important to me.", category: .interests),
        
        // Deal-Breakers & Lifestyle - Questions 44-50
        Question(id: 44, text: "I am a non-smoker and prefer a non-smoking partner.", category: .dealBreakers),
        Question(id: 45, text: "I drink alcohol socially and am comfortable with a partner who does the same.", category: .dealBreakers),
        Question(id: 46, text: "Having pets is important to me.", category: .dealBreakers),
        Question(id: 47, text: "I would be willing to relocate for my partner's career.", category: .dealBreakers),
        Question(id: 48, text: "I prefer a partner who wants to live in a city rather than the suburbs.", category: .dealBreakers),
        Question(id: 49, text: "Educational background is important to me in a partner.", category: .dealBreakers),
        Question(id: 50, text: "I am open to dating someone from a different cultural or ethnic background.", category: .dealBreakers)
    ]
}
