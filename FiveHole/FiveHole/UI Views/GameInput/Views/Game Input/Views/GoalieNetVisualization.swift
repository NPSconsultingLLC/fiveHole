//
//  GoalieNetVisualization.swift
//  FiveHole
//
//  Visual representation of goalie net showing where goals went in
//

import SwiftUI

struct GoalieNetVisualization: View {
    // Track goals by location
    @State var goalLocations: [GoalLocation] = []
    
    var body: some View {
        VStack(spacing: 4) {
            Text("Goal Map")
                .font(.caption)
                .foregroundColor(.NPSTextColor)
            
            GeometryReader { geometry in
                ZStack {
                    // Net outline
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .stroke(Color.NPSButtonEnd, lineWidth: 2)
                        .background(
                            RoundedRectangle(cornerRadius: 8, style: .continuous)
                                .fill(LinearGradient(Color.NPSDarkStart, Color.NPSDarkEnd))
                        )
                    
                    // Grid lines dividing the net
                    VStack(spacing: 0) {
                        // Top row
                        HStack(spacing: 0) {
                            netZone(location: .topLeft, in: geometry)
                            Divider()
                                .background(Color.NPSButtonEnd.opacity(0.3))
                            netZone(location: .topRight, in: geometry)
                        }
                        .frame(height: geometry.size.height / 3)
                        
                        Divider()
                            .background(Color.NPSButtonEnd.opacity(0.3))
                        
                        // Middle row
                        HStack(spacing: 0) {
                            netZone(location: .middleLeft, in: geometry)
                            Divider()
                                .background(Color.NPSButtonEnd.opacity(0.3))
                            netZone(location: .middleRight, in: geometry)
                        }
                        .frame(height: geometry.size.height / 3)
                        
                        Divider()
                            .background(Color.NPSButtonEnd.opacity(0.3))
                        
                        // Bottom row
                        HStack(spacing: 0) {
                            netZone(location: .bottomLeft, in: geometry)
                            Divider()
                                .background(Color.NPSButtonEnd.opacity(0.3))
                            netZone(location: .bottomMiddle, in: geometry)
                            Divider()
                                .background(Color.NPSButtonEnd.opacity(0.3))
                            netZone(location: .bottmRight, in: geometry)
                        }
                        .frame(height: geometry.size.height / 3)
                    }
                }
            }
            .frame(height: 180)
            .padding(.horizontal, 20)
        }
    }
    
    private func netZone(location: GoalLocation, in geometry: GeometryProxy) -> some View {
        ZStack {
            Color.clear
            
            // Show markers for goals in this location
            let goalsInZone = goalLocations.filter { $0 == location }
            
            if !goalsInZone.isEmpty {
                VStack(spacing: 2) {
                    ForEach(0..<min(goalsInZone.count, 3), id: \.self) { index in
                        Circle()
                            .fill(Color.red)
                            .frame(width: 12, height: 12)
                            .overlay(
                                Circle()
                                    .stroke(Color.white, lineWidth: 1)
                            )
                    }
                    
                    if goalsInZone.count > 3 {
                        Text("+\(goalsInZone.count - 3)")
                            .font(.caption2)
                            .foregroundColor(.NPSTextColor)
                    }
                }
            }
            
            // Zone label (optional - shows on tap or always)
            Text(zoneName(for: location))
                .font(.system(size: 8))
                .foregroundColor(.NPSTextColor.opacity(0.4))
                .padding(4)
        }
    }
    
    private func zoneName(for location: GoalLocation) -> String {
        switch location {
        case .topLeft: return "TL"
        case .topRight: return "TR"
        case .middleLeft: return "ML"
        case .middleRight: return "MR"
        case .bottomLeft: return "BL"
        case .bottomMiddle: return "5H" // Five-hole
        case .bottmRight: return "BR"
        }
    }
}

// MARK: - Compact Version (smaller)

struct GoalieNetVisualizationCompact: View {
    @State var goalLocations: [GoalLocation] = []
    
    var body: some View {
        VStack(spacing: 2) {
            Text("Goals")
                .font(.caption2)
                .foregroundColor(.NPSTextColor)
            
            HStack(spacing: 8) {
                // Visual net representation (3x3 grid)
                VStack(spacing: 2) {
                    // Top row
                    HStack(spacing: 2) {
                        zoneIndicator(.topLeft)
                        zoneIndicator(.topRight)
                    }
                    
                    // Middle row
                    HStack(spacing: 2) {
                        zoneIndicator(.middleLeft)
                        zoneIndicator(.middleRight)
                    }
                    
                    // Bottom row
                    HStack(spacing: 2) {
                        zoneIndicator(.bottomLeft)
                        zoneIndicator(.bottomMiddle)
                        zoneIndicator(.bottmRight)
                    }
                }
                .padding(4)
                .background(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color.NPSButtonEnd, lineWidth: 1)
                )
                
                // Goal count
                VStack(alignment: .leading, spacing: 2) {
                    Text("\(goalLocations.count)")
                        .font(.title3)
                        .foregroundColor(.NPSTextColor)
                    Text("total")
                        .font(.caption2)
                        .foregroundColor(.NPSTextColor.opacity(0.6))
                }
            }
        }
        .frame(height: 80)
    }
    
    private func zoneIndicator(_ location: GoalLocation) -> some View {
        let count = goalLocations.filter { $0 == location }.count
        
        return Circle()
            .fill(count > 0 ? Color.red : Color.NPSDarkEnd)
            .frame(width: 20, height: 20)
            .overlay(
                Group {
                    if count > 0 {
                        Text("\(count)")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundColor(.white)
                    }
                }
            )
    }
}

// MARK: - Preview

struct GoalieNetVisualization_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            // Full version with sample data
            GoalieNetVisualization(goalLocations: [
                .topLeft,
                .bottomMiddle,
                .bottomMiddle, // Five-hole x2
                .middleRight,
                .topRight
            ])
            
            Divider()
            
            // Compact version
            GoalieNetVisualizationCompact(goalLocations: [
                .topLeft,
                .bottomMiddle,
                .bottomMiddle,
                .middleRight
            ])
        }
        .padding()
        .background(Color.NPSBackgroundGradientStart)
        .preferredColorScheme(.dark)
    }
}
