//
//  CastDataModel.swift
//  TheMovieApp
//
//  Created by Baris Saraldi on 18.06.2021.
//

import Foundation

//MARK: MostPopularMovie Model

struct CastPersons: Codable {
    let name: String?
    let profile_path: String?
    let id: Int?
    let known_for_department: String?
}

struct Cast: Codable {
    let cast: [CastPersons]
}
