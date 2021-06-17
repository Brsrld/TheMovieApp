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
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        label.textAlignment = .left
        label.backgroundColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private var movieOverview: UILabel = {
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.addSubview(movieImage)
        contentView.addSubview(movieName)
        contentView.addSubview(movieOverview)
        contentView.backgroundColor = .white
        setupUI()
        shadowForContentView()
        shadowForImage()
    }
    
    // MARK: Functions
    
    private func setupUI() {
        movieImage.frame = CGRect(x: -27, y: -6, width: contentView.frame.size.width / 2, height: contentView.frame.size.height + 6)
        movieName.frame = CGRect(x: movieImage.frame.width - 30, y:10, width: contentView.frame.size.width - movieImage.frame.width, height: contentView.frame.size.height / 3)
        movieOverview.frame = CGRect(x: movieImage.frame.width - 30, y:movieName.frame.height + 10, width: contentView.frame.size.width - movieImage.frame.width, height: contentView.frame.size.height - 90)
    }
    
    private func shadowForContentView() {
        layer.cornerRadius  = 10
        contentView.layer.cornerRadius = layer.cornerRadius
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 1, height: 1)
    }
    
    private func shadowForImage() {
        layer.cornerRadius  = 40
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
