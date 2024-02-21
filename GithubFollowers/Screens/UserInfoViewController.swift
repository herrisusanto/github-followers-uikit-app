//
//  UserInfoViewController.swift
//  GithubFollowers
//
//  Created by loratech on 19/02/24.
//

import UIKit
import SafariServices

protocol UserInfoViewControllerDelegate: AnyObject {
    func didTapGithubProfile(for user: User)
    func didTapGetFollowers(for user: User)
}

class UserInfoViewController: GFDataLoadingViewController {
    
    var username: String! = "herisusantuy"
    weak var delegate: FollowerListViewControllerDelegate!
    
    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    let dateLabel = GFBodyLabel(textAlignment: .center)
    
    var itemViews: [UIView] = []

    fileprivate func configureViewController() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissViewController))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    fileprivate func configureUIElements(with user: User) {
        let repoItemViewController = GFRepoItemViewController(user: user)
        repoItemViewController.delegate = self
        
        let followerItemViewController = GFFollowerItemViewController(user: user)
        followerItemViewController.delegate = self
        
        self.add(childViewController: GFUserInfoHeaderViewController(user: user), to: self.headerView)
        self.add(childViewController: repoItemViewController, to: self.itemViewOne)
        self.add(childViewController: followerItemViewController, to: self.itemViewTwo)
        self.dateLabel.text = "Github since \(user.createdAt.toDisplayFormat())"
    }
    
    fileprivate func getUserInfo() {
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.configureUIElements(with: user)
                }
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong!", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        
        layoutUI()
        
        getUserInfo()
        
        
    }
    
    @objc func dismissViewController() {
        dismiss(animated: true)
    }
    
    func layoutUI() {
        let padding: CGFloat = 20
        let itemHeight: CGFloat = 140
        let headerHeight: CGFloat = 180
        
        itemViews = [headerView, itemViewOne, itemViewTwo, dateLabel]
        
        for itemView in itemViews {
            view.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
            ])
        }
        
         
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: headerHeight),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
            
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    func add(childViewController: UIViewController, to containerView: UIView) {
        addChild(childViewController)
        containerView.addSubview(childViewController.view)
        childViewController.view.frame = containerView.bounds
        childViewController.didMove(toParent: self)
    }
}

extension UserInfoViewController: UserInfoViewControllerDelegate {
    
    func didTapGithubProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            presentGFAlertOnMainThread(title: "Invalid URL", message: "The url attached to this user is invalid.", buttonTitle: "Ok ")
            return
        }
        
        presentSafariViewController(with: url)
    }
    
    func didTapGetFollowers(for user: User) {
        guard user.followers != 0 else {
            presentGFAlertOnMainThread(title: "No followers", message: "This user has no followers. What a shame (; ", buttonTitle: "Ok")
            return
        }
        delegate.didRequestFollowers(for: user.login)
        dismissViewController()
    }
    
    
}

#Preview("User Info View Controller"){
    UserInfoViewController()
}
