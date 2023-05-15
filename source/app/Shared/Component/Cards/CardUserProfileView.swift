//
//  CardUserProfileView.swift
//  github-person
//
//  Created by Tiago Amaral on 15/05/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import UIKit

class CardUserProfileView: UIView, Card, CardTouch {
    
    var action: ((Model?) -> Void)?
    var model: UserDetailProfile?
    
    lazy var vStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        
        return stackView
    }()
    
    lazy var nameLabel: UILabel = {
        let label: UILabel = UILabel()
        return label
    }()
    
    lazy var reposButton: UIButton = {
        let button = UIButton()
        button.setTitle(LocalizedText.with(tagName: .showRepos), for: .normal)
        button.addTarget(self, action: #selector(bindAction), for: .touchUpInside)
        button.setTitleColor(.systemBlue, for: .normal)
        button.backgroundColor = .cyan
        return button
    }()
        
    func load(model: Model?) {
        
        guard let model = model as? UserDetailProfile else {
            return
        }
        self.model = model
        nameLabel.text = model.login
        action = model.action
        
        makeVstackViewConstraint()
        addArrangedSubviewToStackView()
        defineAction()
    }

// MARK: - Apply Constraints
    
    func makeVstackViewConstraint() {
        addSubviews([vStackView])
        vStackView.height(300).edgeToSuperView()
    }
    
    func addArrangedSubviewToStackView() {
        
        vStackView.addArrangedSubview(nameLabel)
        vStackView.addArrangedSubview(reposButton)
    }
    
// MARK: - Card Touch action
    
    @objc func bindAction() {
        guard let model = model else {
            return
        }
        action?(model)
    }
}
