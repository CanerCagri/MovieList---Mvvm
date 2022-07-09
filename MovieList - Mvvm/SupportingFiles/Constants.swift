//
//  Constants.swift
//  MovieList - Mvvm
//
//  Created by Caner Çağrı on 4.07.2022.
//

import Foundation


struct Constants {
    static let movieApi = "https://api.themoviedb.org/3/movie/popular?api_key=16b57169954864f01854a6d42dbd2234&language=en-US&page="
    static let baseUrl = "https://api.themoviedb.org/3/movie/"
    static let imageBaseUrl = "https://image.tmdb.org/t/p/w500"
    static let apiKey = "?api_key=16b57169954864f01854a6d42dbd2234&61604"
    static let tableViewTitle = "Movie List"
    static let identifier = "cell"
    static let trInfo = "&language=tr-TR"
    static let tr = "TR"
    static let en = "EN"
    static let enInfo = "&language=en-US"
    static var pickerViewLanguagues = ["EN", "TR"]
    static var defaultPicker = "EN"
}
