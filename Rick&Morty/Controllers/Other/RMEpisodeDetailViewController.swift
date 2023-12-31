//
//  RMEpisodeDetailViewController.swift
//  Rick&Morty
//
//  Created by Celil Çağatay Gedik on 9.11.2023.
//

import UIKit

final class RMEpisodeDetailViewController: UIViewController ,RMEpisodeDetailViewViewModelDelegate, RMEpisodeDetailViewDelegate{
    private let viewModel: RMEpisodeDetailViewViewModel
    
    private let detailView = RMEpisodeDetailView()
    
    init(url: URL?) {
        self.viewModel = RMEpisodeDetailViewViewModel(endpointUrl: url)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Episode"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapShareButton))
        addConstraints()
        detailView.delegate = self
        viewModel.delegate = self
        viewModel.fetchEpisodeData()
    }
    
    @objc private func didTapShareButton() {
        
    }
    
    private func addConstraints() {
        view.addSubview(detailView)
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            detailView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func rmEpisodeDetailView(_ detailView: RMEpisodeDetailView, didSelect character: RMCharacter) {
        let viewController = RMCharacterDetailViewController(viewModel: .init(character: character))
        viewController.title = character.name
        viewController.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func didFetchEpisodeDetails() {
        detailView.configure(with: viewModel)
    }
}
