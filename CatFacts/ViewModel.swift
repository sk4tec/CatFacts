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
    @Published var previous = true
    @Published var next = true

    // MARK: Services
    let network = Network()

    public init() {
        self.page = "https://catfact.ninja/breeds?page=0"
    }

    func load() async {
        do {
            self.cats = try await network.getCats(urlPage: page)
            self.next = ((network.next?.isEmpty) == nil)
            self.previous = ((network.previous?.isEmpty) == nil)
        } catch {
            print("Error \(error)")
        }
    }

    func getPrevious() async {
        if let results = await network.getPrevious() {
            self.cats = results
            self.next = ((network.next?.isEmpty) == nil)
            self.previous = ((network.previous?.isEmpty) == nil)
        }
    }

    func getNext() async {
        if let results = await network.getNext() {
            self.cats = results
            self.next = ((network.next?.isEmpty) == nil)
            self.previous = ((network.previous?.isEmpty) == nil)
        }
    }
}
