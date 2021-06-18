//
//  MovieDetailCastCollectionViewCell.swift
//  TheMovieApp
//
//  Created by Baris Saraldi on 18.06.2021.
//

import UIKit
import Kingfisher

class MovieDetailCastCollectionViewCell: UICollectionViewCell {
    
    // MARK: View Properties
    
    private var actorImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private var actorNameLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        label.textAlignment = .left
        label.backgroundColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.addSubview(actorImage)
        contentView.addSubview(actorNameLabel)
        contentView.backgroundColor = .systemBackground
        
        setupUI()
        shadowForImage()
    }
    
    // MARK: Functions
    
    private func setupUI() {
        
        actorImage.frame = CGRect(x:0, y:0, width: contentView.frame.size.width, height: contentView.frame.size.height - 30)
        actorNameLabel.frame = CGRect(x: 0, y:actorImage.frame.height + 10, width: contentView.frame.size.width, height:20)
   
//
//        actorImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
//        actorImage.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor).isActive = true
//        actorImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
//        actorImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 10).isActive = true
//
//        actorNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
//        actorNameLabel.topAnchor.constraint(equalTo: actorImage.safeAreaLayoutGuide.topAnchor).isActive = true
//        actorNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
//        actorNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 10).isActive = true
    }

    private func shadowForImage() {
        actorImage.layer.cornerRadius = 10
        actorImage.layer.shadowOpacity = 1
        actorImage.layer.shadowOffset = CGSize(width: 1, height: 1)
    }
    
    func configure (title: String, url:String) {
        actorNameLabel.text = title
        actorImage.kf.setImage(with: URL(string:Constants.imageUrl + url))
    }
}
