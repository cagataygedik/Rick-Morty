//
//  RMSearchViewController.swift
//  Rick&Morty
//
//  Created by Celil Çağatay Gedik on 13.11.2023.
//

import UIKit

final class RMSearchViewController: UIViewController {
    
    struct Config {
        enum `Type` {
            case character
            case episode
            case location
            
            var endpoint: RMEndpoint {
                switch self {
                case .character: return .character
                case .episode: return .episode
                case .location: return .location
                }
            }
            
            var title: String {
                switch self {
                case .character:
                    return "Search Character"
                case .episode:
                    return "Search Episode"
                case .location:
                    return "Search Location"
                }
            }
        }
        let type: `Type`
    }
    
    private let searchView: RMSearchView
    private let viewModel: RMSearchViewViewModel

    init(config: Config) {
        let viewModel = RMSearchViewViewModel(config: config)
        self.viewModel = viewModel
        self.searchView = RMSearchView(frame: .zero, viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = viewModel.config.type.title
        addConstraints()
        addSearchButton()
        searchView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        searchView.presentKeyboard()
    }
    
    private func addSearchButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Search", style: .done, target: self, action: #selector(didTapExecuteSearch))
    }
    
    @objc private func didTapExecuteSearch() {
        viewModel.executeSearch()
    }
    
    private func addConstraints() {
        view.addSubview(searchView)
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            searchView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            searchView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension RMSearchViewController: RMSearchViewDelegate {
    func rmSearchView(_ searchView: RMSearchView, didSelectOption option: RMSearchInputViewViewModel.DynamicOption) {
        
        let optionPickerViewController = RMSearchOptionPickerViewController(option: option) { [weak self] selection in
            DispatchQueue.main.async {
                self?.viewModel.set(value: selection, for: option)
            }
        }
        optionPickerViewController.sheetPresentationController?.detents = [.medium()]
        optionPickerViewController.sheetPresentationController?.prefersGrabberVisible = true
        present(optionPickerViewController, animated: true)
    }
    
    func rmSearchView(_ searchView: RMSearchView, didSelectLocation location: RMLocation) {
        let viewController = RMLocationDetailViewController(location: location)
        viewController.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(viewController, animated: true)
    }
}
