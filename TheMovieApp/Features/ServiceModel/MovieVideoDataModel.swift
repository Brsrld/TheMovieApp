//
//  MovieVideoDataModel.swift
//  TheMovieApp
//
//  Created by Baris Saraldi on 19.06.2021.
//

import Foundation

//MARK: Model

struct MovieVideos: Codable {
    let key: String?
}

struct Videos: Codable {
    let results: [MovieVideos]
}

