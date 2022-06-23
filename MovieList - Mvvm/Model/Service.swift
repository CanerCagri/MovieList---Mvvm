//
//  Service.swift
//  MovieList - Mvvm
//
//  Created by Caner Çağrı on 23.06.2022.
//

import Foundation
import UIKit

struct Service {
    func getMovies(completion: @escaping ([Result]?) -> ()) {
        let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=16b57169954864f01854a6d42dbd2234&language=en-US&page=1")
        
        URLSession.shared.dataTask(with: url!) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
                
            } else if let data = data {
                let moviesArray = try? JSONDecoder().decode([Result].self, from: data)
                
                if let moviesArray = moviesArray {
                    completion(moviesArray)
                }
            }
        }.resume()
    }
}
