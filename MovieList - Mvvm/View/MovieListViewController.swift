//
//  MovieListViewController.swift
//  MovieList - Mvvm
//
//  Created by Caner Çağrı on 23.06.2022.
//

import Foundation
import UIKit

class MovieListViewController: UIViewController {
    
    var tableView = UITableView()
    var movieViewModel = MovieListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        appyLoad()
        loadTableView()
    }
    
    func appyLoad() {
        title = "Movies"
        movieViewModel.delegate = self
        movieViewModel.loadData()
    }
}

extension MovieListViewController: UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieViewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell" , for: indexPath) as! MovieListTableViewCell
        let cellRow = movieViewModel.movies[indexPath.row]
        let imageBaseString = "https://image.tmdb.org/t/p/w500"
            let urlString = imageBaseString + cellRow.poster_path!
        let imageUrl = URL(string: urlString)
        getData(from: imageUrl!) { data, response, error in
            guard let data = data, error == nil else { return }

            DispatchQueue.main.async() { [] in
                cell.movieImageView.image = UIImage(data: data)
            }
        }
        cell.nameLabel.text = cellRow.title
        cell.dateLabel.text = cellRow.release_date
        cell.imdbLabel.text = String(describing: cellRow.vote_average!)
        return cell
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = MovieListDetailViewController()
        vc.id = movieViewModel.movies[indexPath.row].id!
        var navController: UINavigationController!
        
        navController = UINavigationController(rootViewController: vc)
        navController.modalPresentationStyle = .formSheet
        present(navController, animated: true)
       
    }
    
    func loadTableView() {
        tableView.separatorColor = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = true
        tableView.register(MovieListTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.frame = CGRect(x: 0, y: 0, width: view.safeAreaLayoutGuide.layoutFrame.width, height: view.safeAreaLayoutGuide.layoutFrame.height)
        view.addSubview(tableView)
    }
}

extension MovieListViewController: MoveListViewModelDelegate {
    
    func handleViewModelOutput(_ output: [Result]) {
        movieViewModel.movies = output
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}


