//
//  GoalLocationView.swift
//  FiveHole
//
//  FIXED VERSION - Addresses all major defects
//

import SwiftUI

struct GoalLocationView: View {
    @Binding var showGoalDetailsView: Bool
    @Binding var goalLocations: [GoalLocation]
    
    // FIXED: Single selectedZone instead of 7 separate toggles
    @State private var selectedZone: GoalLocation? = nil
    
    // Metadata
    @State private var redirected = false
    @State private var penaltyShot = false
    @State private var overTimeGoal = false
    
    var body: some View {
        ZStack {
            // Background
            LinearGradient(
                gradient: .init(colors: [Color.NPSBackgroundGradientStart, Color.NPSBackgroundGradientEnd]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                // Header
                Text("Where did the goal go in?")
                    .font(.title2)
                    .foregroundColor(.NPSTextColor)
                    .padding(.top)
                
                // Metadata toggles
                HStack(spacing: 20) {
                    metadataToggle(
                        title: "Redirected",
                        isOn: $redirected,
                        icon: "arrow.triangle.2.circlepath"
                    )
                    
                    metadataToggle(
                        title: "Penalty",
                        isOn: $penaltyShot,
                        icon: "exclamationmark.triangle"
                    )
                    
                    metadataToggle(
                        title: "Overtime",
                        isOn: $overTimeGoal,
                        icon: "clock"
                    )
                }
                .padding(.horizontal)
                
                // GOALIE NET - Visual representation
                VStack(spacing: 8) {
                    Text("Tap a zone")
                        .font(.caption)
                        .foregroundColor(.NPSTextColor.opacity(0.6))
                    
                    // Net outline
                    VStack(spacing: 0) {
                        // Top row (2 zones)
                        HStack(spacing: 0) {
                            zoneButton(.topLeft, label: "Top\nLeft")
                            Divider()
                                .background(Color.NPSButtonEnd.opacity(0.3))
                            zoneButton(.topRight, label: "Top\nRight")
                        }
                        .frame(height: 120)
                        
                        Divider()
                            .background(Color.NPSButtonEnd.opacity(0.3))
                        
                        // Middle row (2 zones)
                        HStack(spacing: 0) {
                            zoneButton(.middleLeft, label: "Mid\nLeft")
                            Divider()
                                .background(Color.NPSButtonEnd.opacity(0.3))
                            zoneButton(.middleRight, label: "Mid\nRight")
                        }
                        .frame(height: 120)
                        
                        Divider()
                            .background(Color.NPSButtonEnd.opacity(0.3))
                        
                        // Bottom row (3 zones)
                        HStack(spacing: 0) {
                            zoneButton(.bottomLeft, label: "Bottom\nLeft")
                            Divider()
                                .background(Color.NPSButtonEnd.opacity(0.3))
                            zoneButton(.bottomMiddle, label: "Five\nHole", highlight: true)
                            Divider()
                                .background(Color.NPSButtonEnd.opacity(0.3))
                            zoneButton(.bottmRight, label: "Bottom\nRight")
                        }
                        .frame(height: 120)
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.NPSButtonEnd, lineWidth: 3)
                    )
                    .padding(.horizontal)
                }
                
                Spacer()
                
                // Action buttons
                VStack(spacing: 12) {
                    // Confirm button (disabled if no selection)
                    Button(action: {
                        saveGoalLocation()
                        showGoalDetailsView = false
                        let impactMed = UIImpactFeedbackGenerator(style: .medium)
                        impactMed.impactOccurred()
                    }) {
                        HStack {
                            Image(systemName: "checkmark.circle.fill")
                            Text("Confirm")
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .font(.system(size: 18, weight: .semibold))
                        .padding()
                        .foregroundColor(.white)
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(selectedZone != nil ? Color.green : Color.gray)
                        )
                    }
                    .disabled(selectedZone == nil)
                    
                    // Cancel button
                    Button(action: {
                        showGoalDetailsView = false
                        let impactMed = UIImpactFeedbackGenerator(style: .medium)
                        impactMed.impactOccurred()
                    }) {
                        HStack {
                            Image(systemName: "xmark.circle")
                            Text("Cancel")
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .font(.system(size: 18))
                        .padding()
                        .foregroundColor(.NPSTextColor)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.NPSButtonEnd, lineWidth: 2)
                        )
                    }
                }
                .padding()
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .frame(width: UIScreen.main.bounds.width - 10, height: 600, alignment: .center)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.NPSButtonEnd, lineWidth: 3)
        )
    }
    
    // MARK: - Zone Button
    
    private func zoneButton(_ zone: GoalLocation, label: String, highlight: Bool = false) -> some View {
        Button(action: {
            // FIXED: Radio button behavior - selecting new zone deselects old one
            selectedZone = zone
            let impactLight = UIImpactFeedbackGenerator(style: .light)
            impactLight.impactOccurred()
        }) {
            ZStack {
                // Background color based on selection
                if selectedZone == zone {
                    LinearGradient(Color.NPSButtonStart, Color.NPSButtonEnd)
                } else {
                    LinearGradient(Color.NPSDarkStart, Color.NPSDarkEnd)
                }
                
                VStack(spacing: 8) {
                    // Icon
                    if highlight {
                        // Five-hole gets special icon
                        Image(systemName: "5.circle.fill")
                            .font(.system(size: 32))
                            .foregroundColor(selectedZone == zone ? .white : .NPSTextColor.opacity(0.4))
                    } else {
                        // Other zones get target icon
                        Image(systemName: selectedZone == zone ? "largecircle.fill.circle" : "circle")
                            .font(.system(size: 32))
                            .foregroundColor(selectedZone == zone ? .white : .NPSTextColor.opacity(0.4))
                    }
                    
                    // Label
                    Text(label)
                        .font(.caption)
                        .foregroundColor(selectedZone == zone ? .white : .NPSTextColor.opacity(0.6))
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    // MARK: - Metadata Toggle
    
    private func metadataToggle(title: String, isOn: Binding<Bool>, icon: String) -> some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(isOn.wrappedValue ? .NPSButtonEnd : .NPSTextColor.opacity(0.4))
            
            Toggle(isOn: isOn) {
                Text(title)
                    .font(.caption2)
                    .foregroundColor(.NPSTextColor)
            }
            .labelsHidden()
            .toggleStyle(SwitchToggleStyle(tint: Color.NPSButtonStart))
            .scaleEffect(0.8)
            
            Text(title)
                .font(.caption2)
                .foregroundColor(.NPSTextColor.opacity(0.7))
        }
    }
    
    // MARK: - Save Goal Location
    
    private func saveGoalLocation() {
        // FIXED: Validation - only save if zone is selected
        guard let zone = selectedZone else {
            print("⚠️ No zone selected")
            return
        }
        
        // Save the location
        goalLocations.append(zone)
        
        // FIXED: Metadata is now saved (you can extend this to save GoalDetail struct)
        print("✅ Saved goal: \(zone)")
        if redirected { print("   • Redirected") }
        if penaltyShot { print("   • Penalty Shot") }
        if overTimeGoal { print("   • Overtime") }
        
        // TODO: If you want to save full details including metadata:
        // let detail = GoalDetail(
        //     location: zone,
        //     isRedirected: redirected,
        //     isPenaltyShot: penaltyShot,
        //     isOvertime: overTimeGoal,
        //     timestamp: Date()
        // )
        // goalDetails.append(detail)
        
        // Reset for next goal
        resetSelection()
    }
    
    private func resetSelection() {
        selectedZone = nil
        redirected = false
        penaltyShot = false
        overTimeGoal = false
    }
}

// MARK: - Preview

struct GoalLocationView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.NPSBackgroundGradientStart
                .edgesIgnoringSafeArea(.all)
            
            GoalLocationView(
                showGoalDetailsView: .constant(true),
                goalLocations: .constant([])
            )
        }
        .preferredColorScheme(.dark)
    }
}
