//
//  RMCharacter.swift
//  Rick&Morty
//
//  Created by Celil Çağatay Gedik on 20.10.2023.
//

import Foundation

struct RMCharacter: Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: RMOrigin
    let location: RMSingleLocation
    let image: String
    let episode: [String]
    let url: String
    let created: String
}
