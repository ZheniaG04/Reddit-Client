//
//  PostViewModel.swift
//  Reddit Client
//
//  Created by Женя on 29.05.2021.
//

import Foundation
import UIKit

struct PostViewModel: Identifiable {
    
    //MARK: - Private properties

    private let post: Post
    
    //MARK: - Public properties

    var id: String {
        post.id
    }
    
    var title: String {
        post.title
    }
    
    var author: String {
        post.author
    }
    
    var image: UIImage {
        post.image ?? UIImage(named: "no-image")!
    }
    
    var url: String {
        post.url
    }
    
    var thumbnail: String {
        post.thumbnail
    }
    
    var comments: String {
        String(post.comments)
    }
    
    var isSavingEnable: Bool {
        if let postHint = post.postHint, postHint == "image" {
            return true
        }
        return false
    }
    
    var creationTime: String {
        let date = Date(timeIntervalSince1970: post.createdUTC)
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: date, relativeTo: Date())
    }
    
    //MARK: - Initialization

    init(post: Post) {
        self.post = post
    }
    
    //MARK: - Public methods

    func savePostLocally() {
        PersistenceController.shared.savePostLocally(post: post)
    }
}
