//
//  MostPopularMovieService.swift
//  TheMovieApp
//
//  Created by Baris Saraldi on 17.06.2021.
//

import Foundation
import Alamofire

protocol MostPopularModelServiceProtocol {
    func fetchAllData(onSuccess: @escaping ([MostPopularMovie]) -> Void, onFail: @escaping (String?) -> Void)
}

//MARK: Get Datas

struct MostPopularModelService: MostPopularModelServiceProtocol {
    
    func fetchAllData(onSuccess: @escaping ([MostPopularMovie]) -> Void, onFail: @escaping (String?) -> Void) {
        AF.request(Constants.popularMovieUrl, method: .get).validate().responseDecodable(of: Result.self) { (response) in
            guard let items = response.value else {
                onFail(response.debugDescription)
                return
            }
            onSuccess(items.results)
            print(items.results.count)
        }
    }
}
