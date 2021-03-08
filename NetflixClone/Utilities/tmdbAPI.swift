//
//  tmdbAPI.swift
//  NetflixClone
//
//  Created by Roberto Evangelista on 07/03/2021.
//

import Foundation

enum TMDBAPI {
    
    case movieSection(page: Int)
    case poster(endpoint: String)
    
    private var baseURL: String {
        switch self {
        case .movieSection:
            return "https://api.themoviedb.org/3/discover/movie"
        case .poster(let endpoint):
            return "https://image.tmdb.org/t/p/w500\(endpoint)"
        }
    }
    
    var url: URL {
        return URL(string: baseURL)!
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .movieSection(let section):
            return [URLQueryItem(name: "page", value: String(section)),
                    URLQueryItem(name: "api_key", value: AppConstants.apiKey)]
        default:
            return nil
        }
    }
    
}
