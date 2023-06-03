//
//  FilterYearSelector.swift
//  marvel-store
//
//  Created by Tiago Amaral on 03/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import UIKit

protocol YearSelectorViewDelegate {
    func receive(value: Int?)
}

class YearSelectorView: UIView {
    
    private var delegate: YearSelectorViewDelegate?
    
    lazy var backgroundViewStackView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorAsset.cardBackgroundColor
        return view
    }()
    
    lazy var hStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        return stackView
    }()
    
    lazy var selectorButton: UIButton = {
        let button = FactoryButton.makeDeafaultButton(with: LocalizedText.with(tagName: .activeFilter))
        return button
    }()
    
    lazy var selectedValueShowerLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorAsset.titleColor
        label.text = "Todos"
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = ColorAsset.cardBackgroundColor
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func define(delegate: YearSelectorViewDelegate?) {
        self.delegate = delegate
        
    }
    
    func injectAtView(at view: UIView?) {
        
        guard let view = view else {
            return
        }
        
        view.addSubviews([self])
        self.height(44).leadingToSuperview().trailingToSuperview().topToSuperview()
        setupLayout()
    }
    
    func setupLayout() {
        makeBorder()
        makeConstraintToBackgrounView()
        makeHorizontalStackViewConstraints()
        makeConstraintsLabel()
        makeConstraintButton()
    }
    
    func makeBorder() {
        layer.borderColor = ColorAsset.borderColor?.cgColor
        layer.borderWidth = 0.5
    }
    
    // MARK: - Define constraints
    
    func makeConstraintToBackgrounView() {
        addSubviews([backgroundViewStackView])
        backgroundViewStackView
            .leadingToSuperview(margin: 16)
            .trailingToSuperview(margin: 16)
            .topToSuperview()
            .bottomToSuperview()
    }
    
    func makeHorizontalStackViewConstraints() {
        backgroundViewStackView.addSubviews([hStackView])
        hStackView.edgeToSuperView()
    }
    
    func makeConstraintsLabel() {
        hStackView.addArrangedSubview(selectedValueShowerLabel)
    }
    
    func makeConstraintButton() {
        selectorButton.width(80)
        hStackView.addArrangedSubview(selectorButton)
    }
}
