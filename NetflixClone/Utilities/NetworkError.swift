//
//  NetworkError.swift
//  NetflixClone
//
//  Created by Roberto Evangelista on 07/03/2021.
//

import Foundation

enum NetworkError: String, Error {
    case invalidUrl = "Invalid URL please check again later"
    case invalidResponse = "Invalid response from server. Please try again."
}
