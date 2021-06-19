//
//  CastPeopleTVCreditsCollectionViewCell.swift
//  TheMovieApp
//
//  Created by Baris Saraldi on 19.06.2021.
//

import UIKit

class CastPeopleTVCreditsCollectionViewCell: UICollectionViewCell {
    
    // MARK: View Properties
    
    private var movieImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        return iv
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.addSubview(movieImage)
        setupUI()
        shadowEffect()
    }
    
    // MARK: Functions
    
    private func setupUI() {
       movieImage.frame = CGRect(x: 0, y: 0, width: contentView.frame.size.width , height: contentView.frame.size.height)
    }
    
    private func shadowEffect() {
        movieImage.layer.cornerRadius = 10
        contentView.layer.cornerRadius = 10
        movieImage.layer.shadowOpacity = 1
        movieImage.layer.shadowOffset = CGSize(width: 1, height: 1)
    }
    
    func configure (url:String) {
        let url = "\(Constants.imageUrl )\(url)"
        if url == Constants.imageUrl {
            movieImage.image = UIImage(named: Constants.movieImageDefault)
        }else {
            movieImage.kf.setImage(with: URL(string: url))
        }
    }
}
