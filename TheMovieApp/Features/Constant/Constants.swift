//
//  Constants.swift
//  TheMovieApp
//
//  Created by Baris Saraldi on 17.06.2021.
//

import Foundation

//MARK: Constants

struct Constants {
    static let imageUrl = "https://image.tmdb.org/t/p/w500"
    static let popularMovieUrl = "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)"
    static let apiKey = "2e02f899d2f8f67edc1662faffed3f41"
    static let mostPopularCollectionViewCellID = "mostPopularCollectionViewCell"
    static let nilValue = ""
    static let mostPopularTitle = "Most Populars"
    static let searchTitle = "Search"
    static let videosCollectionViewID = "VideosCollectionView"
    static let urlforCast = "https://api.themoviedb.org/3/movie/"
    static let credistExtension = "/credits?api_key=\(apiKey)"
    static let movieDetailVideosCollectionViewCellID = "MovieDetailVideosCollectionViewCell"
    static let movieDetailCastCollectionViewCell = "MovieDetailCastCollectionViewCell"
    static let movieDetailVideosCollectionViewCell = "MovieDetailVideosCollectionViewCell"
    static let videoExtend = "/videos?api_key=\(apiKey)"
}
