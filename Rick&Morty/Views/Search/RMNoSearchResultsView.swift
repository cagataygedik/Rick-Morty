//
//  RMNoSearchResultsView.swift
//  Rick&Morty
//
//  Created by Celil Çağatay Gedik on 28.11.2023.
//

import UIKit

class RMNoSearchResultsView: UIView {
    private let viewModel = RMNoSearchResultsViewViewModel()
    
    private let iconView: UIImageView = {
        let iconView = UIImageView()
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.contentMode = .scaleAspectFit
        iconView.tintColor = .systemGreen
        return iconView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        isHidden = true
        addSubviews()
        addConstraints()
        configure()
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            iconView.topAnchor.constraint(equalTo: topAnchor),
            iconView.centerXAnchor.constraint(equalTo: centerXAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 90),
            iconView.heightAnchor.constraint(equalToConstant: 90),
            
            label.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: 10),
            label.leftAnchor.constraint(equalTo: leftAnchor),
            label.rightAnchor.constraint(equalTo: rightAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    private func addSubviews() {
        addSubview(iconView)
        addSubview(label)
    }
    
    private func configure() {
        label.text = viewModel.title
        iconView.image = viewModel.image
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
