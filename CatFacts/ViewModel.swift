//
//  ViewModel.swift
//  CatFacts
//
//  Created by Sunjay Kalsi on 08/07/2024.
//

import Foundation

class ViewModel: ObservableObject {
    @Published var cats = [CatModel]()
    @Published var pageNumber: Int = 1

    func load() async {
        do {
            self.cats = try await getCats(page: pageNumber)
        } catch {
            print("Error \(error)")
        }
    }

    func getCats(page: Int = 1) async throws -> [CatModel] {
        let pageNumber = String(page)
        let baseUrlString = "https://catfact.ninja/breeds"
        let paginationString = "?page=\(pageNumber)"

        guard let url = URL(string: baseUrlString + paginationString) else { return [] }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return [] }

        let jsonDecoder = JSONDecoder()
        let catFactsResponse = try jsonDecoder.decode(CatFactResponse.self, from: data)
        let cats = catFactsResponse.data.map { cat in
            CatModel(breed: cat.breed, country: cat.country, origin: cat.origin, coat: cat.coat, pattern: cat.pattern)
        }

        return cats
    }
}
