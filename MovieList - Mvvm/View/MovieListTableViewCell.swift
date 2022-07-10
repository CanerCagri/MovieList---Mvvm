//
//  MovieListTableViewCell.swift
//  MovieList - Mvvm
//
//  Created by Caner Çağrı on 24.06.2022.
//

import UIKit
import SnapKit

class MovieListTableViewCell: UITableViewCell {
    
    var movieViewModel = MovieListViewModel()
    
    // MARK: - Properties
    private var containerView: UIView = {
        let view = UIView()
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        view.layer.shadowRadius = 2
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderColor  = UIColor.gray.cgColor
        imageView.layer.borderWidth  = 1
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var nameLabel : UILabel = {
        var label = UILabel()
        label.numberOfLines = 2
        label.textColor = .black
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var dateLabel : UILabel = {
        var label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var imdbLabel : UILabel = {
        var label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Functions
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        applyShadow(cornerRadius: 8)
        constraints()
    }
    
    func configure(movie: Result) {
        if let path = movie.poster_path {
            downloadImage(path: path)
        }
        nameLabel.text = movie.title
        dateLabel.text = movie.release_date
        imdbLabel.text = String(describing: movie.vote_average!)
    }
    
    func constraints() {
        self.addSubview(movieImageView)
        self.addSubview(nameLabel)
        self.addSubview(dateLabel)
        self.addSubview(imdbLabel)
        
        movieImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(10)
            make.width.equalTo(100)
            make.height.equalTo(130)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(130)
            make.right.equalToSuperview().offset(-40)
            make.width.equalTo(250)
            make.height.equalTo(50)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp_bottomMargin)
            make.leading.equalToSuperview().offset(130)
            make.width.equalTo(250)
            make.height.equalTo(30)
        }

        imdbLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp_bottomMargin)
            make.left.equalToSuperview().offset(130)
            make.width.equalTo(250)
            make.height.equalTo(40)
        }
    }
    
    private func downloadImage(path: String) {
        let urlString = Constants.imageBaseUrl + path
        guard let imageUrl = URL(string: urlString) else {
            return
        }
        
        ImageCache.publicCache.load(url: imageUrl as NSURL) { image in
            if let image = image {
                DispatchQueue.main.async { [weak self] in
                    self?.movieImageView.image = image
                }
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UIView Shadow Extension
extension UIView {
    func applyShadow(cornerRadius: CGFloat) {
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = false
        layer.shadowRadius = 4.0
        layer.shadowOpacity = 0.30
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 5)
    }
}
