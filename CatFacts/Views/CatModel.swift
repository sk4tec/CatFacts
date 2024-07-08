//
//  CatModel.swift
//  CatFacts
//
//  Created by Sunjay Kalsi on 08/07/2024.
//

import Foundation

struct CatModel: Identifiable {
    let id = UUID()
    let breed, country, origin, coat: String
    let pattern: String

    public init(breed: String, country: String, origin: String, coat: String, pattern: String) {
        self.breed = breed
        self.country = country
        self.origin = origin
        self.coat = coat
        self.pattern = pattern
    }
}
