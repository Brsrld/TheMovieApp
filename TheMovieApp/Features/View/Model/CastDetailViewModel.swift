//
//  CastDetailViewModel.swift
//  TheMovieApp
//
//  Created by Baris Saraldi on 19.06.2021.
//

import Foundation

//MARK: Protocols

protocol CastDetailViewModelProtocol {
    func servicePerson(url:String, onSuccess: @escaping (CastPeople) -> Void, onFail: @escaping (String?) -> Void)
    func serviceCreditsMovie(url:String, onSuccess: @escaping ([PeopleMovieCredits]) -> Void, onFail: @escaping (String?) -> Void)
    func serviceCreditsTv(url:String, onSuccess: @escaping ([PeopleTvCredits]) -> Void, onFail: @escaping (String?) -> Void)
}

//MARK: Model Logic

final class CastDetailViewModel:NSObject {
    
    private let castDetailViewModelService: MostPopularModelServiceProtocol = MostPopularModelService()
    
    func servicePerson(url:String, onSuccess: @escaping (CastPeople) -> Void, onFail: @escaping (String?) -> Void) {
        castDetailViewModelService.fetchPerson(url: url, onSuccess: onSuccess, onFail: onFail)
    }
    
    func serviceCreditsMovie(url:String, onSuccess: @escaping ([PeopleMovieCredits]) -> Void, onFail: @escaping (String?) -> Void) {
        castDetailViewModelService.fetchCreditsMovie(url: url, onSuccess: onSuccess, onFail: onFail)
    }
    
    func serviceCreditsTv(url:String, onSuccess: @escaping ([PeopleTvCredits]) -> Void, onFail: @escaping (String?) -> Void) {
        castDetailViewModelService.fetchCreditsTv(url: url, onSuccess: onSuccess, onFail: onFail)
    }
}

extension CastDetailViewModel: CastDetailViewModelProtocol {}
