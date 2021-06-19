//
//  Constants.swift
//  TheMovieApp
//
//  Created by Baris Saraldi on 17.06.2021.
//

import Foundation

//MARK: Constants

struct Constants {
    
    //MARK: API Constants
    
    static let imageUrl = "https://image.tmdb.org/t/p/w500"
    static let popularMovieUrl = "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)"
    static let apiKey = "2e02f899d2f8f67edc1662faffed3f41"
    static let videoExtend = "/videos?api_key=\(apiKey)"
    static let personURL = "https://api.themoviedb.org/3/person/"
    static let personUrlExtend = "?api_key=\(apiKey)"
    static let personCreditsUrl = "https://api.themoviedb.org/3/person/"
    static let personCreditExtension = "/movie_credits?api_key=\(apiKey)"
    static let credistExtension = "/credits?api_key=\(apiKey)"
    static let urlforCast = "https://api.themoviedb.org/3/movie/"
    static let personCreditTvExtension = "/tv_credits?api_key=\(apiKey)"
    static let nilValue = ""
    
    //MARK: General Constants
    
    static let mostPopularTitle = "Most Populars"
    static let searchTitle = "Search"
    static let videosCollectionViewID = "VideosCollectionView"
    static let movieImageDefault = "clapperboard"
    static let actorImageDefault = "theater-masks"
    static let searchBarID = "SearchBar"
    
    //MARK: Cell Constants
   
    static let movieDetailVideosCollectionViewCellID = "MovieDetailVideosCollectionViewCell"
    static let movieDetailCastCollectionViewCellID = "MovieDetailCastCollectionViewCell"
    static let castPeopleMovieCreditsCollectionViewCellID = "CastPeopleMovieCreditsCollectionViewCell"
    static let mostPopularCollectionViewCellID = "mostPopularCollectionViewCell"
    static let castPeopleTVCreditsCollectionViewCellID = "castPeopleTVCreditsCollectionViewCell"

}
