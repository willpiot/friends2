//
//  FriendsApp.swift
//  Friends
//
//  Created on 2025-12-25.
//

import SwiftUI

@main
struct FriendsApp: App {
    @StateObject private var dataManager = DataManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(dataManager)
        }
    }
}
