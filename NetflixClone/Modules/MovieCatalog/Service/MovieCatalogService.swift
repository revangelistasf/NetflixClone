//
//  MovieCatalogService.swift
//  NetflixClone
//
//  Created by Roberto Evangelista on 07/03/2021.
//

import Foundation

protocol MovieCatalogServiceProtocol {
    func fetchMovieCatalog(actualPage: Int, completion: @escaping (Result<TMDBMovieResponse, NetworkError>) -> Void)
}

class MovieCatalogService: MovieCatalogServiceProtocol {
    private var totalPages: Int = 1
    
    func fetchMovieCatalog(actualPage: Int, completion: @escaping (Result<TMDBMovieResponse, NetworkError>) -> Void) {
        guard actualPage <= totalPages else { return }
        
        let api = TMDBAPI.movieSection(page: actualPage)
        var urlComponents = URLComponents(url: api.url, resolvingAgainstBaseURL: false)!
        urlComponents.queryItems = api.queryItems
        
        guard let url = urlComponents.url else {
            completion(.failure(.invalidUrl))
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error {
                DispatchQueue.main.async {
                    completion(.failure(.invalidResponse))
                }
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                DispatchQueue.main.async {
                    completion(.failure(.invalidResponse))
                }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(.invalidResponse))
                }
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let result = try decoder.decode(TMDBMovieResponse.self, from: data)
                self.totalPages = result.totalPages!
                DispatchQueue.main.async {
                    completion(.success(result))
                }
            } catch(let error) {
                DispatchQueue.main.async {
                    print(error)
                    completion(.failure(.invalidResponse))
                }
            }
        }
        
        dataTask.resume()
    }
}
