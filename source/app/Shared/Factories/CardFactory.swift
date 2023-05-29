//
//  ListUsersCardFactory.swift
//  marvel-store
//
//  Created by Tiago Amaral on 14/05/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import UIKit

protocol CardFactory {
    func makeCard(from item: Model) -> Card?
}

class CardMaker: CardFactory {
    
    func makeCard(from item: Model) -> Card? {
        
        switch item.layout {
        case .userListItem:
            return CardMaker.make(with: item, classType: CardUserListItemView.self)
        case .repoListItem:
            return CardMaker.make(with: item, classType: CardRepoListItemView.self)
        case .userInfo:
            return CardMaker.make(with: item, classType: CardUserProfileView.self)
        case .none:
            return nil
        }
    }
    
    static func make<T: Card>(with data: Model, classType: T.Type) -> T {
        let cardView = T.init()
        cardView.load(model: data)
        return cardView
    }
}
