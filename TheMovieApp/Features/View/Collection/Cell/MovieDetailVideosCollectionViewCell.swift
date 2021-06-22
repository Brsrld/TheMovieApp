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
        player.translatesAutoresizingMaskIntoConstraints = false
        player.contentMode = .scaleToFill
        return player
    }()
    
    // MARK: Functions
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        shadowForContentView()
        videoPlayer.delegate = self
        setupUI()
    }
    
    private func shadowForContentView() {
        contentView.layer.cornerRadius = 10
    }
    
    private func setupUI() {
        contentView.addSubview(videoNameLabel)
        contentView.addSubview(videoPlayer)
        contentView.backgroundColor = .systemBackground
       videoPlayer.frame = CGRect(x: 0, y: 0, width: contentView.frame.size.width, height: contentView.frame.size.height)
    }
    
    //MARK: Configure Cell
    
    func configureUI(videoID: String) {
        videoPlayer.load(withVideoId: videoID, playerVars: ["playsinline": "1"])
    }
}

extension MovieDetailVideosCollectionViewCell:YTPlayerViewDelegate {}
