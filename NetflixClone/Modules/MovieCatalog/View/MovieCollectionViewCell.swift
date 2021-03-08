//
//  MovieCollectionViewCell.swift
//  NetflixClone
//
//  Created by Roberto Evangelista on 07/03/2021.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    lazy var movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    static let reusableID = "MovieCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        contentView.layer.shadowRadius = 0
    }
    
    private func configureView() {
        let padding: CGFloat = 4
        contentView.addSubview(movieImageView)
        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            movieImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            movieImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            movieImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding)
        ])
    }
    
    func goodQualityMovieLayout() {
        contentView.layer.shadowColor = UIColor.systemRed.cgColor
        contentView.layer.shadowOpacity = 0.75
        contentView.layer.shadowOffset = .zero
        contentView.layer.shadowRadius = 7
    }    
    
}
