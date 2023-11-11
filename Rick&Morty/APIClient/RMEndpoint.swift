//
//  RMEndpoint.swift
//  Rick&Morty
//
//  Created by Celil Çağatay Gedik on 23.10.2023.
//

import Foundation

@frozen enum RMEndpoint: String, CaseIterable, Hashable {
    case character
    case location
    case episode
}
