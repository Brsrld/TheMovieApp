//
//  MostPopularDataModel.swift
//  TheMovieApp
//
//  Created by Baris Saraldi on 17.06.2021.
//

import Foundation

//MARK: MostPopularMovie Model

struct MostPopularMovie: Codable {
    let original_title: String?
    let poster_path: String?
    let overview: String?
    let id: Int
    let vote_average:Double?
}

struct Result: Codable {
    let results: [MostPopularMovie]
}
