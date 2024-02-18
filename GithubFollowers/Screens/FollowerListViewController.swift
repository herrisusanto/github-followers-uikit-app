//
//  FollowerListViewController.swift
//  GithubFollowers
//
//  Created by loratech on 15/02/24.
//

import UIKit

class FollowerListViewController: UIViewController {
    
    var username: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        NetworkManager.shared.getFollowers(for: username, page: 1) { followers, errorMessage in
            guard let followers  else {
                self.presentGFAlertOnMainThread(title: "Bad Stuff Happened", message: errorMessage!, buttonTitle: "Ok")
                return
            }
            print("Followers.count : \(followers.count)")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
 
