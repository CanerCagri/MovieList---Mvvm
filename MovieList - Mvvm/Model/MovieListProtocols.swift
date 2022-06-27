//
//  MovieListProtocols.swift
//  MovieList - Mvvm
//
//  Created by Caner Çağrı on 23.06.2022.
//

import Foundation

protocol MovieListViewModelProtocol {
    var delegate : MoveListViewModelDelegate? { get set}
    func loadData()
    func selectedRow()
}

protocol MoveListViewModelDelegate {
    func handleViewModelOutput (_ output : [Result])
}
