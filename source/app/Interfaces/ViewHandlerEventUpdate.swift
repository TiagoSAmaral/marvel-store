//
//  ControllerViewHandlerEventUpdate.swift
//  list-store
//
//  Created by Tiago Amaral on 03/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import UIKit

protocol ViewHandlerEventUpdate where Self: UIView {
    var updateContentHandler: (() -> Void)? { get set }
}
