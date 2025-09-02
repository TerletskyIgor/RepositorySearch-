//
//  RepositoryDetailsView.swift
//  RepositorySearch
//
//  Created by Igor Terletskyi on 02.09.2025.
//

import SwiftUI

struct RepositoryDetailsView: View {
    @ObservedObject var viewModel: RepositoryDetailsViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    if let url = viewModel.repository.owner.avatarURL {
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .scaledToFit()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                    }
                    
                    VStack(alignment: .leading) {
                        Text(viewModel.repository.name)
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        Text("by \(viewModel.repository.owner.login)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
                
                if let description = viewModel.repository.description {
                    Text(description)
                        .font(.body)
                }
                
                HStack {
                    Label("\(viewModel.repository.stargazersCount) stars", systemImage: "star.fill")
                    Label("\(viewModel.repository.forksCount) forks", systemImage: "tuningfork")
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
                
                if let url = viewModel.repository.htmlURL {
                    Link("Open on GitHub", destination: url)
                        .font(.headline)
                        .foregroundColor(.blue)
                }
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

//#Preview {
//    RepositoryDetailsView()
//}
