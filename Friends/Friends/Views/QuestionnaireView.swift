//
//  QuestionnaireView.swift
//  Friends
//
//  Created on 2025-12-25.
//

import SwiftUI

struct QuestionnaireView: View {
    @EnvironmentObject var dataManager: DataManager
    @State private var currentQuestionIndex = 0
    @State private var answers: [Int: Answer.LikertResponse] = [:]
    @State private var showingProgress = false
    
    private let questions = QuestionBank.questions
    
    var progress: Double {
        Double(answers.count) / Double(questions.count)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Header with progress
            VStack(spacing: 12) {
                HStack {
                    Text("Personality Questionnaire")
                        .font(.headline)
                    Spacer()
                    Text("\(answers.count)/\(questions.count)")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                
                ProgressView(value: progress)
                    .tint(.pink)
            }
            .padding()
            .background(Color(.systemBackground))
            .shadow(radius: 2)
            
            // Question Display
            if currentQuestionIndex < questions.count {
                ScrollView {
                    VStack(spacing: 24) {
                        // Category Badge
                        HStack {
                            Text(questions[currentQuestionIndex].category.rawValue.capitalized)
                                .font(.caption)
                                .fontWeight(.semibold)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(categoryColor(questions[currentQuestionIndex].category).opacity(0.2))
                                .foregroundStyle(categoryColor(questions[currentQuestionIndex].category))
                                .cornerRadius(8)
                            Spacer()
                        }
                        .padding(.top, 24)
                        
                        // Question
                        Text(questions[currentQuestionIndex].text)
                            .font(.title2)
                            .fontWeight(.medium)
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom, 8)
                        
                        // Likert Scale Options
                        VStack(spacing: 12) {
                            ForEach(Answer.LikertResponse.allCases, id: \.self) { response in
                                LikertButton(
                                    text: response.displayText,
                                    weight: response.weight,
                                    isSelected: answers[questions[currentQuestionIndex].id] == response,
                                    action: {
                                        selectAnswer(response)
                                    }
                                )
                            }
                        }
                        .padding(.vertical, 16)
                        
                        // Navigation Buttons
                        HStack(spacing: 16) {
                            if currentQuestionIndex > 0 {
                                Button(action: previousQuestion) {
                                    HStack {
                                        Image(systemName: "chevron.left")
                                        Text("Previous")
                                    }
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color(.systemGray5))
                                    .foregroundStyle(.primary)
                                    .cornerRadius(12)
                                }
                            }
                            
                            if answers[questions[currentQuestionIndex].id] != nil {
                                Button(action: nextQuestion) {
                                    HStack {
                                        Text(currentQuestionIndex == questions.count - 1 ? "Complete" : "Next")
                                        Image(systemName: "chevron.right")
                                    }
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.pink)
                                    .foregroundStyle(.white)
                                    .cornerRadius(12)
                                }
                            }
                        }
                        .padding(.bottom, 24)
                    }
                    .padding(.horizontal)
                }
            }
        }
        .navigationBarHidden(true)
    }
    
    private func selectAnswer(_ response: Answer.LikertResponse) {
        answers[questions[currentQuestionIndex].id] = response
    }
    
    private func nextQuestion() {
        if currentQuestionIndex < questions.count - 1 {
            withAnimation {
                currentQuestionIndex += 1
            }
        } else {
            // Complete questionnaire
            completeQuestionnaire()
        }
    }
    
    private func previousQuestion() {
        if currentQuestionIndex > 0 {
            withAnimation {
                currentQuestionIndex -= 1
            }
        }
    }
    
    private func completeQuestionnaire() {
        let answerArray = answers.map { Answer(questionId: $0.key, response: $0.value) }
        dataManager.saveAnswers(answerArray)
    }
    
    private func categoryColor(_ category: Question.Category) -> Color {
        switch category {
        case .personality: return .blue
        case .attitudes: return .green
        case .beliefs: return .purple
        case .interests: return .orange
        case .dealBreakers: return .red
        }
    }
}

struct LikertButton: View {
    let text: String
    let weight: Int
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(text)
                    .font(.body)
                    .fontWeight(.medium)
                Spacer()
                Text("\(weight) pts")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundStyle(.pink)
                }
            }
            .padding()
            .background(isSelected ? Color.pink.opacity(0.1) : Color(.systemGray6))
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(isSelected ? Color.pink : Color.clear, lineWidth: 2)
            )
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    QuestionnaireView()
        .environmentObject(DataManager())
}
