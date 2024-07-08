//
//  ContentView.swift
//  CatFacts
//
//  Created by Sunjay Kalsi on 08/07/2024.
//

import SwiftUI

struct CatFactResponse: Codable {
    let currentPage: Int
    let data: [Cats]

    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case data
    }
}

struct Cats: Codable {
    let breed, country, origin, coat: String
    let pattern: String
}

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

struct ContentView: View {
    @State var pageNumber: Int = 1
    @State var cats = [CatModel]()

    var body: some View {
        VStack {
            List {
                ForEach(cats) { cat in
                    Text(cat.breed)
                }
            }
        }
        .padding()
        .task {
            do {
                 cats = try await getCats()
            } catch {
                print()
            }
        }
    }

    func getCats(page: Int = 1) async throws -> [CatModel] {
        let pageNumber = String(page)
        let baseUrlString = "https://catfact.ninja/breeds"
        let paginationString = "?pages=\(pageNumber)"

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

#Preview {
    ContentView()
}
