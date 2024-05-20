//
//  Post.swift
//  TestApplicationWithPosts
//
//  Created by macbook on 02.10.2023.
//

import Foundation
import RealmSwift

class PostRealm: Object, Decodable {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var userID: Int
    @Persisted var title: String
    @Persisted var body: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
}


