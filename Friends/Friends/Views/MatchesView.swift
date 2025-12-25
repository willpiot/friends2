//
//  MatchesView.swift
//  Friends
//
//  Created on 2025-12-25.
//

import SwiftUI

struct MatchesView: View {
    @EnvironmentObject var dataManager: DataManager
    @State private var showingPreferences = false
    @State private var selectedMatch: Match?
    
    var pendingMatches: [Match] {
        dataManager.matches.filter { $0.status == .pending }
    }
    
    var acceptedMatches: [Match] {
        dataManager.matches.filter { $0.status == .accepted }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // Header
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Your Matches")
                            .font(.largeTitle)
                            .bold()
                        
                        if let user = dataManager.currentUser {
                            Text("Hello, \(user.name)! Here are your matches for this week.")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .padding(.top, 8)
                    
                    // Pending Matches
                    if !pendingMatches.isEmpty {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("New Matches (\(pendingMatches.count))")
                                .font(.headline)
                                .padding(.horizontal)
                            
                            ForEach(pendingMatches) { match in
                                MatchCard(match: match)
                                    .onTapGesture {
                                        selectedMatch = match
                                    }
                            }
                        }
                    }
                    
                    // Accepted Matches (Calendar)
                    if !acceptedMatches.isEmpty {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Upcoming Dates (\(acceptedMatches.count))")
                                .font(.headline)
                                .padding(.horizontal)
                            
                            ForEach(acceptedMatches) { match in
                                AcceptedMatchCard(match: match)
                            }
                        }
                    }
                    
                    if pendingMatches.isEmpty && acceptedMatches.isEmpty {
                        VStack(spacing: 16) {
                            Image(systemName: "heart.slash")
                                .font(.system(size: 60))
                                .foregroundStyle(.secondary)
                            
                            Text("No matches yet")
                                .font(.headline)
                            
                            Text("Check back soon for new matches!")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 60)
                    }
                }
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingPreferences = true }) {
                        Image(systemName: "gearshape.fill")
                    }
                }
            }
            .sheet(isPresented: $showingPreferences) {
                NavigationStack {
                    PreferencesView()
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbar {
                            ToolbarItem(placement: .navigationBarLeading) {
                                Button("Done") {
                                    showingPreferences = false
                                }
                            }
                        }
                }
            }
            .sheet(item: $selectedMatch) { match in
                ProfileView(match: match)
            }
        }
    }
}

struct MatchCard: View {
    @EnvironmentObject var dataManager: DataManager
    let match: Match
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Photo Grid (3x2)
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 8) {
                ForEach(match.user.photoURLs.prefix(6), id: \.self) { photo in
                    Image(systemName: photo)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 100)
                        .background(Color(.systemGray5))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
            }
            
            // User Info
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(match.user.name)
                        .font(.title2)
                        .bold()
                    Text("\(match.user.age)")
                        .font(.title3)
                        .foregroundStyle(.secondary)
                }
                
                HStack(spacing: 16) {
                    Label(match.user.hometown, systemImage: "location.fill")
                    Label(match.user.education, systemImage: "graduationcap.fill")
                }
                .font(.caption)
                .foregroundStyle(.secondary)
                
                HStack {
                    Text("Match Score: \(Int(match.similarityScore))%")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.pink)
                    
                    Spacer()
                }
            }
            
            // Suggested Date
            VStack(alignment: .leading, spacing: 8) {
                Label("Suggested Date", systemImage: "calendar")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(match.suggestedDate.date, style: .date)
                            .font(.caption)
                        Text(match.suggestedDate.date, style: .time)
                            .font(.caption)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 4) {
                        Text(match.suggestedDate.location)
                            .font(.caption)
                            .fontWeight(.medium)
                        Text("\(match.suggestedDate.duration) minutes")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
            }
            
            // Action Buttons
            HStack(spacing: 12) {
                Button(action: {
                    dataManager.declineMatch(match)
                }) {
                    HStack {
                        Image(systemName: "xmark")
                        Text("Pass")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(.systemGray5))
                    .foregroundStyle(.primary)
                    .cornerRadius(12)
                }
                
                Button(action: {
                    dataManager.acceptMatch(match)
                }) {
                    HStack {
                        Image(systemName: "checkmark")
                        Text("Add to Calendar")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.pink)
                    .foregroundStyle(.white)
                    .cornerRadius(12)
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(radius: 4)
        .padding(.horizontal)
    }
}

struct AcceptedMatchCard: View {
    let match: Match
    
    var body: some View {
        HStack(spacing: 16) {
            // Profile Photo
            Image(systemName: match.user.photoURLs.first ?? "person.fill")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 60, height: 60)
                .background(Color(.systemGray5))
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text(match.user.name)
                    .font(.headline)
                
                HStack {
                    Image(systemName: "calendar")
                    Text(match.suggestedDate.date, style: .date)
                }
                .font(.caption)
                .foregroundStyle(.secondary)
                
                HStack {
                    Image(systemName: "clock")
                    Text(match.suggestedDate.date, style: .time)
                    Text("• \(match.suggestedDate.location)")
                }
                .font(.caption)
                .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundStyle(.secondary)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
        .padding(.horizontal)
    }
}

#Preview {
    MatchesView()
        .environmentObject(DataManager())
}
