//
//  CastDetailViewModel.swift
//  TheMovieApp
//
//  Created by Baris Saraldi on 19.06.2021.
//

import Foundation
import RxCocoa
import RxSwift
//MARK: Protocols

protocol CastDetailViewModelProtocol {
    func personService(url:String) -> Observable<CastPeople>
    func credistMovieService(url:String) -> Observable<[PeopleMovieCredits]>
    func credistTvService(url:String) -> Observable<[PeopleTvCredits]>

}

//MARK: Model Logic

final class CastDetailViewModel:NSObject {
    
    private let serviceinit: ServiceInit = ServiceInit()
    
    func personService(url:String) -> Observable<CastPeople>  {
        serviceinit.getPerson(url: url)
    }
    
    func credistMovieService(url:String) -> Observable<[PeopleMovieCredits]>  {
        serviceinit.getCreditsMovie(url: url)
    }
    
    func credistTvService(url:String) -> Observable<[PeopleTvCredits]>  {
        serviceinit.fetchCreditsTv(url: url)
    }
}

//MARK: - CastDetailViewModelProtocol

extension CastDetailViewModel: CastDetailViewModelProtocol {}
