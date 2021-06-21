//
//  ServiceInit.swift
//  TheMovieApp
//
//  Created by Baris Saraldi on 21.06.2021.
//

import Foundation
import RxSwift
import RxCocoa

protocol ServiceInitProtocol {
    
    func getPopularMovie(url:String) -> Observable<[MostPopularMovie]>
    func getCast(url:String) -> Observable<[CastPersons]>
    func getVideo(url:String) -> Observable<[MovieVideos]>
    func getPerson(url:String) -> Observable<CastPeople>
    func getCreditsMovie(url:String) -> Observable<[PeopleMovieCredits]>
    func fetchCreditsTv(url:String) -> Observable<[PeopleTvCredits]>
    
}

final class ServiceInit:NSObject {
    
    private let mostPopularModelService: MostPopularModelServiceProtocol = MostPopularModelService()
    
    func getPopularMovie(url:String) -> Observable<[MostPopularMovie]>  {
        return mostPopularModelService.fetchPopularMovie(url: url)
    }
    
    func getCast(url:String) -> Observable<[CastPersons]>  {
        return mostPopularModelService.fetchCast(url: url)
    }
    
    func getVideo(url:String) -> Observable<[MovieVideos]>  {
        return mostPopularModelService.fetchMovie(url: url)
    }
    
    func getPerson(url:String) -> Observable<CastPeople>  {
        return mostPopularModelService.fetchPerson(url: url)
    }
    
    func getCreditsMovie(url:String) -> Observable<[PeopleMovieCredits]>  {
        return mostPopularModelService.fetchCreditsMovie(url: url)
    }
    
    func fetchCreditsTv(url:String) -> Observable<[PeopleTvCredits]>  {
        return mostPopularModelService.fetchCreditsTv(url: url)
    }
}
