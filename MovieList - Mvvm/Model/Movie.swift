//
//  Movie.swift
//  MovieList - Mvvm
//
//  Created by Caner Çağrı on 23.06.2022.
//

import Foundation
import UIKit


// MARK: - MovieList
struct MovieList: Codable {
    let page: Int
    let results: [Result]
    let totalPages, totalResults: Int

}

// MARK: - Result
struct Result: Codable {
    let adult: Bool
    let backdropPath: String
    let genreIDS: [Int]
    let id: Int
    let originalTitle, overview: String
    let popularity: Double
    let posterPath, releaseDate, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

}

