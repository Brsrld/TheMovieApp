//
//  MovieDetailVideosCollectionViewCell.swift
//  TheMovieApp
//
//  Created by Baris Saraldi on 18.06.2021.
//

import UIKit
import youtube_ios_player_helper

class MovieDetailVideosCollectionViewCell: UICollectionViewCell {
    
    // MARK: View Properties
    
    private var videoNameLabel: UILabel = {
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
    
    private lazy var videoPlayer: YTPlayerView = {
       let player = YTPlayerView()
        return player
    }()
    
    // MARK: Functions
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.addSubview(videoNameLabel)
        contentView.addSubview(videoPlayer)
        contentView.backgroundColor = .systemBackground
        shadowForContentView()
    }
    
    private func shadowForContentView() {
        layer.cornerRadius  = 10
        contentView.layer.cornerRadius = layer.cornerRadius
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 1, height: 1)
    }
    
    private func setupUI() {
        videoPlayer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        videoPlayer.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor).isActive = true
        videoPlayer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        videoPlayer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    //MARK: Configure Cell

    func configureUI(videoID: String) {
        videoPlayer.load(withVideoId: videoID)
    }
}
