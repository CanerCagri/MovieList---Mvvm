//
//  Service.swift
//  MovieList - Mvvm
//
//  Created by Caner Çağrı on 23.06.2022.
//

import Foundation
import UIKit
import Alamofire

struct Service {
    
    // MARK: - All Movies
    func getMovies(currentPage: Int, completion: @escaping ([Result]?) -> ()) {
        let url = Constants.movieApi + String(currentPage)
        
        AF.request(url).responseDecodable(of: MovieList.self) { (movie) in
            guard let data = movie.value else {
                completion(nil)
                return
            }
            completion(data.results)
        }
    }
    
    // MARK: - Detail Page Movie
    func getMovieDetails(id: Int, lang: String, completion: @escaping (SingleMovie?) -> ()) {
        let url = Constants.baseUrl + String(id) + Constants.apiKey + lang
        
        AF.request(url).responseDecodable(of: SingleMovie.self) { (movie) in
            
            guard let data = movie.value else {
                completion(nil)
                return
            }
            completion(data)
        }
    }
}


