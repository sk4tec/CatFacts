//
//  ViewModel.swift
//  CatFacts
//
//  Created by Sunjay Kalsi on 08/07/2024.
//

import Foundation

class ViewModel: ObservableObject {
    // MARK: Published
    @Published var cats = [CatModel]()
    @Published var page = ""

    // MARK: Services
    let network = Network()

    public init() {
        self.page = "https://catfact.ninja/breeds?page=0"
    }

    @MainActor
    func load() async {
        do {
            self.cats = try await network.getCats(urlPage: page)
        } catch {
            print("Error \(error)")
        }
    }

    func getPrevious() async {
        if let results = await network.getPrevious() {
            self.cats = results
        }
    }

    func getNext() async {
        if let results = await network.getNext() {
            self.cats = results
        }
    }
}
