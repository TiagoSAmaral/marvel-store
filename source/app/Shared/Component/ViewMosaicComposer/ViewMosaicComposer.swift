//
//  ViewComposer.swift
//  list-store
//
//  Created by Tiago Amaral on 03/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import UIKit

class ViewMosaicComposer {
    
    lazy var baseView: UIView = {
        var view = UIView()
        view.backgroundColor = ColorAsset.cardBackgroundColor
        return view
    }()
    
    lazy var vStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    init() {
        makeConstraint()
    }
    
    func insertNew(view: UIView) {
        vStackView.addArrangedSubview(view)
    }
    
    func makeConstraint() {
        baseView.addSubviews([vStackView])
        vStackView.edgeToSuperView()
    }
}
