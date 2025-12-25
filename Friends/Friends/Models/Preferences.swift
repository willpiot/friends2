//
//  Preferences.swift
//  Friends
//
//  Created on 2025-12-25.
//

import Foundation

struct Preferences: Codable {
    var availableDays: [WeekDay]
    var preferredTimes: [TimeSlot]
    var preferredLocations: [LocationType]
    var minAge: Int
    var maxAge: Int
    var maxDistance: Double // in miles
    
    enum WeekDay: String, Codable, CaseIterable {
        case monday = "Monday"
        case tuesday = "Tuesday"
        case wednesday = "Wednesday"
        case thursday = "Thursday"
        case friday = "Friday"
        case saturday = "Saturday"
        case sunday = "Sunday"
    }
    
    enum TimeSlot: String, Codable, CaseIterable {
        case morning = "Morning (8am-12pm)"
        case afternoon = "Afternoon (12pm-5pm)"
        case evening = "Evening (5pm-9pm)"
    }
    
    enum LocationType: String, Codable, CaseIterable {
        case coffeeShop = "Coffee Shop"
        case restaurant = "Restaurant"
        case park = "Park"
        case bar = "Bar/Lounge"
        case museum = "Museum/Gallery"
    }
    
    init(availableDays: [WeekDay] = WeekDay.allCases,
         preferredTimes: [TimeSlot] = TimeSlot.allCases,
         preferredLocations: [LocationType] = [.coffeeShop, .restaurant],
         minAge: Int = 21,
         maxAge: Int = 35,
         maxDistance: Double = 25.0) {
        self.availableDays = availableDays
        self.preferredTimes = preferredTimes
        self.preferredLocations = preferredLocations
        self.minAge = minAge
        self.maxAge = maxAge
        self.maxDistance = maxDistance
    }
}
