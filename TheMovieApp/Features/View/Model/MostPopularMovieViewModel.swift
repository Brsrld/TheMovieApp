//
//  MostPopularMovieViewModel.swift
//  TheMovieApp
//
//  Created by Baris Saraldi on 17.06.2021.
//

import Foundation

//MARK: Protocols

protocol MostPopularMovieViewModelProtocol {
    func service(onSuccess: @escaping ([MostPopularMovie]) -> Void, onFail: @escaping (String?) -> Void)
}

//MARK: Model Logic

final class MostPopularMovieViewModel:NSObject {
    
    private let mostPopularModelService: MostPopularModelServiceProtocol = MostPopularModelService()
    
    func service(onSuccess: @escaping ([MostPopularMovie]) -> Void, onFail: @escaping (String?) -> Void) {
        mostPopularModelService.fetchAllData(onSuccess: onSuccess, onFail: onFail)
    }
}

extension MostPopularMovieViewModel: MostPopularMovieViewModelProtocol {}
