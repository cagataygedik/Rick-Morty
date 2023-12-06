//
//  RMSearchResultsViewModel.swift
//  Rick&Morty
//
//  Created by Celil Çağatay Gedik on 4.12.2023.
//

import Foundation

enum RMSearchResultsViewModel {
    case characters([RMCharacterCollectionViewCellViewModel])
    case episodes([RMCharacterEpisodeCollectionViewCellViewModel])
    case locations([RMLocationTableViewCellViewModel])
}
