//
//  AnalyticsManager.swift
//  chatCat
//
//  Created by admin1 on 7.08.23.
//

import Foundation
import FirebaseAnalytics

/// Manager to handle app analytics
final class AnalyticsManager {
    private init() {}
    
    static let shared = AnalyticsManager()
    
    public func log(_ event: AnalyticsEvent) {
        var paramets: [String: Any] = [:]
        switch event {
        case .characterSelected(let catCharacterSelectedEvent):
            do {
                let data = try JSONEncoder().encode(catCharacterSelectedEvent)
                let dict = try JSONSerialization.jsonObject(with: data) as? [String: Any] ?? [:]
                paramets = dict
            } catch {
                
            }
        }
        
        print("\n Event: \(event.eventName) | Params: \(paramets)")
        
        Analytics.logEvent(event.eventName,
                           parameters: paramets)
    }
}

enum AnalyticsEvent {
    case characterSelected(CATCharacterSelectedEvent)
    
    var eventName: String {
        switch self {
        case.characterSelected: return "character_selected"
        }
    }
}

struct CATCharacterSelectedEvent: Codable {
    let name: String
    let origin: String
    let timestamp: Data
}
