//
//  FactoryPage.swift
//  github-person
//
//  Created by Tiago Amaral on 13/05/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import UIKit

protocol FactoryPage: AnyObject {
    static func makePage(coordinator: Coordinator?, model: Model?) -> UIViewController?
}
