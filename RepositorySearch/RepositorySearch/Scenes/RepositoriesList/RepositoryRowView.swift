//
//  RepositoryRowView.swift
//  RepositorySearch
//
//  Created by Igor Terletskyi on 02.09.2025.
//
import SwiftUI

struct RepositoryRowView: View {
    let repository: Repository
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            if let url = repository.owner.avatarURL {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 50, height: 50)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(repository.name)
                    .font(.headline)
                
                if let description = repository.description {
                    Text(description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                }
            }
            Spacer()
        }
        .padding(.vertical, 4)
    }
}


#Preview {
    let owner = Owner(
        login: "swiftlang",
        id: 42816656,
        avatarURL: URL(string: "https://avatars.githubusercontent.com/u/42816656?v=4")
    )
    
    let repository = Repository(
        id: 44838949,
        name: "swift",
        fullName: "swiftlang/swift",
        description: "The Swift Programming Language",
        stargazersCount: 68999,
        forksCount: 10523,
        htmlURL: URL(string: "https://github.com/swiftlang/swift")!,
        language: "C++",
        owner: owner
    )
    
    RepositoryRowView(repository: repository)
        .previewLayout(.sizeThatFits)
        .padding()
}
