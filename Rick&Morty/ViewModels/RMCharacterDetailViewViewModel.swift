//
//  RMCharacterDetailViewViewModel.swift
//  Rick&Morty
//
//  Created by Celil Çağatay Gedik on 30.10.2023.
//

import Foundation

final class RMCharacterDetailViewViewModel {
    private let character: RMCharacter
    
    init(character: RMCharacter) {
        self.character = character
    }
    
    public var requestUrl: URL? {
        return URL(string: character.url)
    }
    
    public var title: String {
        character.name.uppercased()
    }
}
