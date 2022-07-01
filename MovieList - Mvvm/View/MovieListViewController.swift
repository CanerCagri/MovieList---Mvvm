//
//  MovieListViewController.swift
//  MovieList - Mvvm
//
//  Created by Caner Çağrı on 23.06.2022.
//

import Foundation
import UIKit

class MovieListViewController: UIViewController {
    
    // MARK: - Properties
    var tableView = UITableView()
    var movieViewModel = MovieListViewModel()
    var currentPage = 1
    
    var loader: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView(style: .large)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicatorView
    }()
    
    // MARK: - Override Function
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appyLoad()
        loadTableView()
    }
    
    func appyLoad() {
        title = "Movies"
        view.backgroundColor = .white
        movieViewModel.delegate = self
        movieViewModel.loadData(currentPage: currentPage)
    }
}

// MARK: - TableView Delegate and DataSource
extension MovieListViewController: UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(movieViewModel.heightForRow())
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
        tableView.isHidden = true
        tableView.separatorColor = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = true
        tableView.register(MovieListTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.frame = CGRect(x: 0, y: 0, width: view.safeAreaLayoutGuide.layoutFrame.width, height: view.safeAreaLayoutGuide.layoutFrame.height)
        view.addSubview(tableView)
        view.addSubview(loader)
        loadLoader()
        
    }
    
    func loadLoader() {
        loader.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        loader.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
    }
}

// MARK: - ViewModel Delegate
extension MovieListViewController: MoveListViewModelDelegate {
    
    func handleViewModelOutput(_ output: [Result]) {
        movieViewModel.movies = movieViewModel.movies + output
        DispatchQueue.main.async {
            self.tableView.isHidden = false
            self.tableView.reloadData()
        }
    }
    
    func loadingActive(status: Bool) {
        print(status)
        DispatchQueue.main.async {
            status ? self.loader.startAnimating() : self.loader.stopAnimating()
        }
    }
}

// MARK: - Paging
extension MovieListViewController {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            currentPage += 1
            if currentPage < 499{
                movieViewModel.loadData(currentPage: currentPage)
            }
        }
    }
}



