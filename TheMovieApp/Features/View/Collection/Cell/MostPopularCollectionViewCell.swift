//
//  MostPopularCollectionViewCell.swift
//  TheMovieApp
//
//  Created by Baris Saraldi on 17.06.2021.
//

import UIKit
import Kingfisher

class MostPopularCollectionViewCell: UICollectionViewCell {
    
    // MARK: View Properties
    
    private var movieImageLabel: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleToFill
        iv.clipsToBounds = true
        return iv
    }()
    
    private var movieNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.textAlignment = .left
        label.backgroundColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private var movieOverviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .black
        label.textAlignment = .left
        label.backgroundColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
      
        setupUI()
        shadowForContentView()
        shadowForImage()
    }
    
    // MARK: Functions
    
    private func setupUI() {
        
        contentView.addSubview(movieImageLabel)
        contentView.addSubview(movieNameLabel)
        contentView.addSubview(movieOverviewLabel)
        contentView.backgroundColor = .white
        
        contentView.frame = CGRect(x: 0, y: 60, width: contentView.frame.size.width, height: contentView.frame.size.height)
        movieImageLabel.frame = CGRect(x: 0, y: -50, width: contentView.frame.size.width / 2.5, height: contentView.frame.size.height + 50)
        movieNameLabel.frame = CGRect(x: movieImageLabel.frame.width + 10, y:10, width: contentView.frame.size.width - movieImageLabel.frame.width - 10, height: contentView.frame.size.height / 3)
        movieOverviewLabel.frame = CGRect(x: movieImageLabel.frame.width + 10, y:movieNameLabel.frame.height + 10, width: contentView.frame.size.width - movieImageLabel.frame.width - 10, height: contentView.frame.size.height - 90)
    }
    
    private func shadowForContentView() {
        layer.cornerRadius  = 10
        contentView.layer.cornerRadius = layer.cornerRadius
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 1, height: 1)
    }
    
    private func shadowForImage() {
        movieImageLabel.layer.cornerRadius = 10
        movieImageLabel.layer.shadowOpacity = 1
        movieImageLabel.layer.shadowOffset = CGSize(width: 1, height: 1)
    }
    
    //MARK: Configure Cell
    
    func configure (title: String, image: String, overview: String) {
        movieNameLabel.text = title
        movieImageLabel.kf.setImage(with: URL(string: Constants.imageUrl + image))
        movieOverviewLabel.text = overview
    }
}
