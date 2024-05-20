//
//  ViewController.swift
//  TestApplicationWithPosts
//
//  Created by macbook on 02.10.2023.
//
import RealmSwift
import UIKit

class MainViewController: UIViewController {
    
    //MARK: - properties -
    
    var mainViewModel: MainViewModel = .init()
    
    private let postsTable: UITableView = {
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
    
    private func configure() {
        view.backgroundColor = .systemBackground
        postsTable.backgroundColor = UIColor(red: 29/255, green: 29/255, blue: 29/255, alpha: 1)
        
        view.addSubview(postsTable)
        
        postsTable.delegate = self
        postsTable.dataSource = self
        applyConstraints()
        configureNavBar()
        
        mainViewModel.fetchData()
        bind()
    }
    
    private func bind() {
        mainViewModel.onState = { [weak self] state in
            switch state {
            case .loading: break
            case .loaded:
                self?.reloadData()
            case .error(let error):
                print(error)
            }
        }
    }
    
    private func reloadData() {
        title = mainViewModel.title
        postsTable.reloadData()
    }
    
    private func configureNavBar() {
        var image = UIImage(named: "userIcon")
        image = image?.withRenderingMode(.alwaysTemplate)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image,  style: .done, target: self, action: #selector(openUserList))
        navigationController?.navigationBar.tintColor = .white
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    @objc func openUserList() {
        let alertController = UIAlertController(title: "", message: nil, preferredStyle: .actionSheet)
        for user in mainViewModel.users {
            let action = UIAlertAction(title: user.name, style: .default) { _ in
                self.mainViewModel.selectedUser = user
                self.mainViewModel.handleUserSelection()
            }
            let textColor = UIColor.white
            action.setValue(textColor, forKey: "titleTextColor")
            alertController.addAction(action)
        }
        present(alertController, animated: true, completion: nil)
    }
    
    private func applyConstraints() {
        let postsTableConstraints = [
            postsTable.topAnchor.constraint(equalTo: view.topAnchor),
            postsTable.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            postsTable.leftAnchor.constraint(equalTo: view.leftAnchor),
            postsTable.rightAnchor.constraint(equalTo: view.rightAnchor)
        ]
        NSLayoutConstraint.activate(postsTableConstraints)
    }
    
}

//MARK: - extension -

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        mainViewModel.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostsTableViewCell.identifier, for: indexPath) as? PostsTableViewCell else {
            return UITableViewCell()
        }
        let post = mainViewModel.posts[indexPath.row]
        cell.backgroundColor = UIColor(red: 29/255, green: 29/255, blue: 29/255, alpha: 1)
        cell.configure(with: post)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPost = mainViewModel.posts[indexPath.row]
        self.mainViewModel.selectedPost = selectedPost
        showCommentsScreen(for: selectedPost)
    }
    
    private func showCommentsScreen(for post: PostRealm) {
        guard let selectedUser = mainViewModel.selectedUser else { return }
        let vc = CommentsViewController(post: post, user: selectedUser)
        navigationController?.pushViewController(vc, animated: true)
        
    }
}



extension Result {
    @discardableResult
    func success(_ handler: (Success) -> Void) -> Self {
        guard case let .success(value) = self else { return self }
        handler(value)
        return self
    }
    @discardableResult
    func failure(_ handler: (Failure) -> Void) -> Self {
        guard case let .failure(error) = self else { return self }
        handler(error)
        return self
    }
}



//class MainTableViewProvider: NSObject {
//
//}
