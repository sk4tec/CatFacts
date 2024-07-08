//
//  Network.swift
//  CatFacts
//
//  Created by Sunjay Kalsi on 08/07/2024.
//

import Foundation

class Network {
    // MARK: State
    var next: String?
    var previous: String?
    var page = ""

    public init() {
        self.page = "https://catfact.ninja/breeds?page=0"
    }

    func getPrevious() async -> [CatModel]?  {
        guard let previous = previous else { return nil }
        do {
            return try await getCats(urlPage: previous)
        } catch {
            print("Error \(error)")
            return nil
        }
    }

    func getNext() async -> [CatModel]? {
        guard let next = next else { return nil }
        do {
            return try await getCats(urlPage: next)
        } catch {
            print("Error \(error)")
            return nil
        }
    }

    func getCats(urlPage: String) async throws -> [CatModel] {
        guard let url = URL(string: urlPage) else { return [] }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return [] }

        let jsonDecoder = JSONDecoder()
        let catFactsResponse = try jsonDecoder.decode(CatFactResponse.self, from: data)
        let cats = catFactsResponse.data.map { cat in
            CatModel(breed: cat.breed, country: cat.country, origin: cat.origin, coat: cat.coat, pattern: cat.pattern)
        }

        self.next = catFactsResponse.nextPageURL
        self.previous = catFactsResponse.prevPageURL

        return cats
    }
}
