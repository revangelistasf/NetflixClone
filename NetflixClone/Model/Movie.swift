//
//  Movie.swift
//  NetflixClone
//
//  Created by Roberto Evangelista on 07/03/2021.
//

import Foundation

struct TMDBMovieResponse: Decodable {
    var results: [Movie]?
    var statusCode: Int?
    var statusMessage: String?
    var success: Bool?
    var page: Int?
    var totalPages: Int?
    var totalResults: Int?
}

struct Movie: Decodable, Hashable {
    var id: Int
    var originalLanguage: String
    var originalTitle: String
    var overview: String
    var releaseDate: String?
    var title: String
    var voteAverage: Double
    var posterPath: String?
    
    func isAGoodMovie() -> Bool {
        return voteAverage >= AppConstants.minRate
    }
}
