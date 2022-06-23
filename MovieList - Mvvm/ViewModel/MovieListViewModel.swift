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
    
    
    func loadData() {
        movieService.getMovies { [weak self] movies in
            self?.delegate?.handleViewModelOutput(movies!)
        }
    }
    
    func selectedRow() {
        
    }
    
    
}
