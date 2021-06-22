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
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleToFill
        iv.clipsToBounds = true
        return iv
    }()
    
    private var actorNameLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.font = UIFont.systemFont(ofSize: 16.5)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupUI()
        shadowEffect()
    }
    
    // MARK: Functions
    
    private func setupUI() {
        
        contentView.addSubview(actorImage)
        contentView.addSubview(actorNameLabel)
        contentView.backgroundColor = .white
        
        actorImage.frame = CGRect(x:0, y: 0, width: contentView.frame.size.width, height: contentView.frame.size.height / 1.2)
        actorNameLabel.frame = CGRect(x:0, y: actorImage.frame.height, width: contentView.frame.size.width, height: contentView.frame.size.height - actorImage.frame.size.height )
    
    }

    private func shadowEffect() {
        actorImage.layer.cornerRadius = 10
        actorImage.layer.shadowOpacity = 1
        actorImage.layer.shadowOffset = CGSize(width: 1, height: 1)
    }
    
    func configure (title: String, url:String) {
        actorNameLabel.text = title
        let url = "\(Constants.imageUrl )\(url)"
        if url == Constants.imageUrl {
            actorImage.image = UIImage(named: Constants.actorImageDefault)
        }else {
            actorImage.kf.setImage(with: URL(string: url))
        }
    }
}
