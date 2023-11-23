//
//  RMLocationTableViewCellViewModel.swift
//  Rick&Morty
//
//  Created by Celil Çağatay Gedik on 22.11.2023.
//

import Foundation

struct RMLocationTableViewCellViewModel: Hashable, Equatable {
    private let location: RMLocation
    
    init(location: RMLocation) {
        self.location = location
    }
    
    public var name: String {
        return location.name
    }
    
    public var type: String {
        return "Type: "+location.type
    }
    
    public var dimenson: String {
        return "Dimension: "+location.dimension
    }
    
    static func == (lhs: RMLocationTableViewCellViewModel, rhs: RMLocationTableViewCellViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(location.id)
        hasher.combine(dimenson)
        hasher.combine(type)
    }
    
}
