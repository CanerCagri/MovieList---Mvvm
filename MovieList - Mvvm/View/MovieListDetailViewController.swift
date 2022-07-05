//
//  MovieListDetailViewController.swift
//  MovieList - Mvvm
//
//  Created by Caner Çağrı on 28.06.2022.
//

import UIKit

class MovieListDetailViewController: UIViewController, MovieListDetailDelegate {
    
    // MARK: - Properties
    var id: Int?
    var lang: String?
    var viewModel = MovieListDetailViewModel()
    
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderColor  = UIColor.gray.cgColor
        imageView.layer.borderWidth  = 1
        imageView.layer.cornerRadius = 18.75
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var nameLabel: UILabel = {
        var label = UILabel()
        label.numberOfLines = 2
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var overViewLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.font = UIFont.preferredFont(forTextStyle: .body)
        return label
    }()
    
    // MARK: - Lifecycle Method
    override func viewDidLoad() {
        super.viewDidLoad()
        applyLoad()
        constraints()
    }
    
    // MARK: - View Model Delegate
    func handleViewModelOutput(_ output: SingleMovie) {
        viewModel.movie = output
        
        DispatchQueue.main.async() { [weak self] in
            if let path = self?.viewModel.movie?.posterPath {
                self?.downloadImage(path: path)
            }
            self?.title = self?.viewModel.movie?.title!
            self?.nameLabel.text = self?.viewModel.movie?.title!
            self?.overViewLabel.text = self?.viewModel.movie?.overview!
        }
    }
    
    //MARK: - Functions
    private func downloadImage(path: String) {
        let urlString = Constants.imageBaseUrl + path
        guard let imageUrl = URL(string: urlString) else {
            return
        }
        ImageCache.publicCache.load(url: imageUrl as NSURL) { image in
            if let image = image {
                DispatchQueue.main.async { [weak self] in
                    self?.imageView.image = image
                }
            }
        }
    }

    func constraints() {
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 70).isActive = true
        imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4).isActive = true
        
        nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 70).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -70).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 70).isActive = true
        
        overViewLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor , constant: 10).isActive = true
        overViewLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        overViewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        overViewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25).isActive = true
    }
    
    func applyLoad() {
        view.backgroundColor = .white
        view.addSubview(imageView)
        view.addSubview(nameLabel)
        view.addSubview(overViewLabel)
        viewModel.delegate = self
        viewModel.loadData(id: id!, lang: lang!)
    }
}
