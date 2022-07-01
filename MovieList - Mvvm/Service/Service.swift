//
//  Service.swift
//  MovieList - Mvvm
//
//  Created by Caner Çağrı on 23.06.2022.
//

import Foundation
import UIKit

struct Service {
    func getMovies(currentPage: Int, completion: @escaping ([Result]) -> ()) {
        let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=16b57169954864f01854a6d42dbd2234&language=en-US&page=\(currentPage)")
        
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
    
    func getMovieDetails(id: Int, completion: @escaping (SingleMovie) -> ()) {
        let baseUrl = "https://api.themoviedb.org/3/movie/"
        let apiKey = "?api_key=16b57169954864f01854a6d42dbd2234&61604"
        let url = URL(string: baseUrl + String(id) + apiKey)
        
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


