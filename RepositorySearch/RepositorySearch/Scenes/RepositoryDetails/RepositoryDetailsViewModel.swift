//
//  RepositoryDetailsViewModel.swift
//  RepositorySearch
//
//  Created by Igor Terletskyi on 02.09.2025.
//
import Foundation

@MainActor
final class RepositoryDetailsViewModel: ObservableObject {
    let repository: Repository
    
    init(repository: Repository) {
        self.repository = repository
    }
}
