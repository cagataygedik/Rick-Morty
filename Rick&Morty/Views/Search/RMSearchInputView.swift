//
//  RMSearchInputView.swift
//  Rick&Morty
//
//  Created by Celil Çağatay Gedik on 28.11.2023.
//

import UIKit

protocol RMSearchInputViewDelegate: AnyObject {
    func rmSearchInputView(_ inputView: RMSearchInputView, didSelectOption option: RMSearchInputViewViewModel.DynamicOption)
    
    func rmSearchInputView(_ inputView: RMSearchInputView, didChangeSearchText text: String)
    
    func rmSearchInputViewDidTapSearchKeyboardButton(_ inputView: RMSearchInputView)
}

final class RMSearchInputView: UIView {
    
    weak var delegate: RMSearchInputViewDelegate?
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Search"
        return searchBar
    }()
    
    private var viewModel: RMSearchInputViewViewModel? {
        didSet {
            guard let viewModel = viewModel, viewModel.hasDynamicOptions else {
                return
            }
            let options = viewModel.options
            createOptionSelectionViews(options: options)
        }
    }
    
    private var stackView: UIStackView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews()
        addConstraints()
        searchBar.delegate = self
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: topAnchor),
            searchBar.leftAnchor.constraint(equalTo: leftAnchor),
            searchBar.rightAnchor.constraint(equalTo: rightAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 58)
        ])
    }
    
    private func createOptionStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 6
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 4),
            stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -4),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        return stackView
    }
    
    private func createOptionButtonView(with options: RMSearchInputViewViewModel.DynamicOption, tag: Int) -> UIButton {
        let button = UIButton()
        button.setAttributedTitle(NSAttributedString(string: options.rawValue, attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .medium), .foregroundColor: UIColor.label]), for: .normal)
        button.backgroundColor = .secondarySystemFill
        button.tag = tag
        button.layer.cornerRadius = 6
        button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
        return button
    }
    
    @objc private func didTapButton(_ sender: UIButton) {
        guard let options = viewModel?.options else {
            return
        }
        let tag = sender.tag
        let selected = options[tag]
        delegate?.rmSearchInputView(self, didSelectOption: selected)
    }
    
    private func createOptionSelectionViews(options: [RMSearchInputViewViewModel.DynamicOption]) {
        let stackView = createOptionStackView()
        self.stackView = stackView
        for x in 0..<options.count {
            let option = options[x]
            let button = createOptionButtonView(with: option, tag: x)
            stackView.addArrangedSubview(button)
        }
    }
    
    private func addSubviews() {
        addSubview(searchBar)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with viewModel: RMSearchInputViewViewModel) {
        searchBar.placeholder = viewModel.searchPlaceholderText
        self.viewModel = viewModel
    }
    
    public func presentKeyboard() {
        searchBar.becomeFirstResponder()
    }
    
    public func update(option: RMSearchInputViewViewModel.DynamicOption,value: String) {
        guard let buttons = stackView?.arrangedSubviews as? [UIButton],
              let allOptions = viewModel?.options,
              let index = allOptions.firstIndex(of: option) else {
            return
        }
        buttons[index].setAttributedTitle(NSAttributedString(string: value.uppercased(), attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .medium), .foregroundColor: UIColor.systemGreen]), for: .normal)
    }
}

extension RMSearchInputView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        delegate?.rmSearchInputView(self, didChangeSearchText: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        delegate?.rmSearchInputViewDidTapSearchKeyboardButton(self)
    }
}
