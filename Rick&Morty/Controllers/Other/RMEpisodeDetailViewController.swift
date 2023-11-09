//
//  RMEpisodeDetailViewController.swift
//  Rick&Morty
//
//  Created by Celil Çağatay Gedik on 9.11.2023.
//

import UIKit

final class RMEpisodeDetailViewController: UIViewController {
    
    private let url: URL?
    
    init(url: URL?) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Episode"
        view.backgroundColor = .systemBackground
    }
}
