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
    var movieViewModel = MovieListViewModel()
    var currentPage = 3
    let pickerViewLang = ["EN", "TR"]
    var selectedPicker = "EN"
    
    var tableView: UITableView = {
        var table = UITableView()
        table.isHidden = true
        table.separatorColor = .none
        table.allowsSelection = true
        table.register(MovieListTableViewCell.self, forCellReuseIdentifier: Constants.identifier)
        return table
    }()

    var loader: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView(style: .large)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicatorView
    }()
    
    var picker = UIPickerView()
    
    // MARK: - Lifecycle Method
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appyLoad()
        loadTableView()
        loadPickerView()
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
    
    func loadTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = CGRect(x: 0, y: 120, width: view.safeAreaLayoutGuide.layoutFrame.width, height: view.safeAreaLayoutGuide.layoutFrame.height - 120)
        view.addSubview(tableView)
        view.addSubview(loader)
        view.addSubview(picker)
        loadLoader()
        
    }
    
    func loadLoader() {
        loader.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        loader.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
    
    func loadPickerView() {
        picker.delegate = self
        picker.dataSource = self
        picker.isHidden = true
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.frame = CGRect.init(x: view.safeAreaLayoutGuide.layoutFrame.width / 3, y: 35, width: 150, height: 100)
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
        vc.lang = selectedPicker
        
        var navController: UINavigationController!
        navController = UINavigationController(rootViewController: vc)
        navController.modalPresentationStyle = .formSheet
        present(navController, animated: true)
    }
}

//MARK: - PickerView Delegate and DataSource
extension MovieListViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerViewLang.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let row = pickerViewLang[row]
        return row
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerViewLang[row] == "EN" {
            selectedPicker = Constants.en
        } else if pickerViewLang[row] == "TR" {
            selectedPicker = Constants.tr
        }
    }
}

// MARK: - ViewModel Delegate
extension MovieListViewController: MoveListViewModelDelegate {
    
    func handleViewModelOutput(_ output: [Result]) {
        movieViewModel.movies = movieViewModel.movies + output
        DispatchQueue.main.async { [weak self] in
            self?.tableView.refreshControl?.endRefreshing()
            self?.tableView.reloadData()
        }
    }
    
    func loadingActive(status: Bool) {
        DispatchQueue.main.async {
            if status == true {
                self.tableView.isHidden = true
                self.picker.isHidden = true
                self.loader.startAnimating()
            } else {
                self.tableView.isHidden = false
                self.picker.isHidden = false
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



