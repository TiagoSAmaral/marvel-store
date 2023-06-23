//
//  GenericTableViewCell.swift
//  list-store
//
//  Created by Tiago Amaral on 14/05/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import UIKit

class GenericTableViewCell: UITableViewCell, GenericCell {
        
    override func prepareForReuse() {
        super.prepareForReuse()
        customPrepareForReuse()
    }
}
