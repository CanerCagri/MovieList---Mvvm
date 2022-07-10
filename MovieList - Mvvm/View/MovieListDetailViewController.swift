//
//  MovieListDetailViewController.swift
//  MovieList - Mvvm
//
//  Created by Caner Çağrı on 28.06.2022.
//

import UIKit
import SnapKit

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
    
    var overViewLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.lineBreakMode = .byTruncatingHead
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
        view.addSubview(imageView)
        view.addSubview(overViewLabel)
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(70)
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().offset(-40)
            make.height.equalToSuperview().multipliedBy(0.4)
        }

        overViewLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp_bottomMargin).offset(20)
            make.bottom.equalToSuperview().offset(-10)
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-25)
        }
    }
    
    func applyLoad() {
        view.backgroundColor = .white
        viewModel.delegate = self
        viewModel.loadData(id: id!, lang: lang!)
    }
}
