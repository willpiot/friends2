//
//  PreferencesView.swift
//  Friends
//
//  Created on 2025-12-25.
//

import SwiftUI

struct PreferencesView: View {
    @EnvironmentObject var dataManager: DataManager
    @State private var availableDays: Set<Preferences.WeekDay> = Set(Preferences.WeekDay.allCases)
    @State private var preferredTimes: Set<Preferences.TimeSlot> = Set(Preferences.TimeSlot.allCases)
    @State private var preferredLocations: Set<Preferences.LocationType> = [.coffeeShop, .restaurant]
    @State private var minAge = 21
    @State private var maxAge = 35
    @State private var maxDistance = 25.0
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // Header
                VStack(alignment: .leading, spacing: 8) {
                    Text("Set Your Preferences")
                        .font(.largeTitle)
                        .bold()
                    Text("Help us find the perfect match and schedule dates that work for you.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                .padding(.top, 24)
                
                // Available Days
                VStack(alignment: .leading, spacing: 12) {
                    Label("Available Days", systemImage: "calendar")
                        .font(.headline)
                    
                    FlowLayout(spacing: 8) {
                        ForEach(Preferences.WeekDay.allCases, id: \.self) { day in
                            ToggleChip(
                                text: day.rawValue,
                                isSelected: availableDays.contains(day),
                                action: {
                                    if availableDays.contains(day) {
                                        availableDays.remove(day)
                                    } else {
                                        availableDays.insert(day)
                                    }
                                }
                            )
                        }
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                
                // Preferred Times
                VStack(alignment: .leading, spacing: 12) {
                    Label("Preferred Times", systemImage: "clock")
                        .font(.headline)
                    
                    FlowLayout(spacing: 8) {
                        ForEach(Preferences.TimeSlot.allCases, id: \.self) { time in
                            ToggleChip(
                                text: time.rawValue,
                                isSelected: preferredTimes.contains(time),
                                action: {
                                    if preferredTimes.contains(time) {
                                        preferredTimes.remove(time)
                                    } else {
                                        preferredTimes.insert(time)
                                    }
                                }
                            )
                        }
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                
                // Preferred Locations
                VStack(alignment: .leading, spacing: 12) {
                    Label("Preferred Locations", systemImage: "mappin.and.ellipse")
                        .font(.headline)
                    
                    FlowLayout(spacing: 8) {
                        ForEach(Preferences.LocationType.allCases, id: \.self) { location in
                            ToggleChip(
                                text: location.rawValue,
                                isSelected: preferredLocations.contains(location),
                                action: {
                                    if preferredLocations.contains(location) {
                                        preferredLocations.remove(location)
                                    } else {
                                        preferredLocations.insert(location)
                                    }
                                }
                            )
                        }
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                
                // Age Range
                VStack(alignment: .leading, spacing: 12) {
                    Label("Age Range", systemImage: "person.2")
                        .font(.headline)
                    
                    HStack {
                        Text("\(minAge)")
                            .frame(width: 40)
                        Slider(value: Binding(
                            get: { Double(minAge) },
                            set: { minAge = Int($0) }
                        ), in: 18...60, step: 1)
                        Text("\(maxAge)")
                            .frame(width: 40)
                    }
                    
                    HStack {
                        Text("Min: \(minAge)")
                        Spacer()
                        Text("Max: \(maxAge)")
                    }
                    .font(.caption)
                    .foregroundStyle(.secondary)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                
                // Max Distance
                VStack(alignment: .leading, spacing: 12) {
                    Label("Maximum Distance", systemImage: "location.circle")
                        .font(.headline)
                    
                    HStack {
                        Slider(value: $maxDistance, in: 5...50, step: 5)
                        Text("\(Int(maxDistance)) mi")
                            .frame(width: 50)
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                
                // Save Button
                Button(action: savePreferences) {
                    Text("Save Preferences")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.pink)
                        .foregroundStyle(.white)
                        .cornerRadius(12)
                }
                .disabled(availableDays.isEmpty || preferredTimes.isEmpty || preferredLocations.isEmpty)
                .padding(.top, 8)
                
                Spacer(minLength: 24)
            }
            .padding()
        }
        .navigationBarHidden(true)
    }
    
    private func savePreferences() {
        let preferences = Preferences(
            availableDays: Array(availableDays),
            preferredTimes: Array(preferredTimes),
            preferredLocations: Array(preferredLocations),
            minAge: minAge,
            maxAge: maxAge,
            maxDistance: maxDistance
        )
        dataManager.savePreferences(preferences)
    }
}

struct ToggleChip: View {
    let text: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(text)
                .font(.subheadline)
                .fontWeight(.medium)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(isSelected ? Color.pink : Color(.systemBackground))
                .foregroundStyle(isSelected ? .white : .primary)
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(isSelected ? Color.clear : Color(.systemGray4), lineWidth: 1)
                )
        }
    }
}

struct FlowLayout: Layout {
    var spacing: CGFloat = 8
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let result = FlowResult(
            in: proposal.replacingUnspecifiedDimensions().width,
            subviews: subviews,
            spacing: spacing
        )
        return result.size
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let result = FlowResult(
            in: bounds.width,
            subviews: subviews,
            spacing: spacing
        )
        for (index, subview) in subviews.enumerated() {
            subview.place(at: CGPoint(x: bounds.minX + result.positions[index].x, y: bounds.minY + result.positions[index].y), proposal: .unspecified)
        }
    }
    
    struct FlowResult {
        var size: CGSize = .zero
        var positions: [CGPoint] = []
        
        init(in maxWidth: CGFloat, subviews: Subviews, spacing: CGFloat) {
            var currentX: CGFloat = 0
            var currentY: CGFloat = 0
            var lineHeight: CGFloat = 0
            
            for subview in subviews {
                let size = subview.sizeThatFits(.unspecified)
                
                if currentX + size.width > maxWidth && currentX > 0 {
                    currentX = 0
                    currentY += lineHeight + spacing
                    lineHeight = 0
                }
                
                positions.append(CGPoint(x: currentX, y: currentY))
                currentX += size.width + spacing
                lineHeight = max(lineHeight, size.height)
            }
            
            self.size = CGSize(width: maxWidth, height: currentY + lineHeight)
        }
    }
}

#Preview {
    PreferencesView()
        .environmentObject(DataManager())
}
