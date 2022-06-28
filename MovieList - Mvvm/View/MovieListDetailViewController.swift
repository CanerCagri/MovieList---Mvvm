//
//  MovieListDetailViewController.swift
//  MovieList - Mvvm
//
//  Created by Caner Çağrı on 28.06.2022.
//

import UIKit

class MovieListDetailViewController: UIViewController {

    var viewModel = MovieListDetailViewModel()
    var imageView = UIImageView()

    var movie : Result?

    var nameLabel: UILabel = {
        var label = UILabel()
        label.numberOfLines = 2
        label.textColor = .black
        label.font = UIFont.preferredFont(forTextStyle: .body)
        return label
    }()

    var overviewLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.font = UIFont.preferredFont(forTextStyle: .body)
        return label
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = viewModel.movie?.title
        view.backgroundColor = .white
        
//        let imageBaseString = "https://image.tmdb.org/t/p/w500"
//        let urlString = imageBaseString + viewModel.movie!.poster_path!
//        let imageUrl = URL(string: urlString)
//        getData(from: imageUrl!) { data, response, error in
//            guard let data = data, error == nil else { return }
//
//            // always update the UI from the main thread
//            DispatchQueue.main.async() { [weak self] in
//                self?.imageView.image = UIImage(data: data)
//            }
//        }
    }
    
//    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
//        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
//    }

}
