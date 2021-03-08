//
//  ViewController.swift
//  NetflixClone
//
//  Created by Roberto Evangelista on 06/03/2021.
//

import UIKit

protocol MovieCatalogViewControllerDelegate: class {
    func didOpenDetailsFrom(selectedMovie: Movie)
    func didOpenAlert()
}

class MovieCatalogViewController: UIViewController {
    
    var viewModel: MovieCatalogViewModelProtocol?
    private let heightForARow: CGFloat = 175
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        view.addSubview(tableView)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .black
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.register(
            MovieCategorieTableViewCell.self, forCellReuseIdentifier: MovieCategorieTableViewCell.reusableID)
        
        return tableView
    }()
    
    convenience init(viewModel: MovieCatalogViewModelProtocol) {
        self.init()
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.delegate = self
        configureView()
        configureTableView()
        viewModel?.fetchPageFromMovieCatalog()

    }
    
    private func configureView() {
        let appearance = UINavigationBarAppearance()
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.systemRed]
        appearance.titleTextAttributes = [.foregroundColor: UIColor.systemRed]
        appearance.backgroundColor = .black
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Movieflix"
        
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.prefetchDataSource = self
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        self.tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.bounds.size.width, height: 40))
        self.tableView.contentInset = UIEdgeInsets(top: -40, left: 0, bottom: 0, right: 0)
    }
    
}

extension MovieCatalogViewController: MovieCatalogViewModelDelegate {
    func movieCatalogDidFinishFetch() {
        self.tableView.reloadData()
    }
}

extension MovieCatalogViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        viewModel?.fetchNextPageIfNeeded(indexPaths)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.actualPage - 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 40))
        let label = UILabel()
        label.textColor = .white
        label.font = .preferredFont(forTextStyle: .title3)
        label.text = viewModel?.getSectionName(section: section)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 4),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: MovieCategorieTableViewCell.reusableID) as! MovieCategorieTableViewCell
        
        if let movieSection = viewModel?.movieSection(from: indexPath) {
            cell.delegate = self
            cell.movies = movieSection
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightForARow
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height + 30

        if offsetY > contentHeight - height {
            self.viewModel?.fetchPageFromMovieCatalog()
        }
    }
}

extension MovieCatalogViewController: MovieCatalogViewControllerDelegate {
    func didOpenDetailsFrom(selectedMovie: Movie) {
        let movieDetailsViewModel = MovieDetailsViewModel()
        movieDetailsViewModel.selectedMovie = selectedMovie
        let destinationController = MovieDetailsViewController(viewModel: movieDetailsViewModel)
        present(destinationController, animated: true, completion: nil)
    }
    
    func didOpenAlert() {
        let alert = UIAlertController(title: "This is a Bad Movie",
                                      message: "Don't waste your time watching this",
                                      preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok :(", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
