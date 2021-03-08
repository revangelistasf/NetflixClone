//
//  MovieDetailsViewController.swift
//  NetflixClone
//
//  Created by Roberto Evangelista on 08/03/2021.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    private lazy var movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = false
        view.addSubview(imageView)
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title1)
        label.numberOfLines = 2
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        return label
    }()
    
    private lazy var overviewLabel: UILabel = {
       let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        return label
    }()
    
    private lazy var voteAverageLabel: UILabel = {
       let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.numberOfLines = 1
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        return label
    }()
    
    private lazy var releaseDateLabel: UILabel = {
       let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.numberOfLines = 1
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        return label
    }()
    
    
    
    var viewModel: MovieDetailsViewModelProtocol?
    
    convenience init(viewModel: MovieDetailsViewModelProtocol) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        fillFields(with: viewModel!.selectedMovie!)
    }
    
    private func configureView() {
        view.backgroundColor = .black
        configureNavigationBar()
        configureMovieImageView()
        configureLabel()
    }
    
    private func configureNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.systemRed]
        appearance.titleTextAttributes = [.foregroundColor: UIColor.systemRed]
        appearance.backgroundColor = .black
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.tintColor = .systemRed
        title = "Details"
    }
    
    func fillFields(with movie: Movie) {
        let api = TMDBAPI.poster(endpoint: movie.posterPath ?? "")
        movieImageView.loadImageFromUrl(api.url) {}
        titleLabel.text = movie.title
        overviewLabel.text = movie.overview
        voteAverageLabel.text = "Vote Average: \(movie.voteAverage)/10"
        releaseDateLabel.text = "Release Date: \(movie.releaseDate ?? "--/--/----")"
    }
    
    private func configureMovieImageView() {
        NSLayoutConstraint.activate([
            movieImageView.heightAnchor.constraint(equalToConstant: 256),
            movieImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            movieImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            movieImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func configureLabel() {
        let padding: CGFloat = 16
        let insetSize: CGFloat = 8
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            
            overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: insetSize),
            overviewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            overviewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            
            voteAverageLabel.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: insetSize),
            voteAverageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            voteAverageLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            
            releaseDateLabel.topAnchor.constraint(equalTo: voteAverageLabel.bottomAnchor, constant: insetSize),
            releaseDateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            releaseDateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
        ])
    }
    
}


