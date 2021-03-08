//
//  MovieCatalogViewModel.swift
//  NetflixClone
//
//  Created by Roberto Evangelista on 07/03/2021.
//

import Foundation

protocol MovieCatalogViewModelDelegate: class {
    func movieCatalogDidFinishFetch()
}

protocol MovieCatalogViewModelProtocol {
    var delegate: MovieCatalogViewModelDelegate? { get set }
    var service: MovieCatalogServiceProtocol { get set }
    var actualPage: Int { get set }
    func fetchPageFromMovieCatalog()
    func getSectionName(section: Int) -> String
    func fetchNextPageIfNeeded(_ indexPaths: [IndexPath]) -> Bool
    func movieSection(from indexPath: IndexPath) -> [Movie]?
}

class MovieCatalogViewModel: MovieCatalogViewModelProtocol {
    weak var delegate: MovieCatalogViewModelDelegate?
    var service: MovieCatalogServiceProtocol
    var actualPage: Int = 1
    let dispatchGroup = DispatchGroup()
    private var sectionName: [String] = []
    private var movieCatalog: [Int: [Movie]] = [:]
    
    init(service: MovieCatalogService = MovieCatalogService()) {
        self.service = service
    }
    
    func movieSection(from indexPath: IndexPath) -> [Movie]? {
        let section = indexPath.section + 1
        return movieCatalog[section]
    }
    
    func fetchPageFromMovieCatalog() {
        service.fetchMovieCatalog(actualPage: actualPage) { [weak self] result in
            guard let self = self else { return }
            self.handleFetchMovieCatalog(with: result)
        }
    }
    
    func fetchNextPageIfNeeded(_ indexPaths: [IndexPath]) -> Bool {
        if let lastIndexPath = indexPaths.last, lastIndexPath.row > actualPage {
            fetchPageFromMovieCatalog()
            return true
        }
        
        return false
    }
    
    func getSectionName(section: Int) -> String {
        return sectionName[section]
    }
    
    func numberOfSections() -> Int {
        return actualPage
    }
    
    private func handleFetchMovieCatalogWithoutNotify(with result: Result<TMDBMovieResponse, NetworkError>) {
        switch result {
        case .success(let response):
            let movieList = response.results
            self.movieCatalog[response.page!] = movieList
            self.actualPage += 1
        case .failure(let networkError):
            print(networkError)
            break
        }
        self.dispatchGroup.leave()
    }
    
    private func handleFetchMovieCatalog(with result: Result<TMDBMovieResponse, NetworkError>) {
        switch result {
        case .success(let response):
            let movieList = response.results
            self.movieCatalog[response.page!] = movieList
            sectionName.append(SectionNameGenerator.names.randomElement()!)
            self.actualPage += 1
        case .failure(let networkError):
            print(networkError)
            break
        }
        
        self.delegate?.movieCatalogDidFinishFetch()
    }
    
}
