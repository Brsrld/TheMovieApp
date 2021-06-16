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
    
    private var movieImage: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    
    private var movieName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private var movieOverview: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        shadowForImage()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.addSubview(movieImage)
        contentView.addSubview(movieName)
        contentView.addSubview(movieOverview)
        setupUI()
    }
    
    // MARK: Functions
    
    private func setupUI() {
        movieImage.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        movieImage.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        movieImage.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        movieImage.heightAnchor.constraint(equalToConstant: contentView.frame.height/1.30).isActive = true
        
        movieName.topAnchor.constraint(equalTo: movieImage.bottomAnchor, constant: 5).isActive = true
        movieName.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        movieName.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
    
    }
    
    private func shadowForImage() {
        layer.cornerRadius  = 10
        movieImage.layer.cornerRadius = layer.cornerRadius
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 1, height: 1)
    }
    
    //MARK: Configure Cell
    
    func configure (title: String, image: String, overview: String) {
        movieName.text = title
        movieImage.kf.setImage(with: URL(string: Constants.imageUrl + image))
        movieOverview.text = overview
    }
}
