//
//  Constans.swift
//  KinoKz
//
//  Created by Aknar Assanov on 02.02.2023.
//

import Foundation

struct Constans {
    
    struct Keys {
        static let api = "20054e9c4910d8fe181ac94757065240"
    }
    
    struct Identifiers {
        static let categoryCollectionViewCell = "CategoryCollectionViewCell"
        static let trendingCollectionViewCell = "TrendingCollectionViewCell"
        static let categoryTableViewCell = "CategoryTableViewCell"
        static let movieCollectionViewCell = "MovieCollectionViewCell"
    }
    
    struct Values {
        
    }
    
    struct Colors {
        
    }
    
    struct Links {
        static let apiUrl = "https://api.themoviedb.org/3/"
        static let trendingUrl = "\(apiUrl)trending/movie/day?api_key=\(Keys.api)"
        static let imageUrl = "https://image.tmdb.org/t/p/w500/"
    }
}

enum Category: String, CaseIterable {
    case all = "🔥All"
    case streaming = "🎥Streaming"
    case onTV = "📺On TV"
    case inTheaters = "🍿In Theaters"
}

