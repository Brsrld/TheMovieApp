//
//  MostPopularMovieService.swift
//  TheMovieApp
//
//  Created by Baris Saraldi on 17.06.2021.
//

import Foundation
import Alamofire

//MARK: Protocol

protocol MostPopularModelServiceProtocol {
    func fetchPopularMovie(url:String, onSuccess: @escaping ([MostPopularMovie]) -> Void, onFail: @escaping (String?) -> Void)
    func fetchCast(url:String, onSuccess: @escaping ([CastPersons]) -> Void, onFail: @escaping (String?) -> Void)
    func fetchVideo(url:String, onSuccess: @escaping ([MovieVideos]) -> Void, onFail: @escaping (String?) -> Void)
    func fetchPerson(url:String, onSuccess: @escaping (CastPeople) -> Void, onFail: @escaping (String?) -> Void)
    func fetchCreditsMovie(url:String, onSuccess: @escaping ([PeopleMovieCredits]) -> Void, onFail: @escaping (String?) -> Void)
    func fetchCreditsTv(url:String, onSuccess: @escaping ([PeopleTvCredits]) -> Void, onFail: @escaping (String?) -> Void)
}

//MARK: Get Datas

struct MostPopularModelService: MostPopularModelServiceProtocol {
    
    func fetchPopularMovie(url:String, onSuccess: @escaping ([MostPopularMovie]) -> Void, onFail: @escaping (String?) -> Void) {
        AF.request(url, method: .get).validate().responseDecodable(of: Result.self) { (response) in
            guard let items = response.value else {
                onFail(response.debugDescription)
                return
            }
            onSuccess(items.results)
        }
    }
    
    func fetchCast(url:String, onSuccess: @escaping ([CastPersons]) -> Void, onFail: @escaping (String?) -> Void) {
        AF.request(url, method: .get).validate().responseDecodable(of: Cast.self) { (response) in
            guard let items = response.value else {
                onFail(response.debugDescription)
                return
            }
            onSuccess(items.cast)
        }
    }
    
    func fetchVideo(url:String, onSuccess: @escaping ([MovieVideos]) -> Void, onFail: @escaping (String?) -> Void) {
        AF.request(url, method: .get).validate().responseDecodable(of: Videos.self) { (response) in
            guard let items = response.value else {
                onFail(response.debugDescription)
                return
            }
            onSuccess(items.results)
        }
    }
    
    func fetchPerson(url:String, onSuccess: @escaping (CastPeople) -> Void, onFail: @escaping (String?) -> Void) {
        AF.request(url, method: .get).validate().responseDecodable(of: CastPeople.self) { (response) in
            guard let items = response.value else {
                onFail(response.debugDescription)
                return
            }
            onSuccess(items)
        }
    }
    
    func fetchCreditsMovie(url:String, onSuccess: @escaping ([PeopleMovieCredits]) -> Void, onFail: @escaping (String?) -> Void) {
        AF.request(url, method: .get).validate().responseDecodable(of: MovieCredits.self) { (response) in
            guard let items = response.value else {
                onFail(response.debugDescription)
                return
            }
            onSuccess(items.cast)
        }
    }
    
    func fetchCreditsTv(url:String, onSuccess: @escaping ([PeopleTvCredits]) -> Void, onFail: @escaping (String?) -> Void) {
        AF.request(url, method: .get).validate().responseDecodable(of: TvCredits.self) { (response) in
            guard let items = response.value else {
                onFail(response.debugDescription)
                return
            }
            onSuccess(items.cast)
        }
    }
}
