//
//  MovieCategorieTableViewCell.swift
//  NetflixClone
//
//  Created by Roberto Evangelista on 06/03/2021.
//

import UIKit

class MovieCategorieTableViewCell: UITableViewCell, UICollectionViewDelegateFlowLayout {
    
    weak var delegate: MovieCatalogViewControllerDelegate!
    var movies: [Movie]? {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    var selectedImageView: UIImageView?
        
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        contentView.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.reusableID)
        
        return collectionView
    }()
    
    static let reusableID = "MovieCategorieTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        backgroundColor = .clear
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            collectionView.heightAnchor.constraint(equalToConstant: 170)
        ])
    }
    
}

extension MovieCategorieTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MovieCollectionViewCell.reusableID, for: indexPath) as! MovieCollectionViewCell
        
        guard let movies = self.movies else { return UICollectionViewCell() }
        let selectedMovie = movies[indexPath.row]
        let api = TMDBAPI.poster(endpoint: selectedMovie.posterPath ?? "")
        cell.movieImageView.loadImageFromUrl(api.url) {
            collectionView.reloadItems(at: [indexPath])
        }
        
        if selectedMovie.isAGoodMovie() {
            cell.goodQualityMovieLayout()
        } 
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movies = self.movies else { return }
        let selectedMovie = movies[indexPath.row]
        
        if selectedMovie.isAGoodMovie() {
            self.delegate.didOpenDetailsFrom(selectedMovie: selectedMovie)
        } else {
            self.delegate.didOpenAlert()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 125, height: 175)
    }
}
