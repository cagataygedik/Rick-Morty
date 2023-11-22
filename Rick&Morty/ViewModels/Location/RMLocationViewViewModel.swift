//
//  RMLocationViewViewModel.swift
//  Rick&Morty
//
//  Created by Celil Çağatay Gedik on 22.11.2023.
//

import Foundation

final class RMLocationViewViewModel {
    
    private var locations: [RMLocation] = []
    
    private var cellViewModels: [String] = []
    
    init() {}
    
    public func fetchLocations() {
        
    }
    
    private var hasMoreResults: Bool {
        return false
    }
}
