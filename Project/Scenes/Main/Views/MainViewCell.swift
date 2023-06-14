//
//  MainViewCell.swift
//  PhotoToText
//
//  Created by Анатолий Фетелеу on 23.03.2023.
//

import Foundation
import UIKit


class MainViewCell: UITableViewCell {
    
    var labelView: UILabel = {
        let label = UILabel()
        return label
    }()
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    
    func setLabelViewText(_ text: String) {
        labelView.text = text
    }
    
    // MARK: - Private methods
    
    private func setup() {
        clipsToBounds = true
        layer.borderWidth = 0
    }
        
    private func setupViews() {
        addSubview(labelView)
    }
    
    private func setupConstraints() {
        labelView.translatesAutoresizingMaskIntoConstraints = false
        let labelViewConstraints = [
            labelView.topAnchor.constraint(equalTo: topAnchor),
            labelView.bottomAnchor.constraint(equalTo: bottomAnchor),
            labelView.rightAnchor.constraint(equalTo: rightAnchor),
            labelView.leftAnchor.constraint(equalTo: leftAnchor),
            labelView.heightAnchor.constraint(equalTo: heightAnchor),
            labelView.widthAnchor.constraint(equalTo: widthAnchor)
        ]
        NSLayoutConstraint.activate(labelViewConstraints)
    }
        
}
