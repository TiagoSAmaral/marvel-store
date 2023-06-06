//
//  FilterYearSelector.swift
//  marvel-store
//
//  Created by Tiago Amaral on 03/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import UIKit

class YearSelectorView: UIView {
    
    private var delegate: YearSelectorViewDataHandlerDelegate?
    private var displayerView: UIView?
    
    private lazy var backgroundViewStackView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var hStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        return stackView
    }()
    
    private lazy var selectorButton: UIButton = {
        let button = FactoryButton.makeDeafaultButton(with: LocalizedText.with(tagName: .activeFilter))
        button.addTarget(self, action: #selector(showFilterAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var selectedValueShowerLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorAsset.titleColor
        label.text = "Todos"
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = ColorAsset.cardBackgroundColor
        setupLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = ColorAsset.cardBackgroundColor
        setupLayout()
    }
    
    func define(delegate: YearSelectorViewDataHandlerDelegate?, displayerView: UIView) {
        self.delegate = delegate
        self.displayerView = displayerView
    }
    
    func setupLayout() {
        self.height(54)
        makeBorder()
        makeConstraintToBackgrounView()
        makeHorizontalStackViewConstraints()
        makeConstraintsLabel()
        makeConstraintButton()
    }
    
    func makeBorder() {
        backgroundViewStackView.layer.borderColor = ColorAsset.borderColor?.cgColor
        backgroundViewStackView.layer.borderWidth = 0.5
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
        hStackView.height(34).centerY(of: self).leadingToSuperview().trailingToSuperview()
    }
    
    func makeConstraintsLabel() {
        hStackView.addArrangedSubview(selectedValueShowerLabel)
    }
    
    func makeConstraintButton() {
        selectorButton.width(80)
        hStackView.addArrangedSubview(selectorButton)
    }
    
    @objc func showFilterAction() {
        guard let displayerView = displayerView,
                let delegate = delegate,
                let listYearFilter = delegate.listYearFilter else {
            return
        }
        setupLayout()
        
        var options: [OptionsPickerView] = []
        for value in listYearFilter {
            options.append(OptionsPickerView(label: value, data: value))
        }
        
        let pickerView = PDPicker(options: options, response: {[weak self]  (picker, data, _)  in
            self?.selectedValueShowerLabel.text = data.label
            
            delegate.receive(value: data.data)
            
            if data.data == delegate.disableFilterOptions {
                picker.onDoneButtonTapped()
            }
        })
        
        pickerView.showPicker(at: displayerView)
    }
}
