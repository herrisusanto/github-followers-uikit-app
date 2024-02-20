//
//  GFItemInfoView.swift
//  GithubFollowers
//
//  Created by loratech on 20/02/24.
//

import UIKit


enum ItemInfoType {
    case repos
    case gists
    case followers
    case following
    
    var title: String {
        switch self {
        case .repos:
            return "Public Repos"
        case .gists:
            return "Public Gists"
        case .followers:
            return "Followers"
        case .following:
            return "Following"
        }
    }
    
    var systemImage: String {
        switch self {
        case .repos:
            return SFSymbols.repos
        case .gists:
            return SFSymbols.gists
        case .followers:
            return SFSymbols.followers
        case .following:
            return SFSymbols.following
        }
    }
}

class GFItemInfoView: UIView {
    
    let symbolImageView = UIImageView()
    let titleLabel = GFTitleLabel(textAlignment: .left, fontSize: 14)
    let countLabel = GFTitleLabel(textAlignment: .center, fontSize: 14)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(symbolImageView)
        addSubview(titleLabel)
        addSubview(countLabel) 
        
        symbolImageView.translatesAutoresizingMaskIntoConstraints = false
        symbolImageView.contentMode = .scaleAspectFill
        symbolImageView.tintColor = .label
        
        
        NSLayoutConstraint.activate([
            symbolImageView.topAnchor.constraint(equalTo: self.topAnchor),
            symbolImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            symbolImageView.widthAnchor.constraint(equalToConstant: 20),
            symbolImageView.heightAnchor.constraint(equalToConstant: 20),
            
            
            titleLabel.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 18),
            
            
            countLabel.topAnchor.constraint(equalTo: symbolImageView.bottomAnchor, constant: 4),
            countLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            countLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    func set(itemInfoType: ItemInfoType, withCount count: Int ) {
        symbolImageView.image = UIImage(systemName: itemInfoType.systemImage)
        titleLabel.text = itemInfoType.title
        countLabel.text = String(count)
    }
    
}

#Preview("GF Item Info View"){
    GFItemInfoView()
}
