//
//  PlaceAPICaller.swift
//  KinoKz
//
//  Created by Aknar Assanov on 09.02.2023.
//

import Foundation

protocol PlaceApiCallerDelegate {
    func didUpdateMovieList(with placeList: [PlaceModel])
    func didFailWithError(_ error: Error)
}

struct PlaceAPICaller {
    
    var delegate: PlaceApiCallerDelegate?
    
    func fetchRequerst() {
        guard let path = Bundle.main.path(forResource: "cinemas", ofType: "json") else { return }
        let url = URL(fileURLWithPath: path)

        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let data, error == nil {
                if let placeList = parseJSON(data) {
                    delegate?.didUpdateMovieList(with: placeList)
                } else {
                    delegate?.didFailWithError(error!)
                }
            } else {
                delegate?.didFailWithError(error!)
            }
        }
        task.resume()
    }
    
    func parseJSON(_ data: Data) -> [PlaceModel]? {
        var placesList: [PlaceModel] = []
        do {
            
            let result = try JSONDecoder().decode(Result.self, from: data)
            
            
            for place in result.pageProps.cinemas {
                let placeModel = PlaceModel(id: place.id, name: place.name, address: place.address, smallPoster: place.small_poster, bigPoster: place.big_poster)
                placesList.append(placeModel)
            }
        } catch {
            print(error)
            return nil
        }
        return placesList
    }
}
