//
//  PlaceModel.swift
//  KinoKz
//
//  Created by Aknar Assanov on 09.02.2023.
//

import Foundation

struct Result: Codable {
    let pageProps: PageProps

    struct PageProps: Codable {
        let cinemas: [Cinema]

        struct Cinema: Codable {
            let id: Int
            let name: String
            let address: String
            let small_poster: String
            let big_poster: String
        }
    }
}
