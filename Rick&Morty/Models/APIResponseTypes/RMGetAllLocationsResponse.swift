//
//  RMGetAllLocationsResponse.swift
//  Rick&Morty
//
//  Created by Celil Çağatay Gedik on 22.11.2023.
//

import Foundation

struct RMGetAllLocationsResponse: Codable {
    struct Info: Codable {
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
    }
    
    let info: Info
    let results: [RMLocation]
}
