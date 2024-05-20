//
//  CommentsViewModel.swift
//  TestApplicationWithPosts
//
//  Created by macbook on 12.10.2023.
//

import Foundation

final class CommentsViewModel {
    
    //MARK: - Content -
    
    var post: PostRealm?
    var user: UserRealm?
    private var titleComment: String = ""
    
    private(set) var comments: [CommentRealm] = []
    
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
        "\(titleComment)"
    }
    
    //MARK: - intents -
    
    func loadData() {
        guard let selectedUser = user  else { return }
        
        NetworkManager.shared.getComment(selectedUser.id) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let comments):
                RealmManager.shared.saveCommentRealm(model: comments)
                let userComments = comments.filter { $0.postID == selectedUser.id }
                self.comments = userComments
                self.titleComment = "Comments (\(userComments.count))"
                self.state = .loaded
            case .failure(let error):
                self.error(error)
                let commentsRealm = RealmManager.shared.loadFromRealm(CommentRealm.self)
                let userComments = commentsRealm.filter { $0.postID == selectedUser.id }
                self.comments = userComments
                self.titleComment = "Comments (\(userComments.count))"
                self.state = .loaded
            }
        }
    }
    
    private func error(_ error: Error) {
        state = .error(error.localizedDescription)
    }
}
