//
//  RMLocationViewViewModel.swift
//  Rick&Morty
//
//  Created by Celil Çağatay Gedik on 22.11.2023.
//

import Foundation

protocol RMLocationViewViewModelDelegate: AnyObject {
    func didFetchInitialLocations()
}

final class RMLocationViewViewModel {
    
    weak var delegate: RMLocationViewViewModelDelegate?
    
    private var locations: [RMLocation] = [] {
        didSet {
            for location in locations {
                let cellViewModel = RMLocationTableViewCellViewModel(location: location)
                if !cellViewModels.contains(cellViewModel) {
                    cellViewModels.append(cellViewModel)
                }
            }
        }
    }
    
    public private(set) var cellViewModels: [RMLocationTableViewCellViewModel] = []
    
    private var apiInfo: RMGetAllLocationsResponse.Info?
    
    init() {}
    
    public func location(at index: Int) -> RMLocation? {
            guard index < locations.count, index >= 0 else {
                return nil
            }
            return self.locations[index]
        }
    
    public func fetchLocations() {
        RMService.shared.execute(.listLocationsRequest, expecting: RMGetAllLocationsResponse.self) { [weak self] result in
            switch result {
            case .success(let model):
                self?.apiInfo = model.info
                self?.locations = model.results
                DispatchQueue.main.async {
                    self?.delegate?.didFetchInitialLocations()
                }
            case .failure(let error):
                break
            }
        }
    }
    
    private var hasMoreResults: Bool {
        return false
    }
}
