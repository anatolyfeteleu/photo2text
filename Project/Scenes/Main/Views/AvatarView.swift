//
//  AvatarView.swift
//  PhotoToText
//
//  Created by Анатолий Фетелеу on 28.03.2023.
//

import UIKit

class AvatarView: UIView {
    
    var personImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "personImage")!
        return imageView
    }()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    
    func setup() {
        bounds = CGRect(x: 0, y: 0, width: 32, height: 32)
        backgroundColor = UIColor(red: 0.949, green: 0.957, blue: 0.976, alpha: 1)
        layer.cornerRadius = min(frame.size.width / 2, frame.size.height / 2)
    }
    
    // MARK: - Private methods
    
    private func setupViews() {
        addSubview(personImageView)
    }
    
    private func setupConstraints() {
        personImageView.translatesAutoresizingMaskIntoConstraints = false
        let personImageViewConstraint = [
            personImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            personImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            personImageView.widthAnchor.constraint(equalToConstant: 10),
            personImageView.heightAnchor.constraint(equalToConstant: 10),
            personImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
        ]
        NSLayoutConstraint.activate(personImageViewConstraint)
    }

}
