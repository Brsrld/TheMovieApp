//
//  MovieDetailViewModel.swift
//  TheMovieApp
//
//  Created by Baris Saraldi on 18.06.2021.
//

import Foundation
import RxCocoa
import RxSwift

//MARK: Protocols

protocol MovieDetailViewModelProtocol {
    func castService(url:String) -> Observable<[CastPersons]>
    func videoService(url:String) -> Observable<[MovieVideos]>
}

//MARK: Model Logic

final class MovieDetailViewModel:NSObject {
    
    private let serviceinit: ServiceInit = ServiceInit()
    
    func castService(url:String) -> Observable<[CastPersons]> {
        return serviceinit.getCast(url: url)
    }
    
    func videoService(url:String) -> Observable<[MovieVideos]> {
        return serviceinit.getVideo(url:url)
    }
}

//MARK: - MovieDetailViewModelProtocol

extension MovieDetailViewModel: MovieDetailViewModelProtocol {}
