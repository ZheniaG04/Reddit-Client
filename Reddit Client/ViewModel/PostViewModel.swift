//
//  PostViewModel.swift
//  Reddit Client
//
//  Created by Женя on 29.05.2021.
//

import Foundation
import UIKit
import CoreData

struct PostViewModel: Identifiable {
    
    let post: Post
    private let context = PersistenceController.shared.container.viewContext
    
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
    
    func savePostLocally() {
        let request: NSFetchRequest<PostData> = PostData.fetchRequest()
        do {
            let result = try context.count(for: request)
        } catch {
            print("error")
        }
        let newPost = PostData(context: context)
        newPost.id = post.id
        newPost.name = post.name
        newPost.title = post.title
        newPost.author = post.author
        newPost.url = post.url
        newPost.thumbnail = post.thumbnail
        newPost.postHint = post.postHint
        newPost.comments = Int16(post.comments)
        newPost.createdUTC = post.createdUTC
        newPost.image = image.jpegData(compressionQuality: 1)
        do {
            try context.save()
        } catch {
            print("error during saving")
        }
    }
}
