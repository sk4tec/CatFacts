//
//  CatMasterView.swift
//  CatFacts
//
//  Created by Sunjay Kalsi on 08/07/2024.
//

import SwiftUI

struct CatListView: View {
    let cat: CatModel

    var body: some View {
        VStack(alignment: .leading) {
            Text(cat.breed)
                .font(.title3)
            Text(cat.coat)
        }
    }
}

#Preview {
    CatListView(cat: .init(breed: "Breed", country: "UK", origin: "Origin", coat: "Coat", pattern: "stripes"))
}
