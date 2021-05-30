//
//  PostList.swift
//  Reddit Client
//
//  Created by Женя on 24.05.2021.
//

import Foundation

struct PostList {
    var posts = [Post]()
}

// MARK: - Decodable
extension PostList: Decodable {
    enum CodingKeys: String, CodingKey {
        case posts = "children"
        case data
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let data = try values.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
        
        posts = try data.decode([Post].self, forKey: .posts)
    }
}
