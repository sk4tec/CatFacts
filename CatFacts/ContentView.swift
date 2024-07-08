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
    @StateObject var vm = ViewModel()

    var body: some View {
        VStack {
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
