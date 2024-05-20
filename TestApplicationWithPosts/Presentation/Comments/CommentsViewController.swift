//
//  CommentsViewController.swift
//  TestApplicationWithPosts
//
//  Created by macbook on 04.10.2023.
//

import UIKit

class CommentsViewController: UIViewController {
   
    init(post: PostRealm, user: UserRealm) {
        commentsViewModel.post = post
        commentsViewModel.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - properties -
    
    private let commentsViewModel: CommentsViewModel = .init()
    
    private let commentsTable: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(PostsTableViewCell.self, forCellReuseIdentifier: PostsTableViewCell.identifier)
        return table
    }()
    
    //MARK: - life cycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    //MARK: - intents -
    
    private func reloadData() {
        title = commentsViewModel.title
        commentsTable.reloadData()
    }
    
    private func configure() {
        view.backgroundColor = .systemBackground
        commentsTable.backgroundColor = UIColor(red: 29/255, green: 29/255, blue: 29/255, alpha: 1)
        view.addSubview(commentsTable)
        commentsTable.dataSource = self
        commentsTable.delegate = self
        applyConstraints()
        bind()
        commentsViewModel.loadData()
    }
    
    private func bind() {
        commentsViewModel.onState = { [weak self] state in
            switch state {
            case .loading: break
            case .loaded:
                self?.reloadData()
            case .error(let error):
                print(error)
            }
        }
    }
    
    private func applyConstraints() {
        let commentsTableConstraints = [
            commentsTable.topAnchor.constraint(equalTo: view.topAnchor),
            commentsTable.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            commentsTable.leftAnchor.constraint(equalTo: view.leftAnchor),
            commentsTable.rightAnchor.constraint(equalTo: view.rightAnchor)
        ]
        NSLayoutConstraint.activate(commentsTableConstraints)
    }
    
    
}

//MARK: - extension -

extension CommentsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        commentsViewModel.comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostsTableViewCell.identifier, for: indexPath) as? PostsTableViewCell else {
            return UITableViewCell()
        }
        let comment = commentsViewModel.comments[indexPath.row]
        cell.backgroundColor = UIColor(red: 29/255, green: 29/255, blue: 29/255, alpha: 1)
        cell.configureComments(with: comment)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
}
