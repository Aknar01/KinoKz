//
//  MovieModel.swift
//  KinoKz
//
//  Created by Aknar Assanov on 03.02.2023.
//

import Foundation

struct MovieModel {
    let adult: Bool
    let backdrop_path: String
    let id: Int
    let title: String
    let overview: String
    let posterPath: String
    let mediaType: String
    let genreIds: [Int]
    let releaseDate: String
    let video: Bool
    let voteAverage: Double
}
