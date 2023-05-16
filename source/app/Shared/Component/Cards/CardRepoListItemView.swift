//
//  CardRepoListView.swift
//  github-person
//
//  Created by Tiago Amaral on 15/05/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import UIKit

class CardRepoListItemView: UIView, Card, CardTouch {
    
    var action: ((Model?) -> Void)?
    var model: RepoListemItem?
    
    lazy var baseView: UIView = {
       let view = UIView()
        view.backgroundColor = .clear
        view.layer.borderColor = ColorAsset.borderColor?.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 6.0
        return view
    }()
        
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
        return label
    }()
    
    lazy var reposButton: UIButton = {
        let button = UIButton()
        button.setTitle(LocalizedText.with(tagName: .openRepo), for: .normal)
        button.addTarget(self, action: #selector(bindAction), for: .touchUpInside)
        button.setTitleColor(.systemBlue, for: .normal)
        button.backgroundColor = .clear
        button.layer.borderColor = ColorAsset.borderColor?.cgColor
        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = 6.0
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
        
        guard let model = model as? RepoListemItem else {
            return
        }
        self.model = model
        nameLabel.text = model.name
        loginLabel.text = model.language
        bioDescription.text = model.description
        
        action = model.action
        
        addAllSubviews()
        defineAction()
    }
    
    // MARK: - Apply Constraints
    
    func addAllSubviews() {
        makeVMainStackViewConstraint()
        makeHStackViewNameLoginConstraint()
        makeVStackViewNameLoginConstraint()
        makeVStackViewNetworkLinks()
    }
    
    func makeVMainStackViewConstraint() {
        
        addSubviews([baseView])
        baseView.edgeToSuperView(margin: 8)
        baseView.addSubviews([vMainStackView])
        
        
//        addSubviews([vMainStackView])
//        vMainStackView.edgeToSuperView(margin: 8.0)
        vMainStackView.edgeToSuperView(margin: 8.0)
        vMainStackView.addArrangedSubview(hStackViewProfileImageViewWithNameLogin)
        
        if let descriptionText = model?.description, !descriptionText.isEmpty {
            vMainStackView.addArrangedSubview(bioDescription)
        }

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
    
    func makeHStackViewNameLoginConstraint() {

        hStackViewProfileImageViewWithNameLogin.addArrangedSubview(vStackViewNameLogin)
    }
    
    func makeVStackViewNameLoginConstraint() {
        vStackViewNameLogin.addArrangedSubview(nameLabel)
        vStackViewNameLogin.addArrangedSubview(loginLabel)
    }
    
    func makeVStackViewNetworkLinks() {
        
        if let visibilityLabel = makeLabelNetwork(with: "👀    \(model?.visibility?.capitalized ?? "")") {
            vStackViewNetworkLinks.addArrangedSubview(visibilityLabel)
        }
        
        if let startsCountLabel = makeLabelNetwork(with: "✭     \(model?.startsCount ?? 0)") {
            vStackViewNetworkLinks.addArrangedSubview(startsCountLabel)
        }
        
        if let forksCountLabel = makeLabelNetwork(with: "⑂      \(model?.forksCount ?? 0)" ) {
            vStackViewNetworkLinks.addArrangedSubview(forksCountLabel)
        }
        
        if let languageLabel = makeLabelNetwork(with: "📚   \(model?.language?.capitalized ?? "")") {
            vStackViewNetworkLinks.addArrangedSubview(languageLabel)
        }
    }

// MARK: - Card Touch action
    @objc func bindAction() {
        guard let model = model else {
            return
        }
        action?(model)
    }
}
