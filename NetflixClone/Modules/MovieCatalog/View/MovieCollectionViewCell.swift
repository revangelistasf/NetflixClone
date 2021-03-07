//
//  MovieCollectionViewCell.swift
//  NetflixClone
//
//  Created by Roberto Evangelista on 07/03/2021.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    static let reusableID = "MovieCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        backgroundColor = .systemBlue
    }
    
}
