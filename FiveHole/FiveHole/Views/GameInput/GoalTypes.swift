//
//  GoalTypes.swift
//  FiveHole
//
//  Shared types for goal tracking and visualization
//

import Foundation

// MARK: - GoalLocation Enum

enum GoalLocation: String, Codable, Equatable, CaseIterable {
    case topLeft
    case topRight
    case middleLeft
    case middleRight
    case bottomLeft
    case bottomMiddle
    case bottmRight  // Note: Keep typo for backward compatibility with existing data
    
    // Human-readable names
    var displayName: String {
        switch self {
        case .topLeft: return "Top Left"
        case .topRight: return "Top Right"
        case .middleLeft: return "Middle Left"
        case .middleRight: return "Middle Right"
        case .bottomLeft: return "Bottom Left"
        case .bottomMiddle: return "Five Hole"
        case .bottmRight: return "Bottom Right"
        }
    }
    
    // Short labels for visualization
    var shortLabel: String {
        switch self {
        case .topLeft: return "TL"
        case .topRight: return "TR"
        case .middleLeft: return "ML"
        case .middleRight: return "MR"
        case .bottomLeft: return "BL"
        case .bottomMiddle: return "5H"
        case .bottmRight: return "BR"
        }
    }
    
    // Icon for visualization
    var iconName: String {
        switch self {
        case .topLeft: return "arrow.up.left"
        case .topRight: return "arrow.up.right"
        case .middleLeft: return "arrow.left"
        case .middleRight: return "arrow.right"
        case .bottomLeft: return "arrow.down.left"
        case .bottomMiddle: return "5.circle.fill"  // Five-hole special icon
        case .bottmRight: return "arrow.down.right"
        }
    }
}

// MARK: - GoalDetail Struct

struct GoalDetail: Codable, Identifiable {
    let id: UUID
    let location: GoalLocation
    let isRedirected: Bool
    let isPenaltyShot: Bool
    let isOvertime: Bool
    let timestamp: Date
    
    init(
        id: UUID = UUID(),
        location: GoalLocation,
        isRedirected: Bool = false,
        isPenaltyShot: Bool = false,
        isOvertime: Bool = false,
        timestamp: Date = Date()
    ) {
        self.id = id
        self.location = location
        self.isRedirected = isRedirected
        self.isPenaltyShot = isPenaltyShot
        self.isOvertime = isOvertime
        self.timestamp = timestamp
    }
    
    // Summary description
    var description: String {
        var parts: [String] = [location.displayName]
        if isRedirected { parts.append("Redirected") }
        if isPenaltyShot { parts.append("Penalty Shot") }
        if isOvertime { parts.append("Overtime") }
        return parts.joined(separator: ", ")
    }
}

// MARK: - Helper Extensions

extension Array where Element == GoalLocation {
    /// Count goals by location
    var locationCounts: [GoalLocation: Int] {
        var counts: [GoalLocation: Int] = [:]
        for location in self {
            counts[location, default: 0] += 1
        }
        return counts
    }
    
    /// Most common goal location
    var mostCommonLocation: GoalLocation? {
        locationCounts.max(by: { $0.value < $1.value })?.key
    }
    
    /// Total unique zones where goals were scored
    var uniqueZones: Int {
        Set(self).count
    }
}

extension Array where Element == GoalDetail {
    /// Filter by location
    func goals(in location: GoalLocation) -> [GoalDetail] {
        filter { $0.location == location }
    }
    
    /// Filter by metadata
    var redirectedGoals: [GoalDetail] {
        filter { $0.isRedirected }
    }
    
    var penaltyShots: [GoalDetail] {
        filter { $0.isPenaltyShot }
    }
    
    var overtimeGoals: [GoalDetail] {
        filter { $0.isOvertime }
    }
    
    /// Most recent goal
    var mostRecent: GoalDetail? {
        self.max(by: { $0.timestamp < $1.timestamp })
    }
}
