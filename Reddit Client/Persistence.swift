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
    
    func isNewPostDataAllowed() -> Bool {
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
}
