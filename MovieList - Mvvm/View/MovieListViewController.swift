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
        // Do any additional setup after loading the view.
        tableView.separatorColor = UIColor.clear
        tableView.tableFooterView = UIView()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.allowsSelection = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.frame = CGRect(x: 0, y: 0, width: view.safeAreaLayoutGuide.layoutFrame.width, height: view.safeAreaLayoutGuide.layoutFrame.height)
        view.addSubview(tableView)
    }
}

extension MovieListViewController: UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell" , for: indexPath)
        cell.textLabel?.text = "asd"
        return cell
    }
    
   
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //TODO
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


