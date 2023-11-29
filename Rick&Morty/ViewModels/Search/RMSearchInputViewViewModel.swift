//
//  RMSearchInputViewViewModel.swift
//  Rick&Morty
//
//  Created by Celil Çağatay Gedik on 28.11.2023.
//

import Foundation

final class RMSearchInputViewViewModel {
    private let type: RMSearchViewController.Config.`Type`
    
    enum DynamicOption: String {
        case status = "Status"
        case gender = "Gender"
        case locationType = "Location Type"
        
        var queryArgument: String {
            switch self {
            case .status:
                return "status"
            case .gender:
                return "gender"
            case .locationType:
                return "type"
            }
        }
        
        var choices: [String] {
            switch self {
            case .status:
                return ["alive", "dead", "unknown"]
            case .gender:
                return ["male", "female", "genderless", "unknown"]
            case .locationType:
                return ["cluster", "planet", "microverse"]
            }
        }
    }
    
    init(type: RMSearchViewController.Config.`Type`) {
        self.type = type
    }
    
    public var hasDynamicOptions: Bool {
        switch self.type {
        case .character, .location:
            return true
        case .episode:
            return false
        }
    }
    
    public var options: [DynamicOption] {
        switch self.type {
        case .character:
            return [.status, .gender]
        case .episode:
            return []
        case .location:
            return [.locationType]
        }
    }
    
    public var searchPlaceholderText: String {
        switch self.type {
        case .character:
            return "Look For Characters"
        case .episode:
            return "Search For Episodes"
        case .location:
            return "Search locations"
        }
    }
}
