//
//  Service.swift
//  MovieList - Mvvm
//
//  Created by Caner Çağrı on 23.06.2022.
//

import Foundation
import UIKit

struct Service {
    
    // MARK: - All Movies
    func getMovies(currentPage: Int, completion: @escaping ([Result]) -> ()) {
        let url = URL(string: Constants.movieApi + String(currentPage))
        
        URLSession.shared.dataTask(with: url!) { data, response, error in
            if error != nil {
                print(error!)
            }
            if let safeData = data {
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode((MovieList.self), from: safeData)
                    completion(result.results)
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
    
    // MARK: - Detail Page Movie
    func getMovieDetails(id: Int, lang: String, completion: @escaping (SingleMovie) -> ()) {
        let baseUrl = Constants.baseUrl
        let apiKey = Constants.apiKey
        let url = URL(string: baseUrl + String(id) + apiKey + lang)
        
        URLSession.shared.dataTask(with: url!) { data, response, error in
            if error != nil {
                print(error!)
            }
            if let safeData = data {
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode((SingleMovie.self), from: safeData)
                    completion(result)
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
}


