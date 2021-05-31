//
//  PostsViewModel.swift
//  Reddit Client
//
//  Created by Женя on 24.05.2021.
//

import Foundation

class PostListViewModel: ObservableObject {
    
    //MARK: - Private properties
    
    private let manager: NetworkManager
    private let postsLimit = 50 // posts limit due to the task
    private var wasLocalDataLoaded = false
    
    //MARK: - Public properties
    
    @Published var postsVM = [PostViewModel]()

    var posts = [Post]() {
        didSet {
            postsVM = posts.map{ post in
                PostViewModel(post: post)
            }
        }
    }
    
    var fetchingAllowed: Bool {
        // do not fetch data when the limit is reached or when it is local data
        posts.count < postsLimit && !wasLocalDataLoaded
    }
        
    //MARK: - Initialization
    
    init(manager: NetworkManager) {
        self.manager = manager
    }
    
    //MARK: - Public methods
    
    func fetchList() {
        guard fetchingAllowed else { return }
        manager.fetchData(after: posts.last?.name) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let posts):
                    self?.posts.append(contentsOf: posts)
                case .failure:
                    self?.posts = PersistenceController.shared.loadLocallyStoredPosts()
                    self?.wasLocalDataLoaded = true
                }
            }
        }
    }
}
