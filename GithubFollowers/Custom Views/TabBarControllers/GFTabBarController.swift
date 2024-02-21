//
//  GFTabBarController.swift
//  GithubFollowers
//
//  Created by loratech on 21/02/24.
//

import UIKit

class GFTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .systemGreen
        viewControllers = [
            createSearchNavigationController(),
            createFavoritesNavigationController()
        ]
    }
    

    func createSearchNavigationController() -> UINavigationController {
        let searchViewController = SearchViewController()
        searchViewController.title = "Search"
        searchViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        return UINavigationController(rootViewController: searchViewController)
    }
    
    func createFavoritesNavigationController() -> UINavigationController {
        let favoritesViewController = FavoritesListViewController()
        favoritesViewController.title = "Favorites"
        favoritesViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        return UINavigationController(rootViewController: favoritesViewController)
    } 

}
