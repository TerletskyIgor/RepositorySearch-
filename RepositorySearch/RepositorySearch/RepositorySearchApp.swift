//
//  RepositorySearchApp.swift
//  RepositorySearch
//
//  Created by Igor Terletskyi on 02.09.2025.
//

import SwiftUI

@main
struct RepositorySearchApp: App {
    
    init() {
        let token = "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"
        KeychainHelper.shared.setupGitHubToken(token)
    }
    
    var body: some Scene {
        WindowGroup {
            SearchView()
        }
    }
}
