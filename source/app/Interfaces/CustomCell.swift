//
//  CustomCell.swift
//  github-person
//
//  Created by Tiago Amaral on 14/05/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import UIKit

protocol GenericCell where Self: UIView {
    var contentView: UIView { get }
    var reuseIdentifier: String? { get }
    func prepareForReuse()
}

extension GenericCell {
    
    var reuseIdentifier: String? {
        Self.identifier
    }
        
    func customPrepareForReuse() {
        contentView.backgroundColor = nil
        contentView.subviews.forEach {
            $0.removeFromSuperview()
        }
    }
}
