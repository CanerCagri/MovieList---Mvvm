//
//  MovieListViewModel.swift
//  MovieList - Mvvm
//
//  Created by Caner Çağrı on 23.06.2022.
//

import Foundation

class MovieListViewModel: MovieListViewModelProtocol {
    
    var delegate: MoveListViewModelDelegate?
    
    var movieService = Service()
    var movies : [Result] = []
    
    
    func loadData(currentPage: Int) {
        movieService.getMovies(currentPage: currentPage) { movies in
            self.delegate?.handleViewModelOutput(movies)
        }
    }
    
    func numberOfRows() -> Int {
        return movies.count
    }
    
}
