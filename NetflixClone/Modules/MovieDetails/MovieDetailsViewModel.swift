//
//  MovieDetailsViewModel.swift
//  NetflixClone
//
//  Created by Roberto Evangelista on 08/03/2021.
//

import Foundation

protocol MovieDetailsViewModelProtocol {
    var selectedMovie: Movie? { get set }
}

class MovieDetailsViewModel: MovieDetailsViewModelProtocol {
    
    var selectedMovie: Movie?
    
}
