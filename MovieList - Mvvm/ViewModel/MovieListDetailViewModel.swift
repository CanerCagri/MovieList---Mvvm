//
//  MovieListDetailViewModel.swift
//  MovieList - Mvvm
//
//  Created by Caner Çağrı on 28.06.2022.
//

import Foundation

class MovieListDetailViewModel: MovieListDetailProtocol {
    var delegate: MovieListDetailDelegate?
    var movieService = Service()
    
    var movie : SingleMovie?
    func loadData(id: Int, lang: String) {
        movieService.getMovieDetails(id: id, lang: lang) { movie in
            self.delegate?.handleViewModelOutput(movie!)
        }
    }
}
