//
//  Reddit_ClientApp.swift
//  Reddit Client
//
//  Created by Женя on 24.05.2021.
//

import SwiftUI

@main
struct Reddit_ClientApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            let networkManager = NetworkManager()
            let listViewModel = PostListViewModel(manager: networkManager)
            ContentView(postListViewModel: listViewModel)
        }
    }
}
