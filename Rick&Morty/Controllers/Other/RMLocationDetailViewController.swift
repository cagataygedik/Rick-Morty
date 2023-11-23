//
//  RMLocationDetailViewController.swift
//  Rick&Morty
//
//  Created by Celil Çağatay Gedik on 23.11.2023.
//

import UIKit

final class RMLocationDetailViewController: UIViewController {
    private let location: RMLocation
    
    init(location: RMLocation) {
        self.location = location
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Location"
        view.backgroundColor = .systemBackground
    }
}
