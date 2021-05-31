//
//  Persistence.swift
//  Reddit Client
//
//  Created by Женя on 24.05.2021.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    private let entitiesLimit = 20 // limit for saved posts due to the task
    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Reddit_Client")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {

                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
    
    private func isNewPostDataAllowed() -> Bool {
        // this method checks whether the number of saved posts has reached the limit
        let request: NSFetchRequest<PostData> = PostData.fetchRequest()
        do {
            let actualQty = try container.viewContext.count(for: request)
            return actualQty < entitiesLimit
        } catch {
            print("error")
        }
        return false
    }
    
    func savePostLocally(post: Post) {
        guard isNewPostDataAllowed() else { return }
        
        let newPost = PostData(context: container.viewContext)
        newPost.id = post.id
        newPost.name = post.name
        newPost.title = post.title
        newPost.author = post.author
        newPost.url = post.url
        newPost.thumbnail = post.thumbnail
        newPost.postHint = post.postHint
        newPost.comments = Int16(post.comments)
        newPost.createdUTC = post.createdUTC
        newPost.image = post.image?.jpegData(compressionQuality: 1)
        do {
            try container.viewContext.save()
        } catch {
            print("error during saving")
        }
    }
    
    func loadLocallyStoredPosts() -> [Post] {
        let request: NSFetchRequest<PostData> = PostData.fetchRequest()
        do {
            let result = try container.viewContext.fetch(request)
            return result.map{ postData in
                Post(from: postData)
            }
        } catch {
            print("error")
        }
        return []
    }
}
