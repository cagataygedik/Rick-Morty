//
//  RMCharacterInfoCollectionViewViewModel.swift
//  Rick&Morty
//
//  Created by Celil Çağatay Gedik on 6.11.2023.
//

import Foundation

final class RMCharacterInfoCollectionViewCellViewModel {
    public let value: String
    public let title: String
    
    init (value: String, title: String) {
        self.value = value
        self.title = title
    }
}
