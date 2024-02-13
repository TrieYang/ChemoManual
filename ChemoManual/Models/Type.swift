//
//  Type.swift
//  ChemoManual
//
//  Created by Trie Yang on 2023-11-07.
//  Reference: NavigationCookBook - Experience.Swift

import SwiftUI

enum Type: Int, Identifiable, CaseIterable, Codable {
    var id: Int { rawValue }

    case exercise
    case diet
    case mentalHealth
    case sleep
    case beauty
    //case sideEffect

    var imageName: String {
        switch self {
        case .exercise: return "figure.run"
        case .diet: return "fork.knife"
        case .mentalHealth: return "brain.head.profile"
        case .sleep: return "powersleep"
        case .beauty: return "eyebrow"
            
        }
    }
    
    var dataBaseName: String {
        switch self {
        case .exercise: return "exercise"
        case .diet: return "diet"
        case .mentalHealth: return "mental health"
        case .sleep: return "sleep"
        case .beauty: return "beauty"
            
        }
    }
    
    var localizedName: LocalizedStringKey {
        switch self {
        case .exercise: return "Exercise"
        case .diet: return "Diet"
        case .mentalHealth: return "Mental Health"
        case .sleep: return "Sleep"
        case .beauty: return "Beauty"
        }
    }
    
    var localizedDescription: LocalizedStringKey {
        switch self {
        case .exercise:
            return "A good way to relieve side effects and mental stress to maintain life-treatment balance"
        case .diet:
            return "Learn how to keep a Well-planned diet that helps your recovery"
        case .mentalHealth:
            return "Mental health is an important factor of your treatment and it matters for overall well-beings"
        case .sleep:
            return "A good night sleep always make everything better"
        case .beauty:
            return "Some beauty tips to get you shine during treatment"
        }
    }
}


