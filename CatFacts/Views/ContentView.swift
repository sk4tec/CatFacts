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
                        NavigationLink(value: cat) {
                            CatListView(cat: cat)
                        }
                    }
                }
                .navigationDestination(for: CatModel.self) { cat in
                    CatDetailView(cat: cat)
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

#Preview {
    CatMasterView()
}
