//
//  CastDataModel.swift
//  TheMovieApp
//
//  Created by Baris Saraldi on 18.06.2021.
//

import Foundation

//MARK: Model

struct CastPersons: Codable {
    let name: String?
    let profile_path: String?
}

struct Cast: Codable {
    let cast: [CastPersons]
}
