//
//  UserListItem.swift
//  github-person
//
//  Created by Tiago Amaral on 15/05/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import UIKit

class CardUserListItemView: UIView, Card, CardTouch {
    
    var action: ((Model?) -> Void)?
    var model: UserDetailProfile?
    
    lazy var nameLabel: UILabel = {
        let label: UILabel = UILabel()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func load(model: Model?) {
        
        guard let model = model as? UserDetailProfile else {
            return
        }
        self.model = model
        nameLabel.text = model.login
        action = model.action
        
        makeNameLabelConstraint()
        defineAction()
    }
    
// MARK: - Apply Constraints
    
    func makeNameLabelConstraint() {
        addSubviews([nameLabel])
        nameLabel.height(60).edgeToSuperView()
    }
    
// MARK: - Card Touch action
    
    func defineAction() {
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(bindAction)))
    }
    
    @objc func bindAction() {
        guard let model = model else {
            return
        }
        action?(model)
    }
}
