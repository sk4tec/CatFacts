//
//  CatResponse.swift
//  CatFacts
//
//  Created by Sunjay Kalsi on 08/07/2024.
//

import Foundation

struct CatFactResponse: Codable {
    struct Cats: Codable {
        let breed, country, origin, coat: String
        let pattern: String
    }

    let currentPage: Int
    let data: [Cats]
    let nextPageURL, prevPageURL: String?

    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case data
        case nextPageURL = "next_page_url"
        case prevPageURL = "prev_page_url"
    }
}
