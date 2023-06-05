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
    
    lazy var vStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.height(400)
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = ColorAsset.cardBackgroundColor
        
        return imageView
    }()
    
    lazy var addToCartButton: UIButton = {
        let button = UIButton()
        button.setTitle(LocalizedText.with(tagName: .addToCart), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        button.backgroundColor = ColorAsset.titleColor
        button.height(44) //.width(120)
        button.layer.cornerRadius = 6
        button.addTarget(self, action: #selector(addCartAction), for: .touchUpInside)
        
        return button
    }()
    
    lazy var addToFavoriteButton: UIButton = {
        let button = UIButton()
        button.setTitle(LocalizedText.with(tagName: .favoriteTitle), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        button.backgroundColor = ColorAsset.ironManYellow
        button.height(44) //.width(120)
        button.layer.cornerRadius = 6
        button.addTarget(self, action: #selector(addFavorite), for: .touchUpInside)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = ColorAsset.cardBackgroundColor
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = ColorAsset.cardBackgroundColor
    }
    
    func makeViewLayout() {
        addSubviews([vStackView])
        vStackView.edgeToSuperView()
        defineImage()
        deinfeTitle()
        defineIssue()
        definePrice()
        vStackView.addArrangedSubview(addToCartButton)
        vStackView.addArrangedSubview(addToFavoriteButton)
    }
    
    func defineImage() {
        vStackView.addArrangedSubview(imageView)
        if let path = model?.thumbnail?.path, let typeFile = model?.thumbnail?.fileExtension {
            let imagePath = "\(path).\(typeFile)"
            imageView.kf.setImage(with: URL(string: imagePath))
        }
    }
    
    func deinfeTitle() {
        if let title = makeLabel(with: model?.title) {
            let backgrounView = UIView()
            vStackView.addArrangedSubview(backgrounView)
            
            title.textColor = ColorAsset.titleColor
            title.font = UIFont.systemFont(ofSize: 22, weight: .bold)
            title.textAlignment = .center
            title.constraints.forEach({ $0.isActive = false})
            
            backgrounView.addSubviews([title])
            title.centerY(of: backgrounView)
                .centerX(of: backgrounView)
                .width(360)
                .topToTop(of: backgrounView)
                .bottomToBotton(of: backgrounView)
        }
    }
    
    func defineIssue() {
        if let value = model?.issueNumber,
           !value.isZero,
           let issueNumber = makeLabel(with: "Issue #\(value)") {
            vStackView.addArrangedSubview(issueNumber)
        }
    }
    
    func makeLabel(with text: String?) -> UILabel? {
        guard let text = text else {
            return nil
        }
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: 18.0, weight: .regular)
        label.textColor = ColorAsset.descriptionColor
        label.height(20)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.allowsDefaultTighteningForTruncation = true
        return label
    }
    
    func definePrice() {
        model?.prices.forEach({ priceItem in
            
            switch priceItem.type {
            case .printPrice:
                if let priceValue = CurrencyConversor.formatFrom(value: priceItem.price),
                   let label = makeLabel(with: "\(LocalizedText.with(tagName: .printPrice)) \(priceValue)") {
                    vStackView.addArrangedSubview(label)
                }
            case .digitalPurchasePrice:
                if let priceValue = CurrencyConversor.formatFrom(value: priceItem.price),
                   let label = makeLabel(with: "\(LocalizedText.with(tagName: .digitalPrice)) \(priceValue)") {
                    vStackView.addArrangedSubview(label)
                }
            default: break
            }
        })
    }
    
    func load(model: Model?) {
        guard let model = model as? Comic else {
            return
        }
        self.model = model
        makeViewLayout()
        defineAction()
    }
    
    // MARK: - Apply Constraints
    
//    func addAllSubviews() {
//        makeVMainStackViewConstraint()
//        makeHStackViewProfileImageViewWithNameLoginConstraint()
//        makeVStackViewNameLoginConstraint()
//        makeVStackViewNetworkLinks()
//    }
//
//    func makeVMainStackViewConstraint() {
//        addSubviews([vMainStackView])
//        vMainStackView.edgeToSuperView(margin: 8.0)
//        vMainStackView.addArrangedSubview(hStackViewProfileImageViewWithNameLogin)
//
////        if let bioText = model?.bioText, !bioText.isEmpty {
////            vMainStackView.addArrangedSubview(bioDescription)
////        }
//
//        vMainStackView.addArrangedSubview(vStackViewNetworkLinks)
//
//        let buttonBaseView = UIView()
//        buttonBaseView.height(44)
//        buttonBaseView.addSubviews([reposButton])
//        buttonBaseView.backgroundColor = .clear
//        reposButton.height(34)
//        reposButton.width(180)
//        reposButton.centerY(of: buttonBaseView)
//        reposButton.centerX(of: buttonBaseView)
//        vMainStackView.addArrangedSubview(buttonBaseView)
//    }
//
//    func makeHStackViewProfileImageViewWithNameLoginConstraint() {
//
//        let baseImageView = UIView()
//        baseImageView.addSubviews([profileImageView])
//        profileImageView.centerX(of: baseImageView).centerY(of: baseImageView)
//        profileImageView.height(70)
//        profileImageView.width(70)
//        baseImageView.width(90)
//
//        hStackViewProfileImageViewWithNameLogin.addArrangedSubview(baseImageView)
//        hStackViewProfileImageViewWithNameLogin.addArrangedSubview(vStackViewNameLogin)
//    }
//
//    func makeVStackViewNameLoginConstraint() {
//        vStackViewNameLogin.addArrangedSubview(nameLabel)
//        vStackViewNameLogin.addArrangedSubview(loginLabel)
//    }
//
//    func makeVStackViewNetworkLinks() {
        
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
//    }

// MARK: - Card Touch action
    
    @objc func addCartAction(sender: UIButton) {
        if let purchaseAction = model?.purchaseAction {
            purchaseAction(model)
        }
    }
    
    @objc func addFavorite(sender: UIButton) {
        if let favoriteAction = model?.favoriteAction {
            favoriteAction(model)
        }
    }
}
