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
        tableView.backgroundColor = .clear
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
        viewModel?.fetchMovieCatalog()
        configureView()
        configureTableView()
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
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}

extension MovieCatalogViewController: MovieCatalogViewModelDelegate {
    func movieCatalogDidFinishFetch() {
        self.tableView.reloadData()
    }
}

extension MovieCatalogViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.actualPage ?? 0
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
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            self.viewModel?.fetchMovieCatalog()
        }
    }
}

extension MovieCatalogViewController: MovieCatalogViewControllerDelegate {
    func didOpenDetailsFrom(selectedMovie: Movie) {
        print("ae")
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
