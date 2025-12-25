//
//  WelcomeView.swift
//  Friends
//
//  Created on 2025-12-25.
//

import SwiftUI

struct WelcomeView: View {
    @EnvironmentObject var dataManager: DataManager
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // App Title
                VStack(alignment: .center, spacing: 8) {
                    Image(systemName: "heart.circle.fill")
                        .font(.system(size: 80))
                        .foregroundStyle(.pink.gradient)
                    
                    Text("Welcome to Friends")
                        .font(.largeTitle)
                        .bold()
                    
                    Text("The AI-Powered Marriage App")
                        .font(.title3)
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity)
                .padding(.top, 40)
                
                Divider()
                
                // Evidence-Based Approach
                VStack(alignment: .leading, spacing: 12) {
                    Label("Evidence-Based Matching", systemImage: "brain.head.profile")
                        .font(.headline)
                        .foregroundStyle(.pink)
                    
                    Text("Our approach is grounded in social psychology research. Studies by Byrne, Ervin, and Lamberth (2004) demonstrate that similarity in attitudes, beliefs, and values significantly increases attraction and relationship success.")
                        .font(.body)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    Text("We focus on the proportion of shared values that matter most to you, as research shows this predicts long-term compatibility better than superficial factors.")
                        .font(.body)
                        .foregroundStyle(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                
                // AI Matching
                VStack(alignment: .leading, spacing: 12) {
                    Label("Intelligent AI Matching", systemImage: "sparkles")
                        .font(.headline)
                        .foregroundStyle(.blue)
                    
                    Text("Our AI analyzes your personality, attitudes, beliefs, and preferences to find highly compatible matches. No endless swiping—just meaningful connections.")
                        .font(.body)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                
                // Scheduled Dates
                VStack(alignment: .leading, spacing: 12) {
                    Label("Scheduled Real Dates", systemImage: "calendar.badge.clock")
                        .font(.headline)
                        .foregroundStyle(.green)
                    
                    Text("We suggest 3 dates per week with your best matches. Each date is a 30-minute meetup at a convenient location and time that works for both of you.")
                        .font(.body)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    Text("Skip the endless texting—meet in person and discover real chemistry.")
                        .font(.body)
                        .foregroundStyle(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                
                // Mission
                VStack(alignment: .leading, spacing: 12) {
                    Label("Our Mission", systemImage: "heart.text.square")
                        .font(.headline)
                        .foregroundStyle(.purple)
                    
                    Text("We're combating population decline by promoting meaningful relationships that lead to marriage and family formation. Friends helps you find your life partner based on true compatibility.")
                        .font(.body)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                
                // Get Started Button
                Button(action: {
                    dataManager.markWelcomeSeen()
                }) {
                    HStack {
                        Text("Get Started")
                            .font(.headline)
                        Image(systemName: "arrow.right")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.pink)
                    .foregroundStyle(.white)
                    .cornerRadius(12)
                }
                .padding(.top, 8)
            }
            .padding()
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    WelcomeView()
        .environmentObject(DataManager())
}
