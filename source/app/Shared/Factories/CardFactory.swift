//
//  ListUsersCardFactory.swift
//  marvel-store
//
//  Created by Tiago Amaral on 14/05/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import UIKit

protocol CardFactory {
    func makeCard(from item: ViewModelBehavior?) -> Card?
}

class CardMaker: CardFactory {
    
    func makeCard(from item: ViewModelBehavior?) -> Card? {
        
        guard let item = item else {
            return nil
        }
        
        switch item.layout {
        case .listContentLayoutCard:
            return CardMaker.make(with: item, classType: CardUserListItemView.self)
//        case .repoListItem:
//            return CardMaker.make(with: item, classType: CardRepoListItemView.self)
        case .detailContentLayoutCard:
            return CardMaker.make(with: item, classType: CardUserProfileView.self)
        default:
            return nil
        }
    }
    
    static func make<T: Card>(with data: ViewModelBehavior, classType: T.Type) -> T {
        let cardView = T.init()
        cardView.load(model: data as? Model)
        return cardView
    }
}
