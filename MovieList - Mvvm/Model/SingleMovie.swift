// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let movieList = try? newJSONDecoder().decode(MovieList.self, from: jsonData)

import Foundation

// MARK: - MovieList
struct SingleMovie: Codable {
    let id: Int?
    let originalTitle, overview, title, posterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case originalTitle = "original_title"
        case overview, title
        case posterPath = "poster_path"
    }
}
