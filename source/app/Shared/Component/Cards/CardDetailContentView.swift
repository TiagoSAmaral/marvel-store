//
//  CardDetailContentView.swift
//  marvel-store
//
//  Created by Tiago Amaral on 15/05/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import UIKit

class CardDetailContentView: UIView, Card, CardTouch {
    
    var model: Comic?
    
    lazy var vMainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16.0
        return stackView
    }()
    
    lazy var hStackViewProfileImageViewWithNameLogin: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    lazy var vStackViewNameLogin: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        stackView.spacing = .zero
        stackView.alignment = .top
        return stackView
    }()
    
    lazy var vStackViewNetworkLinks: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    lazy var hStackViewFollowers: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        return stackView
    }()
    
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 35.0
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 1.0
        imageView.layer.borderColor = ColorAsset.borderColor?.cgColor
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 24.0, weight: .semibold)
        label.textColor = ColorAsset.titleColor
        label.height(44)
        return label
    }()
    
    lazy var loginLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 20.0, weight: .regular)
        label.textColor = ColorAsset.borderColor
        return label
    }()
    
    lazy var bioDescription: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        label.textColor = ColorAsset.descriptionColor
        label.height(20, relation: .greaterThanOrEqual)
        return label
    }()
    
    lazy var reposButton: UIButton = {
        let button = FactoryButton.makeDeafaultButton(with: LocalizedText.with(tagName: .showRepos))
        button.addTarget(self, action: #selector(bindAction), for: .touchUpInside)
        return button
    }()
    
    func makeLabelNetwork(with text: String?) -> UILabel? {
        guard let text = text else {
            return nil
        }
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        label.textColor = ColorAsset.descriptionColor
        label.height(20)
        return label
    }
    
    func load(model: Model?) {
        
        guard let model = model as? Comic else {
            return
        }
        self.model = model
        nameLabel.text = model.title
        loginLabel.text = "Edition #\(model.issueNumber ?? 0.0)"
        bioDescription.text = model.description
        
        if let path = model.thumbnail?.path, let typeFile = model.thumbnail?.fileExtension {
            let imagePath = "\(path).\(typeFile)"
            profileImageView.kf.setImage(with: URL(string: imagePath))
        }
        addAllSubviews()
        defineAction()
    }
    
    // MARK: - Apply Constraints
    
    func addAllSubviews() {
        makeVMainStackViewConstraint()
        makeHStackViewProfileImageViewWithNameLoginConstraint()
        makeVStackViewNameLoginConstraint()
        makeVStackViewNetworkLinks()
    }
    
    func makeVMainStackViewConstraint() {
        addSubviews([vMainStackView])
        vMainStackView.edgeToSuperView(margin: 8.0)
        vMainStackView.addArrangedSubview(hStackViewProfileImageViewWithNameLogin)
        
//        if let bioText = model?.bioText, !bioText.isEmpty {
//            vMainStackView.addArrangedSubview(bioDescription)
//        }

        vMainStackView.addArrangedSubview(vStackViewNetworkLinks)
                
        let buttonBaseView = UIView()
        buttonBaseView.height(44)
        buttonBaseView.addSubviews([reposButton])
        buttonBaseView.backgroundColor = .clear
        reposButton.height(34)
        reposButton.width(180)
        reposButton.centerY(of: buttonBaseView)
        reposButton.centerX(of: buttonBaseView)
        vMainStackView.addArrangedSubview(buttonBaseView)
    }
    
    func makeHStackViewProfileImageViewWithNameLoginConstraint() {
        
        let baseImageView = UIView()
        baseImageView.addSubviews([profileImageView])
        profileImageView.centerX(of: baseImageView).centerY(of: baseImageView)
        profileImageView.height(70)
        profileImageView.width(70)
        baseImageView.width(90)
        
        hStackViewProfileImageViewWithNameLogin.addArrangedSubview(baseImageView)
        hStackViewProfileImageViewWithNameLogin.addArrangedSubview(vStackViewNameLogin)
    }
    
    func makeVStackViewNameLoginConstraint() {
        vStackViewNameLogin.addArrangedSubview(nameLabel)
        vStackViewNameLogin.addArrangedSubview(loginLabel)
    }
    
    func makeVStackViewNetworkLinks() {
        
//        if let emailLabel = makeLabelNetwork(with: model?.email) {
//            vStackViewNetworkLinks.addArrangedSubview(emailLabel)
//        }
//
//        if let blogLabel = makeLabelNetwork(with: model?.blog) {
//            vStackViewNetworkLinks.addArrangedSubview(blogLabel)
//        }
//
//        if let twitterUsernameLabel = makeLabelNetwork(with: model?.twitterUsername) {
//            vStackViewNetworkLinks.addArrangedSubview(twitterUsernameLabel)
//        }
//
//        if let locationLabel = makeLabelNetwork(with: model?.location) {
//            vStackViewNetworkLinks.addArrangedSubview(locationLabel)
//        }
//
//        if let followsLabel = makeLabelNetwork(with: "\(model?.followers ?? 0) \(LocalizedText.with(tagName: .followers)) • \(model?.following ?? 0) \(LocalizedText.with(tagName: .following))") {
//            vStackViewNetworkLinks.addArrangedSubview(followsLabel)
//        }
    }

// MARK: - Card Touch action
    @objc func bindAction() {
//        guard let  = model else {
//            return
//        }
//        action?(model)
        
        if let selectAction = model?.selectAction {
            
        }
        
        if let puchaseAction = model?.purchaseAction {
            
        }
        
        if let favoriteAction = model?.favoriteAction {
            
        }
    }
}
