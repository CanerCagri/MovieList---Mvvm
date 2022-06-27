// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let movieList = try? newJSONDecoder().decode(MovieList.self, from: jsonData)

import Foundation

// MARK: - MovieList
struct MovieList: Codable {
    let page: Int
    let results: [Result]
}

// MARK: - Result
struct Result: Codable {
    let id: Int
    let overview: String
    let popularity: Double
    let poster_path: String
    let release_date, title: String
    let vote_average: Double

 
}

