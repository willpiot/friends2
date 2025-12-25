//
//  ContentView.swift
//  Friends
//
//  Created on 2025-12-25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var dataManager: DataManager
    
    var body: some View {
        NavigationStack {
            if !dataManager.hasSeenWelcome {
                WelcomeView()
            } else if dataManager.currentUser == nil {
                LoginView()
            } else if !dataManager.hasCompletedQuestionnaire {
                QuestionnaireView()
            } else if !dataManager.hasCompletedPreferences {
                PreferencesView()
            } else {
                MatchesView()
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(DataManager())
}
