//
//  PostsTableViewCell.swift
//  TestApplicationWithPosts
//
//  Created by macbook on 02.10.2023.
//

import UIKit

class PostsTableViewCell: UITableViewCell {
    
    static let identifier = "PostsTableViewCell"
    
    private let postTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    private let postBody: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        [postBody, postTitle].forEach(contentView.addSubview)
        
        applyConstraints()
        
    }
    
    private func applyConstraints() {
        let postTitleConstraints = [
            postTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            postTitle.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            postTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ]
        
        let postBodyConstraints = [
            postBody.topAnchor.constraint(equalTo: postTitle.bottomAnchor, constant: 8),
            postBody.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            postBody.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            postBody.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ]
        
        NSLayoutConstraint.activate(postTitleConstraints)
        NSLayoutConstraint.activate(postBodyConstraints)
    }
    
    public func configure(with model: PostRealm) {
        postTitle.text = model.title
        postBody.text = model.body
    }
    
    public func configureComments(with model: CommentRealm) {
        postTitle.text = model.name
        postBody.text = model.body
    }
    
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}
