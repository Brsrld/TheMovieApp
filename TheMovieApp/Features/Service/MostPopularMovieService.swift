//
//  MostPopularMovieService.swift
//  TheMovieApp
//
//  Created by Baris Saraldi on 17.06.2021.
//

import Foundation
import Alamofire

protocol MostPopularModelServiceProtocol {
    func fetchPopularMovie(url:String, onSuccess: @escaping ([MostPopularMovie]) -> Void, onFail: @escaping (String?) -> Void)
    func fetchCast(url:String, onSuccess: @escaping ([CastPersons]) -> Void, onFail: @escaping (String?) -> Void)
    func fetchVideo(url:String, onSuccess: @escaping ([MovieVideos]) -> Void, onFail: @escaping (String?) -> Void)
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
}
