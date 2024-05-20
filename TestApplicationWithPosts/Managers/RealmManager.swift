//
//  RealmManager.swift
//  TestApplicationWithPosts
//
//  Created by macbook on 14.10.2023.
//

import Foundation
import RealmSwift

class RealmManager {
    
    static let shared = RealmManager()
    
    private init() {}
    
    let localRealm = try! Realm()
    
    func saveUserRealm(model: [UserRealm]) {
        try! localRealm.write {
            localRealm.add(model, update: .modified)
        }
    }
    
    func savePostRealm(model: [PostRealm]) {
        try! localRealm.write {
            localRealm.add(model, update: .modified)
        }
    }
    
    func saveCommentRealm(model: [CommentRealm]) {
        try! localRealm.write {
            localRealm.add(model, update: .modified)
        }
    }
   
    func loadFromRealm<T: Object>(_ objectType: T.Type, filter: String? = nil) -> [T] {
        let realm = try! Realm()
        var objects: Results<T>

        if let filter = filter {
            objects = realm.objects(objectType).filter(filter)
        } else {
            objects = realm.objects(objectType)
        }

        let objectArray = Array(objects)
        
        return objectArray
    }


}

