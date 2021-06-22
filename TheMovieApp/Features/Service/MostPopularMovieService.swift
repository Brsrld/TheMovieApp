//
//  MostPopularMovieService.swift
//  TheMovieApp
//
//  Created by Baris Saraldi on 17.06.2021.
//

import Foundation
import RxCocoa
import RxSwift

//MARK: Protocols

protocol MostPopularModelServiceProtocol {
    
    func fetchPopularMovie <MostPopularMovie:Decodable>(url:String) -> Observable<MostPopularMovie>
    func fetchCast <CastPersons:Decodable>(url:String) -> Observable<CastPersons>
    func fetchMovie <MovieVideos:Decodable>(url:String) -> Observable<MovieVideos>
    func fetchPerson <CastPeople:Decodable>(url:String) -> Observable<CastPeople>
    func fetchCreditsMovie <PeopleMovieCredits:Decodable>(url:String) -> Observable<PeopleMovieCredits>
    func fetchCreditsTv <PeopleTvCredits:Decodable>(url:String) -> Observable<PeopleTvCredits>
}

//MARK: Get Datas

struct MostPopularModelService: MostPopularModelServiceProtocol { 

    func fetchPopularMovie <MostPopularMovie:Decodable>(url:String) -> Observable<MostPopularMovie> {
        return Observable.create { observer -> Disposable in
            let task = URLSession.shared.dataTask(with: URL(string: url)!) { data, _, _ in
                guard let data = data else {
                    return
                }
                guard let decoded = try? JSONDecoder().decode(Result.self, from: data) else {
                    return
                }
                observer.onNext(decoded.results as! MostPopularMovie)
                observer.onCompleted()
            }
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
    func fetchCast <CastPersons:Decodable>(url:String) -> Observable<CastPersons> {
        return Observable.create { observer -> Disposable in
            let task = URLSession.shared.dataTask(with: URL(string: url)!) { data, _, _ in
                guard let data = data else {
                    return
                }
                guard let decoded = try? JSONDecoder().decode(Cast.self, from: data) else {
                    return
                }
                observer.onNext(decoded.cast as! CastPersons)
                observer.onCompleted()
            }
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
    func fetchMovie <MovieVideos:Decodable>(url:String) -> Observable<MovieVideos> {
        return Observable.create { observer -> Disposable in
            let task = URLSession.shared.dataTask(with: URL(string: url)!) { data, _, _ in
                guard let data = data else {
                    return
                }
                guard let decoded = try? JSONDecoder().decode(Videos.self, from: data) else {
                    return
                }
                observer.onNext(decoded.results as! MovieVideos)
                observer.onCompleted()
            }
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
    func fetchPerson <CastPeople:Decodable>(url:String) -> Observable<CastPeople> {
        return Observable.create { observer -> Disposable in
            let task = URLSession.shared.dataTask(with: URL(string: url)!) { data, _, _ in
                guard let data = data else {
                    return
                }
                guard let decoded = try? JSONDecoder().decode(CastPeople.self, from: data) else {
                    return
                }
                observer.onNext(decoded)
                observer.onCompleted()
            }
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
    func fetchCreditsMovie <PeopleMovieCredits:Decodable>(url:String) -> Observable<PeopleMovieCredits> {
        return Observable.create { observer -> Disposable in
            let task = URLSession.shared.dataTask(with: URL(string: url)!) { data, _, _ in
                guard let data = data else {
                    return
                }
                guard let decoded = try? JSONDecoder().decode(MovieCredits.self, from: data) else {
                    return
                }
                observer.onNext(decoded.cast as! PeopleMovieCredits)
                observer.onCompleted()
            }
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
    func fetchCreditsTv <PeopleTvCredits:Decodable>(url:String) -> Observable<PeopleTvCredits> {
        return Observable.create { observer -> Disposable in
            let task = URLSession.shared.dataTask(with: URL(string: url)!) { data, _, _ in
                guard let data = data else {
                    return
                }
                guard let decoded = try? JSONDecoder().decode(TvCredits.self, from: data) else {
                    return
                }
                observer.onNext(decoded.cast as! PeopleTvCredits)
                observer.onCompleted()
            }
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        }
    }
}

