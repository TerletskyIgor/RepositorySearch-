//
//  RepositoriesListView.swift
//  RepositorySearch
//
//  Created by Igor Terletskyi on 02.09.2025.
//

import SwiftUI

struct RepositoriesListView: View {
    let repositories: [Repository]
    
    var body: some View {
        List(repositories) { repo in
            NavigationLink(destination: RepositoryDetailsView(viewModel: RepositoryDetailsViewModel(repository: repo))) {
                RepositoryRowView(repository: repo)
            }
        }
    }
}
