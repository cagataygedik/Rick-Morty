//
//  RMLocationViewController.swift
//  Rick&Morty
//
//  Created by Celil Çağatay Gedik on 20.10.2023.
//

import UIKit

final class RMLocationViewController: UIViewController, RMLocationViewViewModelDelegate, RMLocationViewDelegate {
    
    private let primaryView = RMLocationView()
    
    private let viewModel = RMLocationViewViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        primaryView.delegate = self
        title = "Location"
        addSearchButton()
        setupView()
        viewModel.delegate = self
        viewModel.fetchLocations()
    }
    
    private func addSearchButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearchButton))
    }
    
    @objc private func didTapSearchButton() {
        
    }
    
    private func setupView() {
        view.addSubview(primaryView)
        NSLayoutConstraint.activate([
            primaryView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            primaryView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            primaryView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            primaryView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    func rmLocationView(_ locationView: RMLocationView, didSelect location: RMLocation) {
        let detailViewController = RMLocationDetailViewController(location: location)
        detailViewController.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    func didFetchInitialLocations() {
        primaryView.configure(with: viewModel)
    }
}
