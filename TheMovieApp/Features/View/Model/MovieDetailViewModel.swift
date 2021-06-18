//
//  MovieDetailViewModel.swift
//  TheMovieApp
//
//  Created by Baris Saraldi on 18.06.2021.
//

import Foundation

//MARK: Protocols

protocol MovieDetailViewModelProtocol {
    func castService(url:String, onSuccess: @escaping ([CastPersons]) -> Void, onFail: @escaping (String?) -> Void)
}

//MARK: Model Logic

final class MovieDetailViewModel:NSObject {
    
    private let movieDetailViewModelService: MostPopularModelServiceProtocol = MostPopularModelService()
    
    func castService(url:String, onSuccess: @escaping ([CastPersons]) -> Void, onFail: @escaping (String?) -> Void) {
        movieDetailViewModelService.fetchCast(url: url, onSuccess: onSuccess, onFail: onFail)
    }
    
    func videoService(url:String, onSuccess: @escaping ([MovieVideos]) -> Void, onFail: @escaping (String?) -> Void) {
        movieDetailViewModelService.fetchVideo(url: url, onSuccess: onSuccess, onFail: onFail)
    }
}

extension MovieDetailViewModel: MovieDetailViewModelProtocol {}
