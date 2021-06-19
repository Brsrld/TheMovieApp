//
//  CastPeopleMovieCreditsDataModel.swift
//  TheMovieApp
//
//  Created by Baris Saraldi on 19.06.2021.
//

import Foundation

//MARK: Model

struct PeopleMovieCredits: Codable {
    let poster_path: String?
}
struct MovieCredits: Codable {
    let cast: [PeopleMovieCredits]
}
