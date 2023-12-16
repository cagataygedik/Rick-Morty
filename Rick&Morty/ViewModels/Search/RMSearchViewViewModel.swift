//
//  RMSearchViewViewModel.swift
//  Rick&Morty
//
//  Created by Celil Çağatay Gedik on 28.11.2023.
//

import Foundation

final class RMSearchViewViewModel {
    let config: RMSearchViewController.Config
    
    private var optionMap: [RMSearchInputViewViewModel.DynamicOption: String] = [:]
    private var optionMapUpdateBlock: (((RMSearchInputViewViewModel.DynamicOption, String)) -> Void)?
    private var searchText = ""
    private var searchResultHandler: ((RMSearchResultsViewModel) -> Void)?
    private var noResultsHandler: (() -> Void)?
    private var searchResultsModel: Codable?
    
    init(config: RMSearchViewController.Config) {
        self.config = config
    }
    
    public func registerSearchResultHandler(_ block: @escaping (RMSearchResultsViewModel) -> Void) {
        self.searchResultHandler = block
    }
    
    public func registerNoResultsHandler(_ block: @escaping () -> Void) {
        self.noResultsHandler = block
    }
    
    public func executeSearch() {
        guard !searchText.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        
        var queryParams: [URLQueryItem] = [URLQueryItem(name: "name", value: searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))]
        
        queryParams.append(contentsOf: optionMap.enumerated().compactMap({ _, element in
            let key: RMSearchInputViewViewModel.DynamicOption = element.key
            let value: String = element.value
            return URLQueryItem(name: key.queryArgument, value: value)
        }))
        
        let request = RMRequest(endpoint: config.type.endpoint, queryParameters: queryParams)
        
        switch config.type.endpoint {
        case .character:
            makeSearchAPICall(RMGetAllCharactersResponse.self, request: request)
        case .location:
            makeSearchAPICall(RMGetAllLocationsResponse.self, request: request)
        case .episode:
            makeSearchAPICall(RMGetAllEpisodesResponse.self, request: request)
        }
    }
    
    private func makeSearchAPICall<T: Codable>(_ type: T.Type, request: RMRequest) {
        RMService.shared.execute(request, expecting: type) { [weak self] result in
            switch result {
            case .success(let model):
                self?.processSearchResults(model: model)
            case .failure:
                self?.handleNoResults()
                break
            }
        }
    }
    
    private func processSearchResults(model: Codable) {
        var resultsViewModel: RMSearchResultsViewModel?
        
        if let characterResults = model as? RMGetAllCharactersResponse {
            resultsViewModel = .characters(characterResults.results.compactMap({
                return RMCharacterCollectionViewCellViewModel(characterName: $0.name, characterStatus: $0.status, characterImageUrl: URL(string: $0.image))
            }))
        }
        
        else if let episodesResults = model as? RMGetAllEpisodesResponse {
            resultsViewModel = .episodes(episodesResults.results.compactMap({
                return RMCharacterEpisodeCollectionViewCellViewModel(episodeDataUrl: URL(string: $0.url))
            }))
        }
        
        else if let locationResults = model as? RMGetAllLocationsResponse {
            resultsViewModel = .locations(locationResults.results.compactMap({
                return RMLocationTableViewCellViewModel(location: $0)
            }))
        }
        
        if let results = resultsViewModel {
            self.searchResultsModel = model
            self.searchResultHandler?(results)
        } else {
            handleNoResults()
        }
    }
    
    private func handleNoResults() {
        noResultsHandler?()
    }
    
    public func set(query text: String) {
        self.searchText = text
    }
    
    public func set(value: String, for option: RMSearchInputViewViewModel.DynamicOption) {
        optionMap[option] = value
        let tuple = (option, value)
        optionMapUpdateBlock?(tuple)
    }
    
    public func registerOptionChangeBlock(_ block: @escaping ((RMSearchInputViewViewModel.DynamicOption, String)) -> Void) {
        self.optionMapUpdateBlock = block
    }
    
    public func locationSearchResult(at index: Int) -> RMLocation? {
        guard let searchModel = searchResultsModel as? RMGetAllLocationsResponse else {
            return nil
        }
        return searchModel.results[index]
    }
}
