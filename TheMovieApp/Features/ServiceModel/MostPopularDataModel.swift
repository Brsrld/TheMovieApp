//
//  MostPopularDataModel.swift
//  TheMovieApp
//
//  Created by Baris Saraldi on 17.06.2021.
//

import Foundation

//MARK: Model

struct MostPopularMovie: Codable {
    let original_title: String?
    let poster_path: String?
    let overview: String?
}

struct Result: Codable {
    let results: [MostPopularMovie]
}
