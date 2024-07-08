//
//  ContentView.swift
//  CatFacts
//
//  Created by Sunjay Kalsi on 08/07/2024.
//

import SwiftUI

struct CatMasterView: View {
    @StateObject var vm = ViewModel()

    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Button("Previous") {
                        Task { await vm.getPrevious() }
                    }
                    Spacer()
                    Button("Next") {
                        Task { await vm.getNext() }
                    }
                }
                List {
                    ForEach(vm.cats) { cat in
                        NavigationLink {
                            CatDetailView()
                        } label: {
                            ExtractedView(cat: cat)
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
            .task {
                await vm.load()
            }
            .navigationTitle("Cat Facts")
        }
    }
}

struct CatDetailView: View {
    var body: some View {
        Text("Detail View")
    }
}

#Preview {
    CatMasterView()
}

struct ExtractedView: View {
    let cat: CatModel

    var body: some View {
        VStack(alignment: .leading) {
            Text(cat.breed)
                .font(.title3)
            Text(cat.coat)
        }
    }
}
