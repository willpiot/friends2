//
//  ProfileView.swift
//  Friends
//
//  Created on 2025-12-25.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.dismiss) var dismiss
    let match: Match
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // Photo Grid
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 8) {
                        ForEach(match.user.photoURLs.prefix(6), id: \.self) { photo in
                            Image(systemName: photo)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(height: 150)
                                .background(Color(.systemGray5))
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                    }
                    
                    // Basic Info
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text(match.user.name)
                                .font(.largeTitle)
                                .bold()
                            Text("\(match.user.age)")
                                .font(.title)
                                .foregroundStyle(.secondary)
                            Spacer()
                        }
                        
                        // Match Score
                        HStack {
                            Image(systemName: "heart.fill")
                                .foregroundStyle(.pink)
                            Text("\(Int(match.similarityScore))% Match")
                                .font(.headline)
                                .foregroundStyle(.pink)
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color.pink.opacity(0.1))
                        .cornerRadius(20)
                    }
                    
                    Divider()
                    
                    // Demographics
                    VStack(alignment: .leading, spacing: 16) {
                        InfoRow(icon: "location.fill", title: "Hometown", value: match.user.hometown)
                        InfoRow(icon: "graduationcap.fill", title: "Education", value: match.user.education)
                        InfoRow(icon: "sparkles", title: "Spiritual Beliefs", value: match.user.spiritualBeliefs)
                        InfoRow(icon: "flag.fill", title: "Political Beliefs", value: match.user.politicalBeliefs)
                    }
                    
                    Divider()
                    
                    // Suggested Date
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Suggested Date")
                            .font(.headline)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Image(systemName: "calendar")
                                    .foregroundStyle(.pink)
                                Text(match.suggestedDate.date, style: .date)
                            }
                            
                            HStack {
                                Image(systemName: "clock")
                                    .foregroundStyle(.pink)
                                Text(match.suggestedDate.date, style: .time)
                            }
                            
                            HStack {
                                Image(systemName: "mappin.circle")
                                    .foregroundStyle(.pink)
                                Text(match.suggestedDate.location)
                            }
                            
                            HStack {
                                Image(systemName: "timer")
                                    .foregroundStyle(.pink)
                                Text("\(match.suggestedDate.duration) minutes")
                            }
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                    }
                    
                    // About Compatibility
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Why You Match")
                            .font(.headline)
                        
                        Text("Your compatibility score of \(Int(match.similarityScore))% is based on similarities in your personality, attitudes, beliefs, and interests. Research shows that sharing core values significantly increases relationship satisfaction and long-term success.")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .fixedSize(horizontal: false, vertical: true)
                        
                        Text("This match was carefully selected using AI analysis of your 50-question compatibility assessment.")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                }
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Close") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct InfoRow: View {
    let icon: String
    let title: String
    let value: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: icon)
                .foregroundStyle(.pink)
                .frame(width: 24)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text(value)
                    .font(.body)
            }
            
            Spacer()
        }
    }
}

#Preview {
    ProfileView(match: Match(
        user: User(
            name: "Emma Wilson",
            age: 28,
            gender: .female,
            hometown: "San Francisco, CA",
            education: "Master's in Psychology",
            spiritualBeliefs: "Spiritual but not religious",
            politicalBeliefs: "Moderate",
            photoURLs: ["person.fill", "person.fill", "person.fill", "person.fill", "person.fill", "person.fill"]
        ),
        similarityScore: 87.5,
        suggestedDate: DateProposal(
            date: Date(),
            location: "Blue Bottle Coffee",
            duration: 30
        )
    ))
}
