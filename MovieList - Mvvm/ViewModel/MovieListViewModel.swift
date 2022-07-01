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
        self.delegate?.loadingActive(status: true)
        movieService.getMovies(currentPage: currentPage) { movies in
            self.delegate?.handleViewModelOutput(movies)
        }
        
        let seconds = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            self.delegate?.loadingActive(status: false)
        }
  
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func numberOfRows() -> Int {
        return movies.count
    }
    
    func heightForRow() -> Int {
        return 150
    }
}
