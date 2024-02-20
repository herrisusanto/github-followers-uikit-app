//
//  UserInfoViewController.swift
//  GithubFollowers
//
//  Created by loratech on 19/02/24.
//

import UIKit

class UserInfoViewController: UIViewController {
    
    var username: String! = "herisusantuy"
    let headerView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissViewController))
        navigationItem.rightBarButtonItem = doneButton 
        
        layoutUI()
        
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.add(childViewController: GFUserInfoHeaderViewController(user: user), to: self.headerView)
                }
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong!", message: error.rawValue, buttonTitle: "Ok")
            }
        }
        
        
    }
    
    @objc func dismissViewController() {
        dismiss(animated: true)
    }
    
    func layoutUI() {
        view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180)
        ])
    }
    
    func add(childViewController: UIViewController, to containerView: UIView) {
        addChild(childViewController)
        containerView.addSubview(childViewController.view)
        childViewController.view.frame = containerView.bounds
        childViewController.didMove(toParent: self)
    }
}

#Preview("User Info View Controller"){
    UserInfoViewController()
}
