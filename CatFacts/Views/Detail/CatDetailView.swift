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
                Text(cat.breed)
                Text(cat.country)
                Text(cat.origin)
                Text(cat.coat)
                Text(cat.pattern)
            }
        }
    }
}

#Preview {
    CatDetailView(cat: .init(breed: "Ragamuffin", country: "USA", origin: "Natural", coat: "Short", pattern: "All"))
}
