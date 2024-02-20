//
//  User.swift
//  GithubFollowers
//
//  Created by loratech on 18/02/24.
//

import Foundation

struct User: Codable {
    let login: String
    let avatarUrl: String
    var name: String?
    var location: String?
    var bio: String?
    let publicRepos: Int
    let publicGists: Int
    let htmlUrl: String
    let following: Int
    let followers: Int
    let createdAt: String
}

extension User {
    static let sampleUser: User = .init(login: "octocat", avatarUrl: "https://github.com/images/error/octocat_happy.gif", name: "monalisa octocat", location: "San Francisco", bio: "There once was...", publicRepos: 2, publicGists: 1, htmlUrl: "https://github.com/octocat", following: 0, followers: 20, createdAt: "2008-01-14T04:33:35Z")
}
