//
//  CatDetailView.swift
//  CatFacts
//
//  Created by Sunjay Kalsi on 08/07/2024.
//

import SwiftUI

struct CatDetailView: View {
    var cat: CatModel

    var body: some View {
        VStack {
            List {
                Text("Breed: \(cat.breed)")
                Text("Country: \(cat.country)")
                Text("Origin: \(cat.origin)")
                Text("Coat: \(cat.coat)")
                Text("Pattern: \(cat.pattern)")
            }
        }
    }
}

#Preview {
    CatDetailView(cat: .init(breed: "Ragamuffin", country: "USA", origin: "Natural", coat: "Short", pattern: "All"))
}
