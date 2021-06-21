//
//  MostPopularMovieViewModel.swift
//  TheMovieApp
//
//  Created by Baris Saraldi on 17.06.2021.
//

import Foundation
import RxCocoa
import RxSwift

//MARK: Protocols

protocol MostPopularMovieViewModelProtocol {
    func service(url:String) -> Observable<[MostPopularMovie]>
}

//MARK: Model Logic

final class MostPopularMovieViewModel:NSObject {

    private let serviceinit: ServiceInit = ServiceInit()
     
    func service(url:String) -> Observable<[MostPopularMovie]> {
        return serviceinit.getPopularMovie(url:url)
    }
}

extension MostPopularMovieViewModel: MostPopularMovieViewModelProtocol {}
