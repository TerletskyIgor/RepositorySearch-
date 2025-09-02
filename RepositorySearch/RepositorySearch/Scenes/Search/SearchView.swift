//
//  ContentView.swift
//  RepositorySearch
//
//  Created by Igor Terletskyi on 02.09.2025.
//

import SwiftUI

struct SearchView: View {
    @StateObject private var vm = SearchViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                    TextField("Search repositories", text: $vm.query)
                        .textFieldStyle(.roundedBorder)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .onSubmit { vm.onQueryChanged() }
                }
                .padding()
                
                if vm.isLoading {
                    ProgressView("Searching...")
                        .padding()
                }
                
                if let error = vm.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .padding([.leading, .trailing])
                }
                
                RepositoriesListView(repositories: vm.repositories)
                    .listStyle(.plain)
            }
            .navigationTitle("GitHub Search")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    SearchView()
}
