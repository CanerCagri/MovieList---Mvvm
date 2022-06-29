//
//  MovieListDetailProtocols.swift
//  MovieList - Mvvm
//
//  Created by Caner Çağrı on 28.06.2022.
//

import Foundation

protocol MovieListDetailProtocols {
    var delegate: MovieListDetailDelegate? { get set }
    func loadData(id: Int)
}

protocol MovieListDetailDelegate {
    func handleViewModelOutput (_ output : SingleMovie)
}
