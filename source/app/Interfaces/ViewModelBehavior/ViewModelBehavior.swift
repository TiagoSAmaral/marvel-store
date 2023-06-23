//
//  ViewModelBehavior.swift
//  list-store
//
//  Created by Tiago Amaral on 01/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import Foundation
import RealmSwift

protocol ViewModelBehavior: Object, Identificable, Visible, Purchasable, Favorable, Selectable where Self: Model {
//  Allow seter becouse not exist in API and, need adapter into CardFactory
}
