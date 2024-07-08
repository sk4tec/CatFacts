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
    let nextPageURL, prevPageURL: String?

    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case data
        case nextPageURL = "next_page_url"
        case prevPageURL = "prev_page_url"
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
    @StateObject var vm = ViewModel()

    var body: some View {
        VStack {
            Button("Next") {
                Task { await vm.getNext() }
            }
            Button("Previous") {
                Task { await vm.getPrevious() }
            }
            List {
                ForEach(vm.cats) { cat in
                    Text(cat.breed)
                }
            }
        }
        .padding()
        .task {
            await vm.load()
        }
    }
}

#Preview {
    ContentView()
}
