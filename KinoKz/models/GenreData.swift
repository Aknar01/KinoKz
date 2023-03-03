//
//  GenreData.swift
//  KinoKz
//
//  Created by Aknar Assanov on 09.02.2023.
//

import Foundation

struct GenreData: Decodable {
    let genres: [Genre]
    
    struct Genre: Decodable {
        let id: Int
        let name: String
    }

}

