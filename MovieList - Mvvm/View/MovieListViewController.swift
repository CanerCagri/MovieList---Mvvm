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
    var currentPage = 3
    
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
        movieViewModel.delayForActivityIndicator()
        pullToRefresh()
    }
    
    func appyLoad() {
        title = Constants.tableViewTitle
        view.backgroundColor = .white
        movieViewModel.delegate = self
        movieViewModel.loadData(currentPage: currentPage)
    }
    
    func pullToRefresh() {
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
    }
    
    @objc func didPullToRefresh() {
        currentPage = 3
        movieViewModel.movies.removeAll()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.identifier , for: indexPath) as! MovieListTableViewCell
        
        cell.configure(movie: movieViewModel.movies[indexPath.row])
        return cell
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
        tableView.register(MovieListTableViewCell.self, forCellReuseIdentifier: Constants.identifier)
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
            self.tableView.refreshControl?.endRefreshing()
            self.tableView.reloadData()
        }
    }
    
    func loadingActive(status: Bool) {
        DispatchQueue.main.async {
            if status == true {
                self.tableView.isHidden = true
                self.loader.startAnimating()
            } else {
                self.tableView.isHidden = false
                self.loader.stopAnimating()
            }
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



