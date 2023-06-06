//
//  CardFactory.swift
//  marvel-store
//
//  Created by Tiago Amaral on 06/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import Foundation

protocol CardFactory {
    func makeCard(from item: ViewModelBehavior?) -> Card?
}
