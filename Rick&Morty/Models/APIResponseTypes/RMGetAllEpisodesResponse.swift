//
//  RMGetAllEpisodesResponse.swift
//  Rick&Morty
//
//  Created by Celil Çağatay Gedik on 13.11.2023.
//

import Foundation

struct RMGetAllEpisodesResponse: Codable {
    struct Info: Codable {
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
    }
    
    let info: Info
    let results: [RMEpisode]
}
