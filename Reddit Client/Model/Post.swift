//
//  Post.swift
//  Reddit Client
//
//  Created by Женя on 24.05.2021.
//

import Foundation
import UIKit

struct Post {
    var id: String
    var name: String
    var title: String
    var author: String
    var url: String
    var thumbnail: String
    var postHint: String?
    var comments: Int
    var createdUTC: TimeInterval
    var image: UIImage?
}

// MARK: - Decodable
extension Post: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case title
        case author
        case url
        case thumbnail
        case post_hint
        case num_comments
        case created_utc
        case data
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let dataContainer = try values.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
        
        id = try dataContainer.decode(String.self, forKey: .id)
        name = try dataContainer.decode(String.self, forKey: .name)
        title = try dataContainer.decode(String.self, forKey: .title)
        author = try dataContainer.decode(String.self, forKey: .author)
        url = try dataContainer.decode(String.self, forKey: .url)
        thumbnail = try dataContainer.decode(String.self, forKey: .thumbnail)
        postHint = try dataContainer.decodeIfPresent(String.self, forKey: .post_hint)
        comments = try dataContainer.decode(Int.self, forKey: .num_comments)
        createdUTC = try dataContainer.decode(TimeInterval.self, forKey: .created_utc)
        
        if let thumbnailURL = URL(string: thumbnail), let data = try? Data(contentsOf: thumbnailURL) {
            image = UIImage(data: data)
        }
    }
    
    init(from postData: PostData) {
        id = postData.id ?? ""
        name = postData.name ?? ""
        title = postData.title ?? ""
        author = postData.author ?? ""
        url = postData.url ?? ""
        thumbnail = postData.thumbnail ?? ""
        postHint = postData.postHint
        comments = Int(postData.comments)
        createdUTC = postData.createdUTC
        if let data = postData.image {
            image = UIImage(data: data)
        }
    }
}
