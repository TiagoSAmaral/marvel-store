//
//  ListUsersCardFactory.swift
//  list-store
//
//  Created by Tiago Amaral on 14/05/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import UIKit

class CardMaker: CardFactory {
    
    func makeCard(from item: ViewModelBehavior?) -> Card? {
        
        guard let item = item else {
            return nil
        }
        
        switch item.layout {
        case .listContentLayoutCard:
            return CardMaker.make(with: item, classType: CardListContentView.self)
        case .detailContentLayoutCard:
            return CardMaker.make(with: item, classType: CardDetailContentView.self)
        default:
            return nil
        }
    }
    
    static func make<T: Card>(with data: ViewModelBehavior, classType: T.Type) -> T {
        let cardView = T.init()
        cardView.load(model: data)
        return cardView
    }
}
