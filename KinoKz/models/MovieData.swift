//
//  MovieData.swift
//  KinoKz
//
//  Created by Aknar Assanov on 03.02.2023.
//

import Foundation

struct MovieData: Decodable {
    let results: [Results]
}

struct Results: Decodable {
    let adult: Bool
    let backdrop_path: String
    let id: Int
    let title: String
    let overview: String
    let poster_path: String
    let media_type: String
    let genre_ids: [Int]
    let release_date: String
    let video: Bool
    let vote_average: Double
}
