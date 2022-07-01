//
//  MovieListTableViewCell.swift
//  MovieList - Mvvm
//
//  Created by Caner Çağrı on 24.06.2022.
//

import UIKit

class MovieListTableViewCell: UITableViewCell {
    
    var movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderColor  = UIColor.gray.cgColor
        imageView.layer.borderWidth  = 1
        imageView.layer.cornerRadius = 18.75
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var nameLabel : UILabel = {
        var label = UILabel()
        label.numberOfLines = 2
        label.textColor = .black
        label.font = UIFont.preferredFont(forTextStyle: .body)
        return label
    }()
    
    var dateLabel : UILabel = {
        var label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    
    var imdbLabel : UILabel = {
        var label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .clear
        self.selectionStyle = .none
        
        constraints()
    }
    
    func constraints() {
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(movieImageView)
        movieImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        movieImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        movieImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        movieImageView.heightAnchor.constraint(equalToConstant: 130).isActive = true
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor , constant: 130).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 250).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(dateLabel)
        dateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor , constant: 130).isActive = true
        dateLabel.widthAnchor.constraint(equalToConstant: 250).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        imdbLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imdbLabel)
        imdbLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor).isActive = true
        imdbLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor , constant: 130).isActive = true
        imdbLabel.widthAnchor.constraint(equalToConstant: 250).isActive = true
        imdbLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
