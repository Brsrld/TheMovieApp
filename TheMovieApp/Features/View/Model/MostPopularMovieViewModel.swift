//
//  MostPopularMovieViewModel.swift
//  TheMovieApp
//
//  Created by Baris Saraldi on 17.06.2021.
//

import Foundation

//MARK: Protocols

protocol MostPopularMovieViewModelProtocol {
    func service(url:String, onSuccess: @escaping ([MostPopularMovie]) -> Void, onFail: @escaping (String?) -> Void)
}

//MARK: Model Logic

final class MostPopularMovieViewModel:NSObject {
    
    private let mostPopularModelService: MostPopularModelServiceProtocol = MostPopularModelService()
    
    func service(url:String, onSuccess: @escaping ([MostPopularMovie]) -> Void, onFail: @escaping (String?) -> Void) {
        mostPopularModelService.fetchPopularMovie(url: url, onSuccess: onSuccess, onFail: onFail)
    }
}

extension MostPopularMovieViewModel: MostPopularMovieViewModelProtocol {}
