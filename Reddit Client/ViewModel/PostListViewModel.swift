//
//  PostsViewModel.swift
//  Reddit Client
//
//  Created by Женя on 24.05.2021.
//

import Foundation
import SwiftUI
import CoreData

class PostListViewModel: ObservableObject {
    let manager: NetworkManager
    private let postsLimit = 50
    private let context = PersistenceController.shared.container.viewContext
    
    @Published var postsVM = [PostViewModel]()

    var posts = [Post]() {
        didSet {
            postsVM = posts.map{ post in
                PostViewModel(post: post)
            }
        }
    }
    
    var fetchingAllowed: Bool {
        posts.count < postsLimit && !UserDefaults.standard.wasLocalDataLoaded
    }
        
    init(manager: NetworkManager) {
        UserDefaults.standard.wasLocalDataLoaded = false
        self.manager = manager
    }
    
    func fetchList() {
        guard fetchingAllowed else { return }
        manager.fetchData(after: posts.last?.name) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let posts):
                    UserDefaults.standard.wasLocalDataLoaded = false
                    self?.posts.append(contentsOf: posts)
                case .failure:
                    self?.loadLocallyStoredData()
                }
            }
        }
    }
    
    func loadLocallyStoredData() {
        let request: NSFetchRequest<PostData> = PostData.fetchRequest()
        do {
            let result = try context.fetch(request)
            self.posts = result.map{ postData in
                Post(from: postData)
            }
            UserDefaults.standard.wasLocalDataLoaded = true
        } catch {
            print("error")
        }
    }
}
