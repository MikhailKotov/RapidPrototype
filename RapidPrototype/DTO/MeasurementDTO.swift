//
//  MeasurementsDTO.swift
//  RapidPrototype
//
//  Created by Mykhailo Kotov on 24/10/2024.
//

import Foundation
import SwiftUI

enum PressureMeasurementState {
    case normal
    case elevated
    case hbps1
    case hbps2
    case critical
    case wrongData

    var textColor: Color {
        switch self {
        case .normal: return .primaryText
        case .elevated: return .warningText
        default: return .criticalText
        }
    }
    var notificationBackgroundColor: Color {
        switch self {
        case .normal: return .clear
        case .elevated: return .warningBackground
        default: return .criticalBackground
        }
    }
    var notificationTextColor: Color {
        switch self {
        case .normal: return .clear
        case .elevated: return .warningNoteText
        default: return .criticalNoteText
        }
    }
    var alertBackgroundColor: Color {
        switch self {
        case .normal: return .clear
        case .elevated: return .warningAlert
        default: return .criticalAlert
        }
    }
    var chartColor: Color {
        switch self {
        case .normal: return .normalChart
        case .elevated: return .warningChart
        case .hbps1: return .warningChart2
        case .hbps2: return .warningChart3
        default: return .criticalChart
        }
    }
    var showAlert: Bool {
        self != .normal
    }
    var title: LocalizedStringKey {
        switch self {
        case .normal:
            return ""
        case .elevated:
            return "Warning"
        case .wrongData:
            return "Wrong data"
        default:
            return "Critical alert"
        }
    }
    var subtitle: LocalizedStringKey {
        switch self {
        case .normal:
            return "Normal"
        case .elevated:
            return "Elevated"
        case .hbps1:
            return "High Blood Pressure Stage 1"
        case .hbps2:
            return "High Blood Pressure Stage 2"
        case .critical:
            return "Hypertensive Crisis (dangerously high blood pressure - seek medical care right away"
        case .wrongData:
            return "wrong data"
        }
    }
}

struct MeasurementDTO: Identifiable, Equatable, Hashable {
    let id = UUID()
    let date: Date
    let systolic: Double?
    let diastolic: Double?
    let pulse: Double?

///    Normal    Less than 120    and    Less than 80
///    Elevated    120 - 129    and    Less than 80
///    High Blood Pressure Stage 1    130 - 139    or    80 - 89
///    High Blood Pressure Stage 2    140 or higher    or    90 or higher
///    Hypertensive Crisis (dangerously high blood pressure - seek medical care right away    Higher than 180    and    Higher than 120
    var state: PressureMeasurementState {
        guard let systolic, let diastolic else { return .wrongData }
        switch (systolic, diastolic) {
        case (1..<120.0, 1..<80.0): return .normal
        case (120.0..<129.0, 1..<80.0): return .elevated
        case (130.0..<139.0,_): return .hbps1
        case (_, 80.0..<89.0): return .hbps1
        case (180..<999.0, 120..<999.0): return .critical
        case (140.0..<999.0,_): return .hbps2
        case (_, 90.0..<999.0): return .hbps2
        default: return .wrongData
        }
    }

    var pair: LocalizedStringKey {
        guard let systolic, let diastolic else { return "n/a" }
        return "\(Int(systolic))/\(Int(diastolic))"
    }
}
