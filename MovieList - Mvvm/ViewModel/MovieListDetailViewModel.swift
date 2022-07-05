//
//  MovieListDetailViewModel.swift
//  MovieList - Mvvm
//
//  Created by Caner Çağrı on 28.06.2022.
//

import Foundation

class MovieListDetailViewModel: MovieListDetailProtocols {
    var delegate: MovieListDetailDelegate?
    var movieService = Service()
    
    var movie : SingleMovie?
    func loadData(id: Int) {
        movieService.getMovieDetails(id: id) { movie in
            self.delegate?.handleViewModelOutput(movie)
        }
    }
}
