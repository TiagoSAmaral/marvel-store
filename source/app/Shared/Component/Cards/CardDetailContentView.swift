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
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        button.backgroundColor = ColorAsset.titleColor
        button.height(44)
        button.layer.cornerRadius = 6
        button.addTarget(self, action: #selector(bindAddCartAction), for: .touchUpInside)
        
        return button
    }()
    
    lazy var addToFavoriteButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        button.backgroundColor = ColorAsset.ironManYellow
        button.height(44)
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
        defineTopSpace()
        defineImage()
        deinfeTitle()
        defineIssue()
        definePrice()
        defineResume()
        vStackView.addArrangedSubview(addToCartButton)
        vStackView.addArrangedSubview(addToFavoriteButton)
    }
    
    func defineTopSpace() {
        let borderTop = UIView()
        borderTop.height(8)
        borderTop.backgroundColor = ColorAsset.borderColor
        
        let topSpaceOne = UIView()
        topSpaceOne.backgroundColor = ColorAsset.cardBackgroundColor
        topSpaceOne.height(12)
        
        let topSpaceTwo = UIView()
        topSpaceTwo.backgroundColor = ColorAsset.cardBackgroundColor
        topSpaceTwo.height(12)
        
        vStackView.addArrangedSubview(topSpaceOne)
        vStackView.addArrangedSubview(borderTop)
        vStackView.addArrangedSubview(topSpaceTwo)
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
    
    func defineResume() {
        if let resume = makeLabel(with: model?.resume) {
            let backgrounView = UIView()
            vStackView.addArrangedSubview(backgrounView)
            
            resume.textColor = ColorAsset.titleColor
            resume.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
            resume.textAlignment = .center
            resume.constraints.forEach({ $0.isActive = false})
            
            backgrounView.addSubviews([resume])
            resume.centerY(of: backgrounView)
                .centerX(of: backgrounView)
                .width(360)
                .topToTop(of: backgrounView)
                .bottomToBotton(of: backgrounView)
        }
    }
    
    func makeLabel(with text: String?) -> UILabel? {
        guard let text = text else {
            return nil
        }
        let label = UILabel()
        label.attributedText = text.htmlToAttributedString
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
        defineLabelCartButton(sender: addToCartButton)
        defineLabelFavoriteButton(sender: addToFavoriteButton)
    }
    
// MARK: - Card Touch action
    
    @objc func bindAddCartAction(sender: UIButton?) {
        DispatchQueue.main.async { [weak self] in
            if let isIntoCart = self?.model?.isIntoCart, isIntoCart {
                self?.model?.removeCartAction?(self?.model)
            } else {
                self?.model?.addCartAction?(self?.model)
            }
            
            self?.defineLabelCartButton(sender: sender)
        }
    }
    
    func defineLabelCartButton(sender: UIButton?) {
        if let isIntoCart = model?.isIntoCart, isIntoCart {
            sender?.setTitle(LocalizedText.with(tagName: .removeToCart), for: .normal)
        } else {
            sender?.setTitle(LocalizedText.with(tagName: .addToCart), for: .normal)
        }
    }
    
    @objc func addFavorite(sender: UIButton?) {
        DispatchQueue.main.async { [weak self] in
            if let isFavorable = self?.model?.isFavorable, isFavorable {
                self?.model?.removeFavoriteAction?(self?.model)
            } else {
                self?.model?.addFavoriteAction?(self?.model)
            }
            self?.defineLabelFavoriteButton(sender: sender)
        }
    }
    
    func defineLabelFavoriteButton(sender: UIButton?) {
        if let isFavorable = model?.isFavorable, isFavorable {
            sender?.setTitle(LocalizedText.with(tagName: .unMakeFavorite), for: .normal)
        } else {
            sender?.setTitle(LocalizedText.with(tagName: .makeFavorite), for: .normal)
        }
    }
}
