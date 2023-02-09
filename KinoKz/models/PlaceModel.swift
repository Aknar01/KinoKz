//
//  PlaceModel.swift
//  KinoKz
//
//  Created by Aknar Assanov on 09.02.2023.
//

import Foundation

struct PlaceModel: Codable {
    let id: Int
    let name: String
    let address: String
    let smallPoster: String
    let bigPoster: String
}
