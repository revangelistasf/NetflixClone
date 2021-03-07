//
//  Movie.swift
//  NetflixClone
//
//  Created by Roberto Evangelista on 07/03/2021.
//

import Foundation

struct Movie: Decodable {
    var id: Int
    var originalLanguage: String
    var originalTitle: String
    var overview: String
    var releaseDate: String
    var title: String
    var voteAverage: Double
    var posterPath: String?
}
