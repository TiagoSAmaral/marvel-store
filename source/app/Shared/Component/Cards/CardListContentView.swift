//
//  CardListContentView.swift
//  marvel-store
//
//  Created by Tiago Amaral on 15/05/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import UIKit
import Kingfisher

class CardListContentView: UIView, Card, CardTouch {

    var model: Comic?
    
    lazy var backgrounHStackView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.borderColor = ColorAsset.borderColor?.cgColor
        view.layer.borderWidth = 1.0
        view.layer.cornerRadius = 6.0
        return view
    }()
    
    lazy var hStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        return stackView
    }()
    
    lazy var vStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10.0
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 1.0
        imageView.layer.borderColor = ColorAsset.borderColor?.cgColor
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        var label: UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 16.0, weight: .semibold)
        label.textColor = ColorAsset.titleColor
        label.numberOfLines = 4
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        layer.cornerRadius = 6.0
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func load(model: Model?) {
        
        guard let model = model as? Comic else {
            return
        }
        self.model = model
        nameLabel.text =  model.title
        
        if let path = model.thumbnail?.path, let typeFile = model.thumbnail?.fileExtension {
            let imagePath = "\(path).\(typeFile)"
            profileImageView.kf.setImage(with: URL(string: imagePath))
        }
        addAllSubviews()
        defineAction()
    }
    
// MARK: - Apply Constraints
    
    func addAllSubviews() {
        addSubviews([backgrounHStackView])
        backgrounHStackView.addSubviews([hStackView])
        makeConstraintBackgroundHStackView()
        makeContraintHStackView()
        makeConstraintProfileImageView()
        makeConstraintVStackView()
        makeConstraintNameLabel()
    }
    
    func makeConstraintBackgroundHStackView() {
        backgrounHStackView.edgeToSuperView(margin: 15)
    }
    
    func makeContraintHStackView() {
        hStackView.edgeToSuperView()
    }
    
    func makeConstraintProfileImageView() {
        
        let baseImageView = UIView()
        baseImageView.addSubviews([profileImageView])
        profileImageView.centerX(of: baseImageView).centerY(of: baseImageView)
        profileImageView.height(100)
        profileImageView.width(70)
        baseImageView.width(90)
        hStackView.addArrangedSubview(baseImageView)
    }
    
    func makeConstraintVStackView() {
        hStackView.addArrangedSubview(vStackView)
    }
    
    func makeConstraintNameLabel() {
        vStackView.addArrangedSubview(nameLabel)
        nameLabel.height(120)
    }

// MARK: - Card Touch action
    
    func defineAction() {
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(bindAction)))
    }
    
    @objc func bindAction() {
        guard let selectionAction = model?.selectAction else {
            return
        }
        selectionAction(model)
    }
}
