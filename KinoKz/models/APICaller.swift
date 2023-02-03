//
//  APICaller.swift
//  KinoKz
//
//  Created by Aknar Assanov on 02.02.2023.
//

import Foundation

protocol ApiCallerDelegate {
    func didUpdateMovieList(with movieList: [MovieModel])
    func didFailWithError(_ error: Error)
}

struct APICaller {
    
    var delegate: ApiCallerDelegate?
    
    func fetchRequest() {
        let urlString: String = Constans.Links.trendingUrl
        guard let url = URL(string: urlString) else { fatalError("Incorrect link!") }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let data, error == nil {
                if let movieList = parseJSON(data) {
                    delegate?.didUpdateMovieList(with: movieList)
                } else {
                    delegate?.didFailWithError(error!)
                }
            } else {
                delegate?.didFailWithError(error!)
            }
        }
        task.resume()
    }
    
    func parseJSON(_ data: Data) -> [MovieModel]? {
        var movieList: [MovieModel] = []
        do {
            let decodeData = try JSONDecoder().decode(MovieData.self, from: data)
            for movie in decodeData.results {
                let movieModel = MovieModel(adult: movie.adult, backdrop_path: movie.backdrop_path, id: movie.id, title: movie.title, overview: movie.overview, posterPath: movie.poster_path, mediaType: movie.media_type, genreIds: movie.genre_ids, releaseDate: movie.release_date, video: movie.video, voteAverage: movie.vote_average)
                movieList.append(movieModel)
            }
        } catch {
            print(error)
            return nil
        }
        return movieList
    }
}
