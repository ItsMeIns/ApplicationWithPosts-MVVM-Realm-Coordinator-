//
//  MainViewModel.swift
//  TestApplicationWithPosts
//
//  Created by macbook on 12.10.2023.
//

import Foundation



final class MainViewModel {
    
    //MARK: - Content -
    
    var selectedUser: UserRealm?
    var selectedPost: PostRealm?
    
    private(set) var users: [UserRealm] = []
    private(set) var posts: [PostRealm] = []
    
    enum State {
        case loading
        case loaded
        case error(String)
    }
    
    var state: State = .loading {
        didSet {
            onState?(state)
        }
    }
    var onState: ((State) -> Void)?
    
    var title: String? {
        if let selectedUser = selectedUser {
            return selectedUser.name
        } else {
            return users.first?.name
        }
    }
    
    //MARK: - intents -
    
    func fetchData() {
        NetworkManager.shared.getPost { [weak self] postResult in
            guard let self = self else { return }
            
            switch postResult {
            case let (.success(posts)):
                RealmManager.shared.savePostRealm(model: posts)
                self.posts = posts
                self.result(self.posts)
                state = .loaded
            case let (.failure(postError)):
                self.error(postError)
                let realmPosts = RealmManager.shared.loadFromRealm(PostRealm.self)
                self.result(realmPosts)
                state = .loaded
            }
        }
        
        NetworkManager.shared.getUser { [weak self] userResult in
            guard let self = self else { return }
            
            switch userResult {
            case let (.success(users)):
                RealmManager.shared.saveUserRealm(model: users)
                self.users = users
                setTitleForFirstUser()
                state = .loaded
            case let (.failure(userError)):
                self.error(userError)
                let realmUsers = RealmManager.shared.loadFromRealm(UserRealm.self)
                self.users = realmUsers
                setTitleForFirstUser()
                state = .loaded
            }
        }
        
    }
    
    
    private func result(_ posts: [PostRealm]) {
        let filteredPosts = posts.filter { $0.userID == 1 }
        self.posts = filteredPosts
        state = .loaded
    }
    
    
    func handleUserSelection() {
        guard let selectedUser = selectedUser else { return }
        
        NetworkManager.shared.getPost { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let posts):
                let filteredPosts = posts.filter { $0.userID == selectedUser.id }
                self.posts = filteredPosts
                state = .loaded
            case .failure(let error):
                self.error(error)
                
                let realmPost = RealmManager.shared.loadFromRealm(PostRealm.self)
                let filteredRealmPosts = realmPost.filter { $0.userID == selectedUser.id }
                self.posts = filteredRealmPosts
                state = .loaded
            }
        }
    }
    
    func setTitleForFirstUser() {
        if let firstUser = users.first {
            selectedUser = firstUser
        }
        
    }
    
    private func error(_ error: Error) {
        state = .error(error.localizedDescription)
    }
}


