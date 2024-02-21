//
//  GFEmptyView.swift
//  GithubFollowers
//
//  Created by loratech on 19/02/24.
//

import UIKit

class GFEmptyStateView: UIView {
    
    let messageLabel = GFTitleLabel(textAlignment: .center, fontSize: 28)
    let logoImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    convenience init(message: String){
        self.init(frame: .zero)
        messageLabel.text = message 
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func configureMessageLabel() {
        addSubview(messageLabel)
        
        messageLabel.numberOfLines = 3
        messageLabel.textColor = .secondaryLabel
        
        messageLabel.text = "There's no followers on your Github account!"
        
        let labelCenterYConstant: CGFloat = DeviceType.isiPhoneSE || DeviceType.isiPhone8PlusZoomed ? -50 : -150
        let messageLabelCenterYConstraint = messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: labelCenterYConstant)
        messageLabelCenterYConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            messageLabel.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    fileprivate func configureLogoImageView() {
        addSubview(logoImageView) 
        
        let logoBottomConstant: CGFloat = DeviceType.isiPhoneSE || DeviceType.isiPhone8PlusZoomed ? 100 : 40
        let logoImageViewBottomConstraint = logoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: logoBottomConstant)
        logoImageViewBottomConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            logoImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            logoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 200),
            
        ])
    }
    
    private func configure() {
        configureLogoImageView()
        configureMessageLabel()
    }
    
}

#Preview("GF Empty View"){
    GFEmptyStateView()
}
