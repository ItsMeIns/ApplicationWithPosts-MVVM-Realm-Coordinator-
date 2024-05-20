//
//  Comments.swift
//  TestApplicationWithPosts
//
//  Created by macbook on 04.10.2023.
//

import Foundation
import RealmSwift

class CommentRealm: Object, Decodable {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var postID: Int
    @Persisted var name: String
    @Persisted var email: String
    @Persisted var body: String 

    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case id, name, email, body
    }
}


